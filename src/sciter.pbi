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

Macro SciterStringToAscii(in, out)
  out = Space(Len(in) / SizeOf(Character) + 1)
  PokeS(@out, in, #PB_Default, #PB_Ascii)
EndMacro

Macro SciterDataReady(hwnd, uri, Dat, dataLength)
  *sciter\DataReady(hwnd, uri, Dat, dataLength)
EndMacro

Macro SciterDataReadyAsync(hwnd, uri, Dat, dataLength, requestId)
  *sciter\DataReadyAsync(hwnd, uri, Dat, dataLength, requestId)
EndMacro

Macro SciterProcND(hwnd, msg, wParam, lParam, handled)
  *sciter\ProcND(hwnd, msg, wParam, lParam, handled)
EndMacro

Macro SciterLoadFile(hWndSciter, filename)
  *sciter\LoadFile(hWndSciter, @filename)
EndMacro

Macro SciterLoadHtml(hWndSciter, html, baseUrl)
  *sciter\LoadHtml(hWndSciter, html, StringByteLength(html, #PB_UTF8), @baseUrl)
EndMacro

Macro SciterSetCallback(hWndSciter, cb, cbParam)
  *sciter\SetCallback(hWndSciter, cb, cbParam)
EndMacro

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

Macro SciterValueInit(pval)
  *sciter\ValueInit(pval)
EndMacro

Macro SciterValueStringData(pval, pChars, pNumChars)
  *sciter\ValueStringData(pval, pChars, pNumChars)
EndMacro

Macro SciterValueStringDataSet(pval, chars, units)
  *sciter\ValueStringDataSet(pval, chars, StringByteLength(chars, #PB_UTF8), units)
EndMacro

Macro SciterValueIntData(pval, pData)
  *sciter\ValueIntData(pval, pData)
EndMacro

Macro SciterValueIntDataSet(pval, Dat, type, units)
  *sciter\ValueIntDataSet(pval, Dat, type, units)
EndMacro

Macro SciterValueSetValueToKey(pval, pkey, pval_to_set)
  *sciter\ValueSetValueToKey(pval, pkey, pval_to_set)
EndMacro

Macro SciterValueNativeFunctorSet(pval, pinvoke, prelease, tag)
  *sciter\ValueNativeFunctorSet(pval, pinvoke, prelease, tag)
EndMacro

Procedure SciterSetVariable(*hwndOrNull, name.s, *pvalToSet.SciterValue)
  Protected str.s
  SciterStringToAscii(name, str)
  *sciter\SetVariable(*hwndOrNull, @str, *pvalToSet)
EndProcedure
