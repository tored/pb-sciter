#SCITER_SET_DEBUG_MODE = 10

#SCITER_SC_LOAD_DATA = $01
#SCITER_SC_DATA_LOADED = $02
#SCITER_SC_ATTACH_BEHAVIOR = $04
#SCITER_SC_ENGINE_DESTROYED = $05
#SCITER_SC_POSTED_NOTIFICATION = $06
#SCITER_SC_GRAPHICS_CRITICAL_FAILURE = $07
#SCITER_SC_KEYBOARD_REQUEST = $08
#SCITER_SC_INVALIDATE_RECT = $09

Enumeration SCITER_SC_LOAD_DATA_RETURN_CODES
  #SCITER_LOAD_OK      = 0  ; do Default loading If Data Not set
  #SCITER_LOAD_DISCARD = 1  ; discard request completely
  #SCITER_LOAD_DELAYED = 2  ; Data will be delivered later by the host application.
                            ; Host application must call SciterDataReadyAsync(,,, requestId) on each LOAD_DELAYED request To avoid memory leaks.
  #SCITER_LOAD_MYSELF  = 3  ; you Return LOAD_MYSELF result To indicate that your (the host) application took Or will take care about HREQUEST in your code completely.
                            ; Use sciter-x-request.h[pp] API functions With SCN_LOAD_DATA::requestId handle .
EndEnumeration

Enumeration SCITER_RESOURCE_TYPE
  #SCITER_RT_DATA_HTML        = 0
  #SCITER_RT_DATA_IMAGE       = 1
  #SCITER_RT_DATA_STYLE       = 2
  #SCITER_RT_DATA_CURSOR      = 3
  #SCITER_RT_DATA_SCRIPT      = 4
  #SCITER_RT_DATA_RAW         = 5
  #SCITER_RT_DATA_FONT
  #SCITER_RT_DATA_SOUND                    ; wav bytes
  #SCITER_RT_DATA_FORCE_DWORD = $ffffffff
EndEnumeration

Enumeration SCITER_CREATE_WINDOW_FLAGS
  #SCITER_SW_CHILD        = (1 << 0)    ; child window only, If this flag is set all other flags ignored
  #SCITER_SW_TITLEBAR     = (1 << 1)    ; toplevel window, has titlebar
  #SCITER_SW_RESIZEABLE   = (1 << 2)    ; has resizeable frame
  #SCITER_SW_TOOL         = (1 << 3)    ; is tool window
  #SCITER_SW_CONTROLS     = (1 << 4)    ; has minimize / maximize buttons
  #SCITER_SW_GLASSY       = (1 << 5)    ; glassy window - supports "Acrylic" on Windows And "Vibrant" on MacOS.
  #SCITER_SW_ALPHA        = (1 << 6)    ; transparent window ( e.g. WS_EX_LAYERED on Windows )
  #SCITER_SW_MAIN         = (1 << 7)    ; main window of the app, will terminate the app on close
  #SCITER_SW_POPUP        = (1 << 8)    ; the window is created As topmost window.
  #SCITER_SW_ENABLE_DEBUG = (1 << 9)    ; make this window inspector ready
  #SCITER_SW_OWNS_VM      = (1 << 10)   ; it has its own script VM
EndEnumeration

#SCITER_SCDOM_OK                = 0
#SCITER_SCDOM_INVALID_HWND      = 1
#SCITER_SCDOM_INVALID_HANDLE    = 2
#SCITER_SCDOM_PASSIVE_HANDLE    = 3
#SCITER_SCDOM_INVALID_PARAMETER = 4
#SCITER_SCDOM_OPERATION_FAILED  = 5
#SCITER_SCDOM_OK_NOT_HANDLED    = -1

Enumeration SCITER_VALUE_RESULT
  #SCITER_HV_OK_TRUE = -1
  #SCITER_HV_OK = 0
  #SCITER_HV_BAD_PARAMETER = 1
  #SCITER_HV_INCOMPATIBLE_TYPE = 2
EndEnumeration

Enumeration SCITER_VALUE_TYPE
  #SCITER_T_UNDEFINED  = 0
  #SCITER_T_NULL       = 1
  #SCITER_T_BOOL       = 2
  #SCITER_T_INT        = 3
  #SCITER_T_FLOAT      = 4
  #SCITER_T_STRING     = 5
  #SCITER_T_DATE       = 6   ; INT64 - contains a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC), a.k.a. FILETIME on Windows
  #SCITER_T_CURRENCY   = 7   ; INT64 - 14.4 fixed number. E.g. dollars = int64 / 10000;
  #SCITER_T_LENGTH     = 8   ; length units, value is int Or float, units are VALUE_UNIT_TYPE
  #SCITER_T_ARRAY      = 9
  #SCITER_T_MAP        = 10
  #SCITER_T_FUNCTION   = 11  ; named tuple , like Array but With name tag
  #SCITER_T_BYTES      = 12  ; sequence of bytes - e.g. image Data
  #SCITER_T_OBJECT     = 13  ; scripting object proxy (TISCRIPT/SCITER)
                             ; #SCITER_T_DOM_OBJECT = 14,  ; DOM object, use get_object_data To get HELEMENT
  #SCITER_T_RESOURCE   = 15  ; 15 - other thing derived from tool::resource
                             ; #SCITER_T_RANGE      = 16  ; 16 - N..M, integer range.
  #SCITER_T_DURATION   = 17  ; double, seconds
  #SCITER_T_ANGLE      = 18  ; double, radians
  #SCITER_T_COLOR      = 19  ; [unsigned] INT, ABGR
  #SCITER_T_ASSET      = 21  ; sciter::om::iasset* add_ref'ed pointer
EndEnumeration

Enumeration SCITER_VALUE_UNIT_TYPE
  #SCITER_UT_EM             = 1   ; height of the element's font.
  #SCITER_UT_EX             = 2   ; height of letter 'x'
  #SCITER_UT_PR             = 3   ; %
  #SCITER_UT_SP             = 4   ; %% "springs", a.k.a. flex units
  #SCITER_UT_reserved1      = 5
  #SCITER_UT_reserved2      = 6
  #SCITER_UT_PX             = 7   ; pixels
  #SCITER_UT_IN             = 8   ; inches (1 inch = 2.54 centimeters).
  #SCITER_UT_CM             = 9   ; centimeters.
  #SCITER_UT_MM             = 10  ; millimeters.
  #SCITER_UT_PT             = 11  ; points (1 point = 1/72 inches).
  #SCITER_UT_PC             = 12  ; picas (1 pica = 12 points).
  #SCITER_UT_DIP            = 13
  #SCITER_UT_reserved3      = 14
  #SCITER_UT_reserved4      = 15
  #SCITER_UT_PR_WIDTH       = 16  ; width(n%)
  #SCITER_UT_PR_HEIGHT      = 17  ; height(n%)
  #SCITER_UT_PR_VIEW_WIDTH  = 18  ; vw
  #SCITER_UT_PR_VIEW_HEIGHT = 19  ; vh
  #SCITER_UT_PR_VIEW_MIN    = 20  ; vmin
  #SCITER_UT_PR_VIEW_MAX    = 21  ; vmax
  #SCITER_UT_REM            = 22  ; root em
  #SCITER_UT_PPX            = 23  ; physical px
  #SCITER_UT_CH             = 24  ; width of '0'
