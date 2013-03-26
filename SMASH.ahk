; Initialize -------------------------------------------------------------------

; Script Settings
#SingleInstance #Force
SetBatchLines, -1
SetWinDelay, -1
SetKeyDelay, -1
DetectHiddenWindows, Off

; Include Lexikos' Vista Audio Control Functions library
#Include VA.ahk

; Tray Menu
Menu, Tray, NoStandard
Menu, Tray, Add, &Quit, QuitAction

return

; Win+Escape -------------------------------------------------------------------
#Escape::

; Mute the master volume
if A_OSVersion = WIN_XP ; Use SoundSet
	SoundSet, 1, MASTER, MUTE
else ; Use Lexikos' VA function
	VA_SetMasterMute(true)

; Minimize all windows
GroupAdd, AllWindows
WinMinimize ahk_group AllWindows

return

; Menu Actions -----------------------------------------------------------------
QuitAction:
ExitApp

; /Menu Actions