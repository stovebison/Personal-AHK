{ ; Intro
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SysGet, MonCenter, Monitor, 2
SysGet, MonRight, Monitor, 1
SysGet, MonUp, Monitor, 3
}

{ ; Disable Lock Keys
	{
	SetNumlockState, AlwaysOn
	SetCapsLockState, AlwaysOff
	SetScrollLockState, AlwaysOff
	return
	}
}	
{ ; Chrome links
	^!c::Run chrome.exe
	^!r::Run chrome.exe reddit.com
	^!t::Run chrome.exe gdax.com
	^!y::Run chrome.exe https://exchange.gemini.com/signin
	^!i::Run chrome.exe inbox.google.com
	^!o::Run chrome.exe https://login.microsoftonline.com/login.srf?wa=wsignin1.0&whr=asmr.com
	^!k::Run chrome.exe keep.google.com
	#!d::Run "A:\Chrome Downloads"
}
{ ; Mining
	^F1::Run "C:\Users\Stephan\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Ethereum Wallet.lnk"
	^F2::Run "C:\Users\Stephan\Desktop\Utilities\480.lnk"
	^F3::Run "C:\Users\Stephan\Desktop\Utilities\1060.lnk"
  { ^F4::      ; Both Miners`
		Run	"C:\Users\Stephan\Desktop\Utilities\1060.lnk"
		Run "C:\Users\Stephan\Desktop\Utilities\480.lnk"
		return
  }
}
{ ; Games
	^+a::Run "C:\Users\Stephan\Desktop\Utilities\Gaming Quickstart.bat"
  { ^+o::      ; Overwatch` 
		WinActivate, Blizzard App,,,, 
		ControlClick, X390 Y540, Blizzard App,,,, NA
		return
  }
	^+p::Run "A:\SteamLibrary\steamapps\common\Prey\Binaries\Danielle\x64\Release\Prey.exe"
	^+k::Run "A:\SteamLibrary\steamapps\common\RimWorld\RimWorldWin.exe"
}	
{ ; Programs
	^!s::Run "C:\Users\Stephan\AppData\Roaming\Spotify\Spotify.exe"
	^!a::Run "C:\Program Files (x86)\Steam\Steam.exe"
	^!b::Run "D:\Blizzard App\Battle.net Launcher.exe"
	^!z::Run "C:\Users\Stephan\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
	^!e::Run "C:\Program Files\Everything\Everything.exe"
}	
{ ; Utilities
  { #a:: 		 ; Audio Toggle
		{
			key++
			if key = 1
			{
				Run nircmd.exe setdefaultsounddevice "Hardwire"
				soundToggleBox("Hardwire")
			}
			else if key = 2
			{
				Run nircmd.exe setdefaultsounddevice "ASUS MX34V"
				soundToggleBox("ASUS MX34V")
			}
			else if key = 3
			{
				Run nircmd.exe setdefaultsounddevice "HD1 M2 AEBT"
				soundToggleBox("HD1 M2 AEBT")
				key = 0
			}
		}	
		Return
		; Display sound toggle GUI
		soundToggleBox(Device)
		{
			IfWinExist, soundToggleWin
			{
				Gui, destroy
			}
			
			Gui, +ToolWindow -Caption +0x400000 +alwaysontop
			Gui, Add, text, x35 y8, Default sound: %Device%
			SysGet, screenx, 0
			SysGet, screeny, 1
			xpos:=screenx-275
			ypos:=screeny-100
			Gui, Show, NoActivate x%xpos% y%ypos% h30 w200, soundToggleWi
			
			SetTimer,soundToggleClose, 2000
		}
		soundToggleClose:
			SetTimer,soundToggleClose, off
			Gui, destroy
		Return
  }
  { CapsLock:: ; Google Search
		{
		 Send, ^c
		 Sleep 50
		 Run, http://www.google.com/search?q=%clipboard%
		 Return
		}
	Return
  }
  { ^#m:: 	 ; Toggle Monitors
	toggle:=!toggle ; This toggles the variable between true/false
	if toggle
		{
			sleep 1000
			Run nircmd monitor off
		}
		else
		{
			Run nircmd monitor on
		}
	Return
  }
  { ; Spotify Volume Controls
		DetectHiddenWindows, On ;Detect Spotify even if it's minimized
		#IfWinExist ahk_class SpotifyMainWindow ;Only do the following if Spotify is running
		spotify = ahk_class SpotifyMainWindow ;Set variable for Spotify Window Name
		; "CTRL + ALT + UP" for volume up
		^!Up::
		{ 
			ControlSend, ahk_parent, ^{Up}, %spotify% 
			return 
		} 
		; "CTRL + ALT + DOWN" for volume down
		^!Down::
		{ 
			ControlSend, ahk_parent, ^{Down}, %spotify% 
			return 
		} 
		{	
			;Restore original window and mouse position.
			WinActivate ahk_id %winID%
			return
		}
		;Context menu helper function.
		GetContextMenuItemText(hMenu, nPos)
		{
			length := DllCall("GetMenuString"
					, "UInt", hMenu
					, "UInt", nPos
					, "UInt", 0 ; NULL
					, "Int", 0  ; Get length
					, "UInt", 0x0400)   ; MF_BYPOSITION
				VarSetCapacity(lpString, length + 1)
				length := DllCall("GetMenuString"
					, "UInt", hMenu
					, "UInt", nPos
					, "Str", lpString
					, "Int", length + 1
					, "UInt", 0x0400)
			return lpString
		}
	return
  }
  { ; Cinema Mode
    ^0:: 	 ; Dims/undims monitors
	toggle:=!toggle ; This toggles the variable between true/false
	if toggle
	{
		Run "A:\Blackground.jpg" ; open picture
		WinWaitActive, XnView - [blackground.jpg]
		WinMove, 4600, 800 ; move to correct monitor
		Sleep 100
		Send {F11} ; make fullscreen
		Sleep 200
		Run "A:\Blackground2.jpg"
		WinWaitActive, XnView - [blackground2.jpg]
		WinMove, 4750, -600
		Sleep 100
		Send {F11}
	}
	else
	{
		WinClose, XnView - [blackground.jpg]
		WinClose, XnView - [blackground2.jpg]
	}
	Return
  }
}    
{ ; Windows General
	^#e::Run explorer
	^#c::Run *RunAs cmd
	^+d::Run explorer "A:\Loose Files (Documents)\Documents"	
	^#v::Run *RunAs "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
}
{ ; AHK Hotkeys
	^F7::Run AutoHotkey "A:\AHK\Main.ahk"
	^F6::Run "A:\AHK\Main.ahk" ; Edit this script 
	^F5::Run "A:\AHK\Compile Main.bat" ; Compile this script and run
	^F8::Run "C:\Program Files\AutoHotkey\AU3_Spy.exe"
}

return

