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
Menu, Tray, Add, &Casual Mode, ToggleCasualMode
Menu, Tray, Add, &Insane Mode, ToggleInsaneMode
Menu, Tray, Add ; separator
Menu, Tray, Add, &About, About
Menu, Tray, Add, &Quit, Quit

; Variables
IniRead, casual_mode, SMASH.config, main, casual_mode, false
GoSub, SetCasualMode
IniRead, casual_mode_path, SMASH.config, main, casual_mode_path, %A_Space%

IniRead, insane_mode, SMASH.config, main, insane_mode, false
GoSub, SetInsaneMode
Random, insane_mode_number, 1, 10

return

; Win+Escape -------------------------------------------------------------------
#Escape::

if insane_mode = false
{
	Mute()
	
}
else if insane_mode = true
{
	if insane_mode_number = 7
	{
		VolMax()
	}
	else
	{
		Mute()
	}
}

; Minimize all windows
GroupAdd, AllWindows
WinMinimize ahk_group AllWindows

; Launch Casual Mode path
if casual_mode = true
{
	Run, %casual_mode_path%
}

; Update Insane Mode number
Random, insane_mode_number, 1, 10

return

; Functions --------------------------------------------------------------------

Mute() ; Mute the master volume
{
	if A_OSVersion = WIN_XP ; Use SoundSet
	{
		SoundSet, 1, MASTER, MUTE
	}
	else ; Use Lexikos' VA function
	{
		VA_SetMasterMute(true)
	}
}

VolMax() ; Unmute and set the master volume to 100%
{
	if A_OSVersion = WIN_XP ; Use SoundSet
	{
		SoundSet, 0, MASTER, MUTE
		SoundSet, 100, MASTER, VOLUME
	}
	else ;Use Lexikos' VA function
	{
		VA_SetMasterMute(false)
		VA_SetMasterVolume(100)
	}
}

; Menu Actions -----------------------------------------------------------------
About:
Run, % "http://igalvez.net/?p=480"
return

Quit:
ExitApp

SetCasualMode:
if casual_mode = true
	Menu, Tray, Check, &Casual Mode
return

ToggleCasualMode:
if casual_mode = false
{
	casual_mode = true
	Menu, Tray, Check, &Casual Mode
}
else
{
	casual_mode = false
	Menu, Tray, Uncheck, &Casual Mode
}
return

SetInsaneMode:
if insane_mode = true
	Menu, Tray, Check, &Insane Mode
return

ToggleInsaneMode:
if insane_mode = false
{
	insane_mode = true
	Menu, Tray, Check, &Insane Mode
}
else
{
	insane_mode = false
	Menu, Tray, Uncheck, &Insane Mode
}
return