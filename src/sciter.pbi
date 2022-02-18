XIncludeFile "sciterapi.pbi"

Prototype SciterAPI()

Global sciterLibrary
Global *sciter.Sciter

Procedure SciterInit(libraryPath.s)
  Protected api.SciterAPI
  sciterLibrary = OpenLibrary(#PB_Any, libraryPath)
  If Not sciterLibrary
    ProcedureReturn #False
  EndIf
  api = GetFunction(sciterLibrary, "SciterAPI")
  If api = 0
    ProcedureReturn #False
  EndIf
  *sciter = api()
  ProcedureReturn #True
EndProcedure

Procedure SciterFree()
  CloseLibrary(sciterLibrary)
EndProcedure

Macro SciterProcND(hwnd, msg, wParam, lParam, handled)
  *sciter\ProcND(hwnd, msg, wParam, lParam, handled)
EndMacro

Macro SciterLoadFile(hWndSciter, filename)
  *sciter\LoadFile(hWndSciter, @filename)
EndMacro

Macro SciterLoadHtml(hWndSciter, html, baseUrl)
  *sciter\LoadHtml(hWndSciter, html, StringByteLength(html, #PB_UTF8), @baseUrl)
EndMacro

Procedure SciterSetCallback(hWndSciter, cb.SciterHostCallback, cbParam)
  *sciter\SetCallback(hWndSciter, cb, cbParam)
EndProcedure

Macro SciterSetOption(hWnd, option, value)
  *sciter\SetOption(hWnd, option, value)
EndMacro

CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
  Macro SciterCreateNSView(frame)
    *sciter\CreateNSView(frame)
  EndMacro
CompilerEndIf

CompilerIf #PB_Compiler_OS = #PB_OS_Linux
  Macro SciterCreateWidget(frame)
    *sciter\CreateWidget(frame)
  EndMacro
CompilerEndIf
