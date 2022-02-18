# pb-sciter
PureBasic bindings for Sciter

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

Define window = OpenWindow(#PB_Any, 30, 30, 480, 320, "Sciter", #PB_Window_SizeGadget | #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget)
If Not window
  Debug "Failed opening window"
  End
EndIf

Define *windowHandle = WindowID(window)
Define *sciterHandle = *windowHandle

CompilerIf #PB_Compiler_OS = #PB_OS_Linux
  Define *widgetHandle = SciterCreateWidget(#Null)
  ; GtkWindow already has a GtkBox attached, remove it
  Define *childHandle = gtk_bin_get_child_(*windowHandle)
  gtk_container_remove_(*windowHandle, *childHandle);
  gtk_container_add_(*windowHandle, *widgetHandle)
  gtk_widget_show_(*widgetHandle)
  *sciterHandle = *widgetHandle
CompilerElseIf #PB_Compiler_OS = #PB_OS_MacOS
  Define *nsView = SciterCreateNSView(#Null)
  CompilerError "TODO attach to *windowHandle"
  *sciterHandle = *nsView
CompilerEndIf

Procedure AppCallback(*pns.SciterCallbackNotification, callbackParam)
  Debug "Callback happened with code " + *pns\code
  ProcedureReturn 0
EndProcedure
SciterSetCallback(*sciterHandle, @AppCallback(), #Null)

If Not SciterLoadHtml(*sciterHandle, "<html><body>Hello, World!</body></html>", "")
  Debug "Failed loading html"
  End
EndIf

Repeat
  Select WaitWindowEvent()
    Case #PB_Event_CloseWindow
      End
  EndSelect
ForEver

SciterFree()
```

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
BSD 3-Clause License is the same license used by the `sdk-js-sciter` project.
