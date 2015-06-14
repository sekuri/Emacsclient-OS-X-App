	-- This applescript can be pasted in Automator applescript action where it replaces "(* Your script goes here *)"
	-- p to be used to store list of input files, so need to initialise with empty string
	tell application "Terminal"
		set p to ""
		if (count of input) is not 0 then
			repeat with fileToEdit in input
				--Convert each file in to posix paths
				set p to p & "\"" & (POSIX path of fileToEdit) & "\" "
			end repeat
		end if
		set targetWindow to null
		set allWindows to every window
		repeat with thisWindow in allWindows
			set allTabs to every tab of the thisWindow
			repeat with thisTab in allTabs
				set currentProc to get processes of thisTab
				if currentProc as string is equal to "loginbash" then
					set selected of thisTab to true
					set targetWindow to thisWindow
					exit repeat
				end if
			end repeat
			if targetWindow is not null then exit repeat
		end repeat
		if targetWindow is null then
			set targetWindow to do script ""
		end if
		do script "myemacs " & p in targetWindow
	end tell
