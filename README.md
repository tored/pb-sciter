# pb-sciter
[PureBasic](https://www.purebasic.com/) bindings for [Sciter](https://sciter.com/)

## Support

Bindings support Windows and Linux. It should be theoretically possible to add MacOS support.

## Installation

* Download the [Sciter SDK](https://sciter.com/download/)
* Extract dynamic library (ddl/dylib/so) for your platform (`bin/<platform>/<architecture>`)
* Copy all sources under `src/` from this project to your project

## Embedding

Sciter can be [embedded](https://sciter.com/developers/embedding-principles/) in two ways, either Sciter
creates the window or attach Sciter to an existing window, this integration focus on the latter, thus we can reuse
PureBasic event loop. It should be possible to use the former integration method, however then you need to write
your own event loop for each platform.

### Example

`example.pb`
```
EnableExplicit

IncludeFile "src/sciter.pbi"

Define libraryPath.s
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  libraryPath = "sciter.dll"
CompilerElseIf #PB_Compiler_OS = #PB_OS_Linux
  libraryPath = "libsciter-gtk.so"
CompilerElseIf #PB_Compiler_OS = #PB_OS_MacOS
  libraryPath = "libsciter.dylib"
CompilerElse
  CompilerError "OS is not supported"
CompilerEndIf

If Not SciterInit(libraryPath)
  Debug "Failed loading Sciter dynamic library"
  End
EndIf

; Attach to inspector, only works on Windows at the moment
SciterSetOption(#Null, #SCITER_SET_DEBUG_MODE, #True)

; Output any messages from sciter to Debug
Procedure DebugOutPut(*param, subsystem.C_UINT, severity.C_UINT, *text, text_length.C_UINT)
  Debug PeekS(*text, text_length)
EndProcedure
SciterSetupDebugOutput(#Null, #Null, @DebugOutPut())

CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  Procedure WindowCallback(hwnd, msg, wParam, lParam)
    Protected result
    Protected handled

    result = SciterProcND(hwnd, msg, wParam, lParam, @handled)
    If handled
      ProcedureReturn result
    EndIf
    ProcedureReturn #PB_ProcessPureBasicEvents
  EndProcedure
  SetWindowCallback(@WindowCallback())
CompilerEndIf

Define window = OpenWindow(#PB_Any, 40, 40, 530, 580, "Sciter", #PB_Window_SizeGadget | #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget)
If Not window
  Debug "Failed opening window"
  End
EndIf

Define *windowHandle = WindowID(window)
Global *sciterHandle = *windowHandle

CompilerIf #PB_Compiler_OS = #PB_OS_Linux
  Define *widgetHandle = SciterCreateWidget(#Null)
  Define *childHandle = gtk_bin_get_child_(*windowHandle)
  ; GtkWindow already has a GtkBox attached, remove it
  gtk_container_remove_(*windowHandle, *childHandle);
  gtk_container_add_(*windowHandle, *widgetHandle)
  gtk_widget_show_(*widgetHandle)
  *sciterHandle = *widgetHandle
CompilerElseIf #PB_Compiler_OS = #PB_OS_MacOS
  Define *nsView = SciterCreateNSView(#Null)
  CompilerError "TODO attach to *windowHandle"
  *sciterHandle = *nsView
CompilerEndIf

; Begin expose HelloWorld() to JavaScript
Procedure.s HelloWorld(name.s)
  ProcedureReturn "Hello " + name + "!"
EndProcedure

; Invokes HelloWorld()
Procedure InvokeHelloWorld(*tag, argc.C_UINT, *argv, *retval.SciterValue)
  Protected *value.SciterValue, *buffer, len.C_UINT, str.s
  *value = *argv
  SciterValueStringData(*value, @*buffer, @len)
  str = PeekS(*buffer, len)
  str = HelloWorld(str)
  SciterValueStringDataSet(*retval, str, #Null)
EndProcedure

Procedure ReleaseHelloWorld(*tag)
  ; nothing to release
EndProcedure

; Functor value for invoke and release
Define func.SciterValue
SciterValueInit(@func)
SciterValueNativeFunctorSet(@func, @InvokeHelloWorld(), @ReleaseHelloWorld(), #Null)

; Name for functor
Define funcName.SciterValue
SciterValueInit(@funcName)
SciterValueStringDataSet(@funcName, "helloWorld", #Null)

; Namespace for our app
Define namespace.SciterValue
SciterValueInit(@namespace)
SciterValueSetValueToKey(@namespace, @funcName, @func)
SciterSetVariable(#Null, "app", @namespace)
; End expose HelloWorld() to JavaScript

; Read file into *buffer
Procedure.i FileReadAllToBuffer(path.s, *buffer.Integer)
  Protected file, len.q, bytes, *mem

  file = ReadFile(#PB_Any, path, #PB_File_SharedRead)
  If Not file
    ProcedureReturn -1
  EndIf

  len = Lof(file)
  *mem = AllocateMemory(len)
  If Not *buffer
    CloseFile(file)
    ProcedureReturn -2
  EndIf

  bytes = ReadData(file, *mem, len)
  If bytes = 0
    FreeMemory(*mem)
  EndIf

  *buffer\i = *mem
  CloseFile(file)
  ProcedureReturn bytes
EndProcedure

Structure AsyncFile
  uri.s
  path.s
  requestId.i
EndStructure

; Loads resources from another thread
Procedure AsyncLoader(*asyncFile.AsyncFile)
  Protected *buffer
  Protected bytes = FileReadAllToBuffer(*asyncFile\path, @*buffer)
  If bytes <= 0
    Debug "Error reading file " + *asyncFile\path
    End
  EndIf

  If Not SciterDataReadyAsync(*sciterHandle, @*asyncFile\uri , *buffer, bytes, *asyncFile\requestId)
    Debug "Failed asynchronously loading resource " + *asyncFile\uri
  EndIf
  FreeMemory(*buffer)
  FreeStructure(*asyncFile)
EndProcedure

; Sciter callback
Procedure.C_UINT AppCallback(*pns.SciterCallbackNotification, *callbackParam)
  Debug "Callback happened with code " + *pns\code

  ; Sciter tries to load a resource, e.g. scripts, images etc, need to tell how
  If *pns\code = #SCITER_SC_LOAD_DATA
    Protected *loadData.SciterScnLoadData = *pns
    Protected uri.s = PeekS(*loadData\uri)

    Protected filePrefix.s = "file://"
    Protected filePrefixLen = Len(filePrefix)
    ; resources a prefixed with uri scheme, you can have your own schemes
    If PeekS(@uri, filePrefixLen) = filePrefix
      Protected path.s = PeekS(@uri + (filePrefixLen * SizeOf(Character)))

      ; resources can be loaded asynchronously (from another thread) or synchronously (blocking)
      If *loadData\dataType = #SCITER_RT_DATA_IMAGE
        ; asynchronous loading of resources

        Protected *asyncFile.AsyncFile = AllocateStructure(AsyncFile)
        If Not *asyncFile
          Debug "Failed allocating AsyncFile"
        EndIf
        *asyncFile\uri = uri
        *asyncFile\path = path
        *asyncFile\requestId = *loadData\requestId

        ; naive way by creating a new thread for each resource, thread pooling is probably preferable
        If Not CreateThread(@AsyncLoader(), *asyncFile)
          Debug "Failed creating thread"
          End
        EndIf
        ProcedureReturn #SCITER_LOAD_DELAYED
      Else
        ; synchronous loading of resources

        Protected *buffer
        Protected bytes = FileReadAllToBuffer(path, @*buffer)
        If bytes <= 0
          Debug "Error reading file " + path
          End
        EndIf
        If Not SciterDataReady(*sciterHandle, @uri , *buffer, bytes)
          Debug "Failed synchronously loading resource " + uri
        EndIf
        FreeMemory(*buffer)
        ProcedureReturn #SCITER_LOAD_OK
      EndIf
    EndIf
  EndIf
  ProcedureReturn #SCITER_LOAD_OK
EndProcedure
SciterSetCallback(*sciterHandle, @AppCallback(), #Null)

If Not SciterLoadFile(*sciterHandle, "example.html")
  Debug "Failed loading html"
  End
EndIf

Repeat
  Select WaitWindowEvent()
    Case #PB_Event_CloseWindow
      End
  EndSelect
ForEver
```

`example.html`
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Example</title>
    <script src="example.js"></script>
    <script>
    document.on("DOMContentLoaded", function() {
        renderHelloWorld();
    });
    </script>
</head>
<body>
<h1></h1>
<img src="example.svg">
</body>
</html>
```
`example.js`
```
function renderHelloWorld() {
    document.querySelector("h1").innerText = app.helloWorld("World");
}
```

`example.svg`
```
<!-- CC0 license -->
<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
<path style="fill:#25B6D2;" d="M0,260.908l174.648-81.136v38.568l-132.08,57.848v0.728l132.08,57.848v38.568L0,292.212V260.908z"/>
<path style="fill:#415E72;" d="M201.6,387.9l77.864-263.8h36.752L238.4,387.9H201.6z"/>
<path style="fill:#E04F5F;" d="M512,293.284L337.352,373.34v-38.568l134.992-57.848v-0.728L337.352,218.34v-38.568L512,259.828
	V293.284z"/>
<g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g>
</svg>
```

`example.js` will be loaded synchronously but `example.svg` will be loaded asynchronously.

## Bindings

Bindings consist of two different parts, a High-Level API and a Low-Level API.

### High-Level API

Located in `src/sciter.pbi`, consist of procedures and macros that wraps the Low-Level API, goal is to adapt
the Low-Level API to be more ergonomic for PureBasic usage, e.g. help with handling string lengths for the correct character encoding. Names of procedures and macros always begins with `Sciter` to follow naming conventions what is commonly used for bindings in other languages, e.g. `SciterLoadHtml(...)`. The High-Level API uses a global `*sciter.Sciter` instance against the Low-Level API. The High-Level API is incomplete.

### Low-Level API

Located in `src/sciterapi.pbi`, works directly against what is exported from the Sciter dynamic library. Sciter [exports](https://github.com/c-smile/sciter-js-sdk/blob/main/include/sciter-x-api.h) a function `SciterAPI()` that returns a struct, property names within the PureBasic structure does not always follow the original names from the C struct, properties are *never* prefixed with `Sciter` as they are sometimes done in the original, e.g. instead of property named `SciterClassName` it is named `ClassName` in the Low-Level API, this generally works better, compare `*sciter\ClassName()` instead of `*sciter\SciterClassName()` but it also plays well with High-Level API macros.

Constants are always prefixed with `SCITER_` and structures with `Sciter` to avoid naming coalitions. It is possible to mix the High-Level API and the Low-Level API within the same project *if* the same `*sciter` instance is used. The Low-Level API is complete except for prototype parameters that may be of the wrong type.

## Contributing

Make sure your PureBasic IDE does *not* store [settings within the source file](https://www.purebasic.com/documentation/reference/ide_preferences.html).

## License

pb-sciter is released under the BSD 3-Clause License, see the bundled file LICENSE.
BSD 3-Clause License is the same license used by the [sdk-js-sciter](https://github.com/c-smile/sciter-js-sdk) project.