EndEnumeration

Enumeration SCITER_MOUSE_EVENTS
  #SCITER_MOUSE_ENTER = 0
  #SCITER_MOUSE_LEAVE
  #SCITER_MOUSE_MOVE
  #SCITER_MOUSE_UP
  #SCITER_MOUSE_DOWN
  #SCITER_MOUSE_DCLICK              ; double click
  #SCITER_MOUSE_WHEEL
  #SCITER_MOUSE_TICK                ; mouse pressed ticks
  #SCITER_MOUSE_IDLE                ; mouse stay idle For some time
  #SCITER_MOUSE_TCLICK = $F         ; tripple click
  #SCITER_MOUSE_TOUCH_START = $FC   ; touch device pressed somehow
  #SCITER_MOUSE_TOUCH_END = $FD     ; touch device depressed - clear, nothing on it
  #SCITER_MOUSE_DRAG_REQUEST = $FE  ; mouse drag start detected event
  #SCITER_MOUSE_CLICK = $FF         ; mouse click event
  #SCITER_MOUSE_HIT_TEST = $FFE     ; sent To element, allows To handle elements With non-trivial shapes.
EndEnumeration

Enumeration SCITER_MOUSE_BUTTONS
  #SCITER_MAIN_MOUSE_BUTTON = 1     ; aka left button
  #SCITER_PROP_MOUSE_BUTTON = 2     ; aka right button
  #SCITER_MIDDLE_MOUSE_BUTTON = 4
EndEnumeration

Macro C_UINT
  l
EndMacro

Macro C_UINT64
  q
EndMacro

Macro C_INT
  l
EndMacro

Macro C_SBOOL
  l
EndMacro

Structure SciterRect Align #PB_Structure_AlignC
  left.C_INT
  top.C_INT
  right.C_INT
  bottom.C_INT
EndStructure

Structure SciterCallbackNotification Align #PB_Structure_AlignC
  code.C_UINT
  *hwnd
EndStructure

Structure SciterScnLoadData Align #PB_Structure_AlignC
  code.C_UINT               ; [in] UINT one of the codes above.
  *hwnd                     ; [in] HWINDOW of the window this callback was attached to.
  *uri                      ; [in] LPCWSTR Zero terminated string, fully qualified uri, for example "http://server/folder/file.ext"
  *outData                  ; [in,out] LPCBYTE pointer to loaded data to return. if data exists in the cache then this field contain pointer to it
  outDataSize.C_UINT        ; [in,out] UINT loaded data size to return.
  dataType.C_UINT           ; [in] UINT SciterResourceType
  *requestId                ; [in] HREQUEST request handle that can be used with sciter-x-request API
  *principal                ; HELEMENT
  *initiator                ; HELEMENT
EndStructure

Structure SciterScnDataLoaded Align #PB_Structure_AlignC
  code.C_UINT               ; [in] UINT one of the codes above.
  *hwnd                     ; [in] HWINDOW of the window this callback was attached to.
  *uri                      ; [in] LPCWSTR Zero terminated string, fully qualified uri, for example "http://server/folder/file.ext"
  *Data                     ; [in] LPCBYTE pointer To loaded Data.
  dataSize.C_UINT           ; [in] UINT loaded data size (in bytes)
  dataType.C_UINT           ; [in] UINT SciterResourceType
  status.C_UINT             ; [in] UINT
                            ;      status = 0 (dataSize == 0) - unknown error.
                            ;      status = 100..505 - http response status, Note: 200 - OK!
                            ;      status > 12000 - wininet error code, see ERROR_INTERNET_*** in wininet.h
EndStructure

Structure SciterValue Align #PB_Structure_AlignC
  t.C_UINT
  u.C_UINT
  d.C_UINT64
EndStructure

; Callback prototypes
;
; UINT SciterHostCallback(LPSCITER_CALLBACK_NOTIFICATION pns, LPVOID callbackParam)
Prototype.C_UINT SciterHostCallback(*pns.SciterCallbackNotification, *callbackParam)
; VOID NATIVE_FUNCTOR_INVOKE(VOID* tag, UINT argc, const VALUE* argv, VALUE* retval); // retval may contain error definition
Prototype SciterNativeFunctorInvoke(*tag, argc.C_UINT, *argv, *retval)
; VOID NATIVE_FUNCTOR_RELEASE(VOID* tag);
Prototype SciterNativeFunctorRelease(*tag)

