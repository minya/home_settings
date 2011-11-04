LWin & Tab::AltTab
#Space::LangSwitch(1)
#Space up::LangSwitch(2)

*#c::^c
*#v::^v
*#x::^x
*#z::^z
*#b::^b
*#n::^n
*#a::^a
*#k::^k
*#t::^t
*#w::^w
*#o::^o

LangSwitch( iKeyDownUp=0 )
{
	static tickLast
	IfEqual,iKeyDownUp,1
	{	tickLast=%A_TickCount%
		return
	}
	IfEqual,iKeyDownUp,2
		If( A_TickCount-tickLast>200 )
			return
	
	hwnd := WinExist("A")
	HKL:=getKeyboardLayout(hwnd)

	KeyboardLayout_Eng := 0x04090409
	keyboardlayout_rus := 0x04190419
	
	ControlGetFocus,ctl,A
	if(HKL = KeyboardLayout_Eng)
		setKeyboardLayout(A, keyboardlayout_rus)
	else
		setKeyboardLayout(A, keyboardlayout_Eng)

}
getKeyboardLayout(hwnd, ByRef keyBoardLayout = "")
{
	idThread := getWindowThreadProcessId(hwnd)

	keyboardLayout := DllCall("user32.dll\GetKeyboardLayout" , "uint", idThread, "uint")

	return keyboardLayout
}

;sets the keyboard layout for window with specified hwnd
setKeyboardLayout(hwnd, keyboardLayout)
{
	global WM_INPUTLANGCHANGEREQUEST

	idThread := GetWindowThreadProcessId(hwnd)

	SendMessage,0x50,0,keyboardLayout,,A ;WM_INPUTLANGCHANGEREQUEST
	;PostMessage, WM_INPUTLANGCHANGEREQUEST, 0, %keyboardLayout%, , ahk_id %hwnd%
}

getWindowThreadProcessId(hwnd)
{
	return dllCall("user32\GetWindowThreadProcessId", "Uint", hwnd)
}