; API prototypes
;
; LPCWSTR SciterClassName(void)
Prototype SciterClassName()
; UINT SciterVersion(SBOOL major)
Prototype.C_UINT SciterVersion(major.C_SBOOL)
; SBOOL SciterDataReady(HWINDOW hwnd, LPCWSTR uri, LPCBYTE Data, UINT dataLength)
Prototype.C_SBOOL SciterDataReady(*hwnd, *uri, *Dat, dataLength.C_UINT)
; SBOOL SciterDataReadyAsync(HWINDOW hwnd, LPCWSTR uri, LPCBYTE Data, UINT dataLength, LPVOID requestId)
Prototype SciterDataReadyAsync(*hwnd, *uri, *Dat, dataLength.C_UINT, *requestId)
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  ; LRESULT SciterProc(HWINDOW hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
  Prototype SciterProc(*hwnd, msg, wParam, lParam)
  ; LRESULT SciterProcND(HWINDOW hwnd, UINT msg, WPARAM wParam, LPARAM lParam, SBOOL* pbHandled)
  Prototype SciterProcND(*hwnd, msg, wParam, lParam, *pbHandled)
CompilerEndIf
; SBOOL SciterLoadFile(HWINDOW hWndSciter, LPCWSTR filename)
Prototype.C_SBOOL SciterLoadFile(*hWndSciter, *filename)
; SBOOL SciterLoadHtml(HWINDOW hWndSciter, LPCBYTE html, UINT htmlSize, LPCWSTR baseUrl)
Prototype.C_SBOOL SciterLoadHtml(*hWndSciter, html.p-utf8, htmlSize, baseUrl)
; VOID SciterSetCallback(HWINDOW hWndSciter, LPSciterHostCallback cb, LPVOID cbParam)
Prototype SciterSetCallback(*hWndSciter, cb.SciterHostCallback, *cbParam)
; SBOOL SciterSetMasterCSS(LPCBYTE utf8, UINT numBytes)
Prototype.C_SBOOL SciterSetMasterCSS(utf8, numBytes)
; SBOOL SciterAppendMasterCSS(LPCBYTE utf8, UINT numBytes)
Prototype.C_SBOOL SciterAppendMasterCSS(utf8, numBytes)
; SBOOL SciterSetCSS(HWINDOW hWndSciter, LPCBYTE utf8, UINT numBytes, LPCWSTR baseUrl, LPCWSTR mediaType)
Prototype.C_SBOOL SciterSetCSS(*hWndSciter, utf8, numBytes, baseUrl, mediaType)
; SBOOL SciterSetMediaType(HWINDOW hWndSciter, LPCWSTR mediaType)
Prototype.C_SBOOL SciterSetMediaType(*hWndSciter, mediaType)
; SBOOL SciterSetMediaVars(HWINDOW hWndSciter, const SCITER_VALUE *mediaVars)
Prototype.C_SBOOL SciterSetMediaVars(*hWndSciter, *mediaVars)
; UINT SciterGetMinWidth(HWINDOW hWndSciter)
Prototype.C_UINT SciterGetMinWidth(*hWndSciter)
; UINT SciterGetMinHeight(HWINDOW hWndSciter, UINT width)
Prototype.C_UINT SciterGetMinHeight(*hWndSciter, width)
; SBOOL SciterCall(HWINDOW hWnd, LPCSTR functionName, UINT argc, const SCITER_VALUE* argv, SCITER_VALUE* retval)
Prototype.C_SBOOL SciterCall(*hWnd, functionName, argc, argv, retval)
; SBOOL SciterEval(HWINDOW hwnd, LPCWSTR script, UINT scriptLength, SCITER_VALUE* pretval)
Prototype.C_SBOOL SciterEval(*hwnd, script, scriptLength, pretval)
; VOID SciterUpdateWindow(HWINDOW hwnd)
Prototype SciterUpdateWindow(*hwnd)
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  ; SBOOL SciterTranslateMessage(MSG* lpMsg)
  Prototype.C_SBOOL SciterTranslateMessage(lpMsg)
CompilerEndIf
; SBOOL SciterSetOption(HWINDOW hWnd, UINT option, UINT_PTR value)
Prototype.C_SBOOL SciterSetOption(*hWnd, option, *value)
; VOID SciterGetPPI(HWINDOW hWndSciter, UINT* px, UINT* py)
Prototype SciterGetPPI(*hWndSciter, px, py)
; SBOOL SciterGetViewExpando(HWINDOW hwnd, VALUE* pval)
Prototype.C_SBOOL SciterGetViewExpando(*hwnd, pval)
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  ; SBOOL SciterRenderD2D(HWINDOW hWndSciter, IUnknown* /*ID2D1RenderTarget**/ prt)
  Prototype.C_SBOOL SciterRenderD2D(*hWndSciter, prt)
  ; SBOOL SciterD2DFactory(IUnknown** /*ID2D1Factory ***/ ppf)
  Prototype.C_SBOOL SciterD2DFactory(ppf)
  ; SBOOL SciterDWFactory(IUnknown** /*IDWriteFactory ***/ ppf)
  Prototype.C_SBOOL SciterDWFactory(ppf)
CompilerEndIf
; SBOOL SciterGraphicsCaps(LPUINT pcaps)
Prototype.C_SBOOL SciterGraphicsCaps(pcaps)
; SBOOL SciterSetHomeURL(HWINDOW hWndSciter, LPCWSTR baseUrl)
Prototype.C_SBOOL SciterSetHomeURL(*hWndSciter, baseUrl)
CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
  ; HWINDOW SciterCreateNSView(LPRECT frame) // returns NSView*
  Prototype SciterCreateNSView(*frame.SciterRect)
CompilerEndIf
CompilerIf #PB_Compiler_OS = #PB_OS_Linux
  ; HWINDOW SciterCreateWidget(LPRECT frame) // returns GtkWidget
  Prototype SciterCreateWidget(*frame.SciterRect)
CompilerEndIf
; HWINDOW SciterCreateWindow(UINT creationFlags, LPRECT frame, SciterWindowDelegate* delegate, LPVOID delegateParam, HWINDOW parent)
Prototype SciterCreateWindow(creationFlags, frame, delegate, delegateParam, parent)
; VOID SciterSetupDebugOutput(
;         HWINDOW               hwndOrNull, // HWINDOW Or null If this is Global output handler
;         LPVOID                param,      // param To be passed "as is" To the pfOutput
;         DEBUG_OUTPUT_PROC     pfOutput    // output function, output stream alike thing.
;      )
Prototype SciterSetupDebugOutput(hwndOrNull, param, pfOutput)
; SCDOM_RESULT Sciter_UseElement(HELEMENT he)
Prototype Sciter_UseElement(he)
; SCDOM_RESULT Sciter_UnuseElement(HELEMENT he)
Prototype Sciter_UnuseElement(he)
; SCDOM_RESULT SciterGetRootElement(HWINDOW hwnd, HELEMENT *phe)
Prototype SciterGetRootElement(*hwnd, *phe)
; SCDOM_RESULT SciterGetFocusElement(HWINDOW hwnd, HELEMENT *phe)
Prototype SciterGetFocusElement(*hwnd, *phe)
; SCDOM_RESULT SciterFindElement(HWINDOW hwnd, POINT pt, HELEMENT* phe)
Prototype SciterFindElement(*hwnd, pt, phe)
; SCDOM_RESULT SciterGetChildrenCount(HELEMENT he, UINT* count)
Prototype SciterGetChildrenCount(he, count)
; SCDOM_RESULT SciterGetNthChild(HELEMENT he, UINT n, HELEMENT* phe)
Prototype SciterGetNthChild(he, n, phe)
; SCDOM_RESULT SciterGetParentElement(HELEMENT he, HELEMENT* p_parent_he)
Prototype SciterGetParentElement(he, p_parent_he)
; SCDOM_RESULT SciterGetElementHtmlCB(HELEMENT he, SBOOL outer, LPCBYTE_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterGetElementHtmlCB(he, outer, rcv, rcv_param)
; SCDOM_RESULT SciterGetElementTextCB(HELEMENT he, LPCWSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterGetElementTextCB(he, rcv, rcv_param)
; SCDOM_RESULT SciterSetElementText(HELEMENT he, LPCWSTR utf16, UINT length)
Prototype SciterSetElementText(he, utf16, length)
; SCDOM_RESULT SciterGetAttributeCount(HELEMENT he, LPUINT p_count)
Prototype SciterGetAttributeCount(he, p_count)
; SCDOM_RESULT SciterGetNthAttributeNameCB(HELEMENT he, UINT n, LPCSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterGetNthAttributeNameCB(he, n, rcv, rcv_param)
; SCDOM_RESULT SciterGetNthAttributeValueCB(HELEMENT he, UINT n, LPCWSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterGetNthAttributeValueCB(he, n, rcv, rcv_param)
; SCDOM_RESULT SciterSetAttributeByName(HELEMENT he, LPCSTR name, LPCWSTR value)
Prototype SciterSetAttributeByName(he, name, value)
; SCDOM_RESULT SciterClearAttributes(HELEMENT he)
Prototype SciterClearAttributes(he)
; SCDOM_RESULT SciterGetElementIndex(HELEMENT he, LPUINT p_index)
Prototype SciterGetElementIndex(he, p_index)
; SCDOM_RESULT SciterGetElementType(HELEMENT he, LPCSTR* p_type)
Prototype SciterGetElementType(he, p_type)
; SCDOM_RESULT SciterGetElementTypeCB(HELEMENT he, LPCSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterGetElementTypeCB(he, rcv, rcv_param)
; SCDOM_RESULT SciterGetStyleAttributeCB(HELEMENT he, LPCSTR name, LPCWSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterGetStyleAttributeCB(he, name, rcv, rcv_param)
; SCDOM_RESULT SciterSetStyleAttribute(HELEMENT he, LPCSTR name, LPCWSTR value)
Prototype SciterSetStyleAttribute(he, name, value)
; SCDOM_RESULT SciterGetElementLocation(HELEMENT he, LPRECT p_location, UINT areas /*ELEMENT_AREAS*/)
Prototype SciterGetElementLocation(he, p_location, areas)
; SCDOM_RESULT SciterScrollToView(HELEMENT he, UINT SciterScrollFlags)
Prototype SciterScrollToView(he, SciterScrollFlags)
; SCDOM_RESULT SciterUpdateElement(HELEMENT he, SBOOL andForceRender)
Prototype SciterUpdateElement(he, andForceRender)
; SCDOM_RESULT SciterRefreshElementArea(HELEMENT he, RECT rc)
Prototype SciterRefreshElementArea(he, rc)
; SCDOM_RESULT SciterSetCapture(HELEMENT he)
Prototype SciterSetCapture(he)
; SCDOM_RESULT SciterReleaseCapture(HELEMENT he)
Prototype SciterReleaseCapture(he)
; SCDOM_RESULT SciterGetElementHwnd(HELEMENT he, HWINDOW* p_hwnd, SBOOL rootWindow)
Prototype SciterGetElementHwnd(he, p_hwnd, rootWindow)
; SCDOM_RESULT SciterCombineURL(HELEMENT he, LPWSTR szUrlBuffer, UINT UrlBufferSize)
Prototype SciterCombineURL(he, szUrlBuffer, UrlBufferSize)
; SCDOM_RESULT SciterSelectElements(HELEMENT he, LPCSTR CSS_selectors, SciterElementCallback* callback, LPVOID param)
Prototype SciterSelectElements(he, CSS_selectors, callback, param)
; SCDOM_RESULT SciterSelectElementsW(HELEMENT  he, LPCWSTR   CSS_selectors, SciterElementCallback* callback, LPVOID param)
Prototype SciterSelectElementsW(he, CSS_selectors, callback, param)
; SCDOM_RESULT SciterSelectParent(HELEMENT he, LPCSTR selector, UINT depth, HELEMENT* heFound)
Prototype SciterSelectParent(he, selector, depth, heFound)
; SCDOM_RESULT SciterSelectParentW(HELEMENT he, LPCWSTR selector, UINT depth, HELEMENT* heFound)
Prototype SciterSelectParentW(he, selector, depth, heFound)
; SCDOM_RESULT SciterSetElementHtml(HELEMENT he, const BYTE* html, UINT htmlLength, UINT where)
Prototype SciterSetElementHtml(he, html, htmlLength, where)
; SCDOM_RESULT SciterGetElementUID(HELEMENT he, UINT* puid)
Prototype SciterGetElementUID(he, puid)
; SCDOM_RESULT SciterGetElementByUID(HWINDOW hwnd, UINT uid, HELEMENT* phe)
Prototype SciterGetElementByUID(hwnd, uid, phe)
; SCDOM_RESULT SciterShowPopup(HELEMENT hePopup, HELEMENT heAnchor, UINT placement)
Prototype SciterShowPopup(hePopup, heAnchor, placement)
; SCDOM_RESULT SciterShowPopupAt(HELEMENT hePopup, POINT pos, UINT placement)
Prototype SciterShowPopupAt(hePopup, pos, placement)
; SCDOM_RESULT SciterHidePopup(HELEMENT he);
Prototype SciterHidePopup(he)
; SCDOM_RESULT SciterGetElementState(HELEMENT he, UINT* pstateBits)
Prototype SciterGetElementState(he, pstateBits)
; SCDOM_RESULT SciterSetElementState(HELEMENT he, UINT stateBitsToSet, UINT stateBitsToClear, SBOOL updateView)
Prototype SciterSetElementState(he, stateBitsToSet, stateBitsToClear, updateView)
; SCDOM_RESULT SciterCreateElement(LPCSTR tagname, LPCWSTR textOrNull, /*out*/ HELEMENT *phe)
Prototype SciterCreateElement(tagname, textOrNull, *phe)
; SCDOM_RESULT SciterCloneElement(HELEMENT he, /*out*/ HELEMENT *phe)
Prototype SciterCloneElement(he, *phe)
; SCDOM_RESULT SciterInsertElement(HELEMENT he, HELEMENT hparent, UINT index)
Prototype SciterInsertElement(he, hparent, index)
; SCDOM_RESULT SciterDetachElement(HELEMENT he)
Prototype SciterDetachElement(he)
; SCDOM_RESULT SciterDeleteElement(HELEMENT he)
Prototype SciterDeleteElement(he)
; SCDOM_RESULT SciterSetTimer(HELEMENT he, UINT milliseconds, UINT_PTR timer_id)
Prototype SciterSetTimer(he, milliseconds, timer_id)
; SCDOM_RESULT SciterDetachEventHandler(HELEMENT he, LPELEMENT_EVENT_PROC pep, LPVOID tag)
Prototype SciterDetachEventHandler(he, pep, tag)
; SCDOM_RESULT SciterAttachEventHandler(HELEMENT he, LPELEMENT_EVENT_PROC pep, LPVOID tag)
Prototype SciterAttachEventHandler(he, pep, tag)
; SCDOM_RESULT SciterWindowAttachEventHandler(HWINDOW hwndLayout, LPELEMENT_EVENT_PROC pep, LPVOID tag, UINT subscription)
Prototype SciterWindowAttachEventHandler(hwndLayout, pep, tag, subscription)
; SCDOM_RESULT SciterWindowDetachEventHandler(HWINDOW hwndLayout, LPELEMENT_EVENT_PROC pep, LPVOID tag)
Prototype SciterWindowDetachEventHandler(hwndLayout, pep, tag)
; SCDOM_RESULT SciterSendEvent(HELEMENT he, UINT appEventCode, HELEMENT heSource, UINT_PTR reason, /*out*/ SBOOL* handled)
Prototype SciterSendEvent(he, appEventCode, heSource, reason, handled)
; SCDOM_RESULT SciterPostEvent(HELEMENT he, UINT appEventCode, HELEMENT heSource, UINT_PTR reason)
Prototype SciterPostEvent(he, appEventCode, heSource, reason)
; SCDOM_RESULT SciterCallBehaviorMethod(HELEMENT he, struct METHOD_PARAMS* params)
Prototype SciterCallBehaviorMethod(he, params)
; SCDOM_RESULT SciterRequestElementData(HELEMENT he, LPCWSTR url, UINT dataType, HELEMENT initiator)
Prototype SciterRequestElementData(he, url, dataType, initiator)
; SCDOM_RESULT SciterHttpRequest(
;           HELEMENT        he,                     // element To deliver Data
;           LPCWSTR         url,                    // url
;           UINT            dataType,               // Data type, see SciterResourceType.
;           UINT            requestType,            // one of REQUEST_TYPE values
;           struct REQUEST_PARAM*  requestParams,   // parameters
;           UINT            nParams                 // number of parameters
;           )
Prototype SciterHttpRequest(he, url, dataType, requestType, requestParams, nParams)
; SCDOM_RESULT SciterGetScrollInfo(HELEMENT he, LPPOINT scrollPos, LPRECT viewRect, LPSIZE contentSize)
Prototype SciterGetScrollInfo(he, scrollPos, viewRect, contentSize)
; SCDOM_RESULT SciterSetScrollPos(HELEMENT he, POINT scrollPos, SBOOL smooth)
Prototype SciterSetScrollPos(he, scrollPos,  smooth)
; SCDOM_RESULT SciterGetElementIntrinsicWidths(HELEMENT he, INT* pMinWidth, INT* pMaxWidth)
Prototype SciterGetElementIntrinsicWidths(he, pMinWidth, pMaxWidth)
; SCDOM_RESULT SciterGetElementIntrinsicHeight(HELEMENT he, INT forWidth, INT* pHeight)
Prototype SciterGetElementIntrinsicHeight(he, forWidth, pHeight)
; SCDOM_RESULT SciterIsElementVisible(HELEMENT he, SBOOL* pVisible)
Prototype SciterIsElementVisible(he, pVisible)
; SCDOM_RESULT SciterIsElementEnabled(HELEMENT he, SBOOL* pEnabled)
Prototype SciterIsElementEnabled(he, pEnabled)
; SCDOM_RESULT SciterSortElements(HELEMENT he, UINT firstIndex, UINT lastIndex, ELEMENT_COMPARATOR* cmpFunc, LPVOID cmpFuncParam)
Prototype SciterSortElements(he, firstIndex, lastIndex, cmpFunc, cmpFuncParam)
; SCDOM_RESULT SciterSwapElements(HELEMENT he1, HELEMENT he2)
Prototype SciterSwapElements(he1, he2)
; SCDOM_RESULT SciterTraverseUIEvent(UINT evt, LPVOID eventCtlStruct, SBOOL* bOutProcessed)
Prototype SciterTraverseUIEvent(evt, eventCtlStruct, bOutProcessed)
; SCDOM_RESULT SciterCallScriptingMethod(HELEMENT he, LPCSTR name, const VALUE* argv, UINT argc, VALUE* retval)
Prototype SciterCallScriptingMethod(he, name, argv, argc, retval)
; SCDOM_RESULT SciterCallScriptingFunction(HELEMENT he, LPCSTR name, const VALUE* argv, UINT argc, VALUE* retval)
Prototype SciterCallScriptingFunction(he, name, argv, argc, retval)
; SCDOM_RESULT SciterEvalElementScript(HELEMENT he, LPCWSTR script, UINT scriptLength, VALUE* retval)
Prototype SciterEvalElementScript(he, script, scriptLength, retval)
; SCDOM_RESULT SciterAttachHwndToElement(HELEMENT he, HWINDOW hwnd)
Prototype SciterAttachHwndToElement(he, *hwnd)
; SCDOM_RESULT SciterControlGetType(HELEMENT he, /*CTL_TYPE*/ UINT *pType)
Prototype SciterControlGetType(he, *pType)
; SCDOM_RESULT SciterGetValue(HELEMENT he, VALUE* pval)
Prototype SciterGetValue(he, pval)
; SCDOM_RESULT SciterSetValue(HELEMENT he, const VALUE* pval)
Prototype SciterSetValue(he, pval)
; SCDOM_RESULT SciterGetExpando(HELEMENT he, VALUE* pval, SBOOL forceCreation)
Prototype SciterGetExpando(he, pval, forceCreation)
; SCDOM_RESULT SciterGetObject(HELEMENT he, void* pval, SBOOL forceCreation)
Prototype SciterGetObject(he, pval, forceCreation)
; SCDOM_RESULT SciterGetElementNamespace(HELEMENT he, void* pval)
Prototype SciterGetElementNamespace(he, pval)
; SCDOM_RESULT SciterGetHighlightedElement(HWINDOW hwnd, HELEMENT* phe)
Prototype SciterGetHighlightedElement(hwnd, phe)
; SCDOM_RESULT SciterSetHighlightedElement(HWINDOW hwnd, HELEMENT he)
Prototype SciterSetHighlightedElement(hwnd, he)
; SCDOM_RESULT SciterNodeAddRef(HNODE hn)
Prototype SciterNodeAddRef(hn)
; SCDOM_RESULT SciterNodeRelease(HNODE hn)
Prototype SciterNodeRelease(hn)
; SCDOM_RESULT SciterNodeCastFromElement(HELEMENT he, HNODE* phn)
Prototype SciterNodeCastFromElement(he, phn)
; SCDOM_RESULT SciterNodeCastToElement(HNODE hn, HELEMENT* he)
Prototype SciterNodeCastToElement(hn, he)
; SCDOM_RESULT SciterNodeFirstChild(HNODE hn, HNODE* phn)
Prototype SciterNodeFirstChild(hn, phn)
; SCDOM_RESULT SciterNodeLastChild(HNODE hn, HNODE* phn)
Prototype SciterNodeLastChild(hn, phn)
; SCDOM_RESULT SciterNodeNextSibling(HNODE hn, HNODE* phn)
Prototype SciterNodeNextSibling(hn, phn)
; SCDOM_RESULT SciterNodePrevSibling(HNODE hn, HNODE* phn)
Prototype SciterNodePrevSibling(hn, phn)
; SCDOM_RESULT SciterNodeParent(HNODE hnode, HELEMENT* pheParent)
Prototype SciterNodeParent(hnode, pheParent)
; SCDOM_RESULT SciterNodeNthChild(HNODE hnode, UINT n, HNODE* phn)
Prototype SciterNodeNthChild(hnode, n, phn)
; SCDOM_RESULT SciterNodeChildrenCount(HNODE hnode, UINT* pn)
Prototype SciterNodeChildrenCount(hnode, pn)
; SCDOM_RESULT SciterNodeType(HNODE hnode, UINT* pNodeType /*NODE_TYPE*/)
Prototype SciterNodeType(hnode, pNodeType)
; SCDOM_RESULT SciterNodeGetText(HNODE hnode, LPCWSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype SciterNodeGetText(hnode, rcv, rcv_param)
; SCDOM_RESULT SciterNodeSetText(HNODE hnode, LPCWSTR text, UINT textLength)
Prototype SciterNodeSetText(hnode, text, textLength)
; SCDOM_RESULT SciterNodeInsert(HNODE hnode, UINT where /*NODE_INS_TARGET*/, HNODE what)
Prototype SciterNodeInsert(hnode, where , what)
; SCDOM_RESULT SciterNodeRemove(HNODE hnode, SBOOL finalize)
Prototype SciterNodeRemove(hnode, finalize)
; SCDOM_RESULT SciterCreateTextNode(LPCWSTR text, UINT textLength, HNODE* phnode)
Prototype SciterCreateTextNode(text, textLength, phnode)
; SCDOM_RESULT SciterCreateCommentNode(LPCWSTR text, UINT textLength, HNODE* phnode)
Prototype SciterCreateCommentNode(text, textLength, phnode)
; UINT ValueInit(VALUE* pval)
Prototype.C_UINT SciterValueInit(*pval.SciterValue)
; UINT ValueClear(VALUE* pval)
Prototype.C_UINT SciterValueClear(*pval.SciterValue)
; UINT ValueCompare(const VALUE* pval1, const VALUE* pval2)
Prototype.C_UINT SciterValueCompare(*pval1.SciterValue, *pval2.SciterValue)
; UINT ValueCopy(VALUE* pdst, const VALUE* psrc)
Prototype.C_UINT SciterValueCopy(*pdst.SciterValue, *psrc.SciterValue)
; UINT ValueIsolate(VALUE* pdst)
Prototype.C_UINT SciterValueIsolate(*pdst.SciterValue)
; UINT ValueType(const VALUE* pval, UINT* pType, UINT* pUnits)
Prototype.C_UINT SciterValueType(*pval.SciterValue, pType, pUnits)
; UINT ValueStringData(const VALUE* pval, LPCWSTR* pChars, UINT* pNumChars)
Prototype.C_UINT SciterValueStringData(*pval.SciterValue, pChars, pNumChars)
; UINT ValueStringDataSet(VALUE* pval, LPCWSTR chars, UINT numChars, UINT units)
Prototype.C_UINT SciterValueStringDataSet(*pval.SciterValue, chars, numChars, units)
; UINT ValueIntData(const VALUE* pval, INT* pData)
Prototype.C_UINT SciterValueIntData(*pval.SciterValue, pData)
; UINT ValueIntDataSet(VALUE* pval, INT Data, UINT type, UINT units)
Prototype.C_UINT SciterValueIntDataSet(*pval.SciterValue, Dat.C_INT, type.C_UINT, units.C_UINT)
; UINT ValueInt64Data(const VALUE* pval, INT64* pData)
Prototype.C_UINT SciterValueInt64Data(*pval.SciterValue, pData)
; UINT ValueInt64DataSet(VALUE* pval, INT64 data, UINT type, UINT units)
Prototype.C_UINT SciterValueInt64DataSet(*pval.SciterValue, Dat, type, units)
; UINT ValueFloatData(const VALUE* pval, FLOAT_VALUE* pData)
Prototype.C_UINT SciterValueFloatData(*pval.SciterValue, pData)
; UINT ValueFloatDataSet(VALUE* pval, FLOAT_VALUE Data, UINT type, UINT units)
Prototype.C_UINT SciterValueFloatDataSet(*pval.SciterValue, Dat, type, units)
; UINT ValueBinaryData(const VALUE* pval, LPCBYTE* pBytes, UINT* pnBytes)
Prototype.C_UINT SciterValueBinaryData(*pval.SciterValue, pBytes, pnBytes)
; UINT ValueBinaryDataSet(VALUE* pval, LPCBYTE pBytes, UINT nBytes, UINT type, UINT units)
Prototype.C_UINT SciterValueBinaryDataSet(*pval.SciterValue, pBytes, nBytes, type, units)
; UINT ValueElementsCount(const VALUE* pval, INT* pn)
Prototype.C_UINT SciterValueElementsCount(*pval.SciterValue, pn)
; UINT ValueNthElementValue(const VALUE* pval, INT n, VALUE* pretval)
Prototype.C_UINT SciterValueNthElementValue(*pval.SciterValue, n, pretval)
; UINT ValueNthElementValueSet(VALUE* pval, INT n, const VALUE* pval_to_set)
Prototype.C_UINT SciterValueNthElementValueSet(*pval.SciterValue, n, pval_to_set)
; UINT ValueNthElementKey(const VALUE* pval, INT n, VALUE* pretval)
Prototype.C_UINT SciterValueNthElementKey(*pval.SciterValue, n, pretval)
; UINT ValueEnumElements(const VALUE* pval, KeyValueCallback* penum, LPVOID param)
Prototype.C_UINT SciterValueEnumElements(*pval.SciterValue, penum, param)
; UINT ValueSetValueToKey(VALUE* pval, const VALUE* pkey, const VALUE* pval_to_set)
Prototype.C_UINT SciterValueSetValueToKey(*pval.SciterValue, pkey, pval_to_set)
; UINT ValueGetValueOfKey(const VALUE* pval, const VALUE* pkey, VALUE* pretval)
Prototype.C_UINT SciterValueGetValueOfKey(pval, pkey, pretval)
; UINT ValueToString(VALUE* pval, /*VALUE_STRING_CVT_TYPE*/ UINT how)
Prototype.C_UINT SciterValueToString(*pval.SciterValue, how)
; UINT ValueFromString(VALUE* pval, LPCWSTR str, UINT strLength, /*VALUE_STRING_CVT_TYPE*/ UINT how)
Prototype.C_UINT SciterValueFromString(*pval.SciterValue, str, strLength, how)
; UINT ValueInvoke(const VALUE* pval, VALUE* pthis, UINT argc, const VALUE* argv, VALUE* pretval, LPCWSTR url)
Prototype.C_UINT SciterValueInvoke(*pval.SciterValue, pthis, argc, argv, pretval, url)
; UINT ValueNativeFunctorSet(VALUE* pval, NATIVE_FUNCTOR_INVOKE* pinvoke, NATIVE_FUNCTOR_RELEASE* prelease, VOID* tag)
Prototype.C_UINT SciterValueNativeFunctorSet(*pval.SciterValue, pinvoke.SciterNativeFunctorInvoke, prelease.SciterNativeFunctorRelease, *tag)
; SBOOL ValueIsNativeFunctor(const VALUE* pval)
Prototype.C_SBOOL SciterValueIsNativeFunctor(*pval.SciterValue)
; HSARCHIVE SciterOpenArchive(LPCBYTE archiveData, UINT archiveDataLength)
Prototype SciterOpenArchive(archiveData, archiveDataLength)
; SBOOL SciterGetArchiveItem(HSARCHIVE harc, LPCWSTR path, LPCBYTE* pdata, UINT* pdataLength)
Prototype.C_SBOOL SciterGetArchiveItem(harc, path, pdata, pdataLength)
; SBOOL SciterCloseArchive(HSARCHIVE harc)
Prototype.C_SBOOL SciterCloseArchive(harc)
; SCDOM_RESULT SciterFireEvent(const BEHAVIOR_EVENT_PARAMS* evt, SBOOL post, SBOOL *handled)
Prototype SciterFireEvent(evt, post, *handled)
; LPVOID SciterGetCallbackParam(HWINDOW hwnd)
Prototype SciterGetCallbackParam(*hwnd)
; UINT_PTR SciterPostCallback(HWINDOW hwnd, UINT_PTR wparam, UINT_PTR lparam, UINT timeoutms)
Prototype SciterPostCallback(*hwnd, wparam, lparam, timeoutms)
; LPSciterGraphicsAPI GetSciterGraphicsAPI()
Prototype SciterGetSciterGraphicsAPI()
; LPSciterRequestAPI GetSciterRequestAPI()
Prototype SciterGetSciterRequestAPI()
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  ; SBOOL SciterCreateOnDirectXWindow(HWINDOW hwnd, IUnknown* pSwapChain) // IDXGISwapChain
  Prototype.C_SBOOL SciterCreateOnDirectXWindow(*hwnd, pSwapChain)
  ; SBOOL SciterRenderOnDirectXWindow(HWINDOW hwnd, HELEMENT elementToRenderOrNull, SBOOL frontLayer)
  Prototype.C_SBOOL SciterRenderOnDirectXWindow(*hwnd, elementToRenderOrNull, frontLayer)
  ; SBOOL SciterRenderOnDirectXTexture(HWINDOW hwnd, HELEMENT elementToRenderOrNull, IUnknown* surface) // IDXGISurface
  Prototype.C_SBOOL SciterRenderOnDirectXTexture(*hwnd, elementToRenderOrNull, surface)
CompilerEndIf
; SBOOL SciterProcX(HWINDOW hwnd, SCITER_X_MSG* pMsg) // returns TRUE if handled
Prototype.C_SBOOL SciterProcX(*hwnd, pMsg)
; UINT64 SciterAtomValue(const char* name)
Prototype.C_UINT64 SciterAtomValue(name)
; SBOOL SciterAtomNameCB(UINT64 atomv, LPCSTR_RECEIVER* rcv, LPVOID rcv_param)
Prototype.C_SBOOL SciterAtomNameCB(atomv, rcv, rcv_param)
; SBOOL SciterSetGlobalAsset(som_asset_t* pass)
Prototype.C_SBOOL SciterSetGlobalAsset(pass)
; SCDOM_RESULT SciterGetElementAsset(HELEMENT el, UINT64 nameAtom, som_asset_t** ppass)
Prototype SciterGetElementAsset(el, nameAtom, ppass)
;UINT SciterSetVariable(HWINDOW hwndOrNull, LPCSTR name, const VALUE* pvalToSet);
Prototype.C_UINT SciterSetVariable(*hwndOrNull, *name, *pvalToSet.SciterValue)
;UINT SciterGetVariable)(HWINDOW hwndOrNull, LPCSTR name, VALUE* pvalToGet);
Prototype.C_UINT SciterGetVariable(*hwndOrNull, *name, *pvalToGet.SciterValue)
; UINT SciterElementUnwrap(const VALUE* pval, HELEMENT* ppElement)
Prototype.C_UINT SciterElementUnwrap(pval, ppElement)
; UINT SciterElementWrap(VALUE* pval, HELEMENT pElement)
Prototype.C_UINT SciterElementWrap(pval, pElement)
; UINT SciterNodeUnwrap(const VALUE* pval, HNODE* ppNode)
Prototype.C_UINT SciterNodeUnwrap(pval, ppNode)
; UINT SciterNodeWrap(VALUE* pval, HNODE pNode)
Prototype.C_UINT SciterNodeWrap(pval, pNode)
; SBOOL SciterReleaseGlobalAsset(som_asset_t* pass)
Prototype.C_SBOOL SciterReleaseGlobalAsset(pass)



Structure Sciter Align #PB_Structure_AlignC
  ver.C_UINT
  ClassName.SciterClassName
  Version.SciterVersion
  DataReady.SciterDataReady
  DataReadyAsync.SciterDataReadyAsync
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    Proc.SciterProc
    ProcND.SciterProcND
  CompilerElse
    *Proc
    *ProcND
  CompilerEndIf
  LoadFile.SciterLoadFile
  LoadHtml.SciterLoadHtml
  SetCallback.SciterSetCallback
  SetMasterCSS.SciterSetMasterCSS
  AppendMasterCSS.SciterAppendMasterCSS
  SetCSS.SciterSetCSS
  SetMediaType.SciterSetMediaType
  SetMediaVars.SciterSetMediaVars
  GetMinWidth.SciterGetMinWidth
  GetMinHeight.SciterGetMinHeight
  Call.SciterCall
  Eval.SciterEval
  UpdateWindow.SciterUpdateWindow
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    TranslateMessage.SciterTranslateMessage
  CompilerElse
    *TranslateMessage
  CompilerEndIf
  SetOption.SciterSetOption
  GetPPI.SciterGetPPI
  GetViewExpando.SciterGetViewExpando
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    RenderD2D.SciterRenderD2D
    D2DFactory.SciterD2DFactory
    DWFactory.SciterDWFactory
  CompilerElse
    *RenderD2D
    *D2DFactory
    *DWFactory
  CompilerEndIf
  GraphicsCaps.SciterGraphicsCaps
  SetHomeURL.SciterSetHomeURL
  CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
    CreateNSView.SciterCreateNSView
  CompilerElse
    *CreateNSView
  CompilerEndIf
  CompilerIf #PB_Compiler_OS = #PB_OS_Linux
    CreateWidget.SciterCreateWidget
  CompilerElse
    *CreateWidget
  CompilerEndIf
  CreateWindow.SciterCreateWindow
  SetupDebugOutput.SciterSetupDebugOutput
  _UseElement.Sciter_UseElement
  _UnuseElement.Sciter_UnuseElement
  GetRootElement.SciterGetRootElement
  GetFocusElement.SciterGetFocusElement
  FindElement.SciterFindElement
  GetChildrenCount.SciterGetChildrenCount
  GetNthChild.SciterGetNthChild
  GetParentElement.SciterGetParentElement
  GetElementHtmlCB.SciterGetElementHtmlCB
  GetElementTextCB.SciterGetElementTextCB
  SetElementText.SciterSetElementText
  GetAttributeCount.SciterGetAttributeCount
  GetNthAttributeNameCB.SciterGetNthAttributeNameCB
  GetNthAttributeValueCB.SciterGetNthAttributeValueCB
  SetAttributeByName.SciterSetAttributeByName
  ClearAttributes.SciterClearAttributes
  GetElementIndex.SciterGetElementIndex
  GetElementType.SciterGetElementType
  GetElementTypeCB.SciterGetElementTypeCB
  GetStyleAttributeCB.SciterGetStyleAttributeCB
  SetStyleAttribute.SciterSetStyleAttribute
  GetElementLocation.SciterGetElementLocation
  ScrollToView.SciterScrollToView
  UpdateElement.SciterUpdateElement
  RefreshElementArea.SciterRefreshElementArea
  SetCapture.SciterSetCapture
  ReleaseCapture.SciterReleaseCapture
  GetElementHwnd.SciterGetElementHwnd
  CombineURL.SciterCombineURL
  SelectElements.SciterSelectElements
  SelectElementsW.SciterSelectElementsW
  SelectParent.SciterSelectParent
  SelectParentW.SciterSelectParentW
  SetElementHtml.SciterSetElementHtml
  GetElementUID.SciterGetElementUID
  GetElementByUID.SciterGetElementByUID
  ShowPopup.SciterShowPopup
  ShowPopupAt.SciterShowPopupAt
  HidePopup.SciterHidePopup
  GetElementState.SciterGetElementState
  SetElementState.SciterSetElementState
  CreateElement.SciterCreateElement
  CloneElement.SciterCloneElement
  InsertElement.SciterInsertElement
  DetachElement.SciterDetachElement
  DeleteElement.SciterDeleteElement
  SetTimer.SciterSetTimer
  DetachEventHandler.SciterDetachEventHandler
  AttachEventHandler.SciterAttachEventHandler
  WindowAttachEventHandler.SciterWindowAttachEventHandler
  WindowDetachEventHandler.SciterWindowDetachEventHandler
  SendEvent.SciterSendEvent
  PostEvent.SciterPostEvent
  CallBehaviorMethod.SciterCallBehaviorMethod
  RequestElementData.SciterRequestElementData
  HttpRequest.SciterHttpRequest
  GetScrollInfo.SciterGetScrollInfo
  SetScrollPos.SciterSetScrollPos
  GetElementIntrinsicWidths.SciterGetElementIntrinsicWidths
  GetElementIntrinsicHeight.SciterGetElementIntrinsicHeight
  IsElementVisible.SciterIsElementVisible
  IsElementEnabled.SciterIsElementEnabled
  SortElements.SciterSortElements
  SwapElements.SciterSwapElements
  TraverseUIEvent.SciterTraverseUIEvent
  CallScriptingMethod.SciterCallScriptingMethod
  CallScriptingFunction.SciterCallScriptingFunction
  EvalElementScript.SciterEvalElementScript
  AttachHwndToElement.SciterAttachHwndToElement
  ControlGetType.SciterControlGetType
  GetValue.SciterGetValue
  SetValue.SciterSetValue
  GetExpando.SciterGetExpando
  GetObject.SciterGetObject
  GetElementNamespace.SciterGetElementNamespace
  GetHighlightedElement.SciterGetHighlightedElement
  SetHighlightedElement.SciterSetHighlightedElement
  NodeAddRef.SciterNodeAddRef
  NodeRelease.SciterNodeRelease
  NodeCastFromElement.SciterNodeCastFromElement
  NodeCastToElement.SciterNodeCastToElement
  NodeFirstChild.SciterNodeFirstChild
  NodeLastChild.SciterNodeLastChild
  NodeNextSibling.SciterNodeNextSibling
  NodePrevSibling.SciterNodePrevSibling
  NodeParent.SciterNodeParent
  NodeNthChild.SciterNodeNthChild
  NodeChildrenCount.SciterNodeChildrenCount
  NodeType.SciterNodeType
  NodeGetText.SciterNodeGetText
  NodeSetText.SciterNodeSetText
  NodeInsert.SciterNodeInsert
  NodeRemove.SciterNodeRemove
  CreateTextNode.SciterCreateTextNode
  CreateCommentNode.SciterCreateCommentNode
  ValueInit.SciterValueInit
  ValueClear.SciterValueClear
  ValueCompare.SciterValueCompare
  ValueCopy.SciterValueCopy
  ValueIsolate.SciterValueIsolate
  ValueType.SciterValueType
  ValueStringData.SciterValueStringData
  ValueStringDataSet.SciterValueStringDataSet
  ValueIntData.SciterValueIntData
  ValueIntDataSet.SciterValueIntDataSet
  ValueInt64Data.SciterValueInt64Data
  ValueInt64DataSet.SciterValueInt64DataSet
  ValueFloatData.SciterValueFloatData
  ValueFloatDataSet.SciterValueFloatDataSet
  ValueBinaryData.SciterValueBinaryData
  ValueBinaryDataSet.SciterValueBinaryDataSet
  ValueElementsCount.SciterValueElementsCount
  ValueNthElementValue.SciterValueNthElementValue
  ValueNthElementValueSet.SciterValueNthElementValueSet
  ValueNthElementKey.SciterValueNthElementKey
  ValueEnumElements.SciterValueEnumElements
  ValueSetValueToKey.SciterValueSetValueToKey
  ValueGetValueOfKey.SciterValueGetValueOfKey
  ValueToString.SciterValueToString
  ValueFromString.SciterValueFromString
  ValueInvoke.SciterValueInvoke
  ValueNativeFunctorSet.SciterValueNativeFunctorSet
  ValueIsNativeFunctor.SciterValueIsNativeFunctor
  *reserved1
  *reserved2
  *reserved3
  *reserved4
  OpenArchive.SciterOpenArchive
  GetArchiveItem.SciterGetArchiveItem
  CloseArchive.SciterCloseArchive
  FireEvent.SciterFireEvent
  GetCallbackParam.SciterGetCallbackParam
  PostCallback.SciterPostCallback
  GetSciterGraphicsAPI.SciterGetSciterGraphicsAPI
  GetSciterRequestAPI.SciterGetSciterRequestAPI
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    CreateOnDirectXWindow.SciterCreateOnDirectXWindow
    RenderOnDirectXWindow.SciterRenderOnDirectXWindow
    RenderOnDirectXTexture.SciterRenderOnDirectXTexture
  CompilerElse
    *CreateOnDirectXWindow
    *RenderOnDirectXWindow
    *RenderOnDirectXTexture
  CompilerEndIf
  ProcX.SciterProcX
  AtomValue.SciterAtomValue
  AtomNameCB.SciterAtomNameCB
  SetGlobalAsset.SciterSetGlobalAsset
  GetElementAsset.SciterGetElementAsset
  SetVariable.SciterSetVariable
  GetVariable.SciterGetVariable
  ElementUnwrap.SciterElementUnwrap
  ElementWrap.SciterElementWrap
  NodeUnwrap.SciterNodeUnwrap
  NodeWrap.SciterNodeWrap
  ReleaseGlobalAsset.SciterReleaseGlobalAsset
EndStructure
