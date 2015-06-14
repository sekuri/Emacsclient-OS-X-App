	-- This applescript can be pasted in Automator applescript action where it replaces "(* Your script goes here *)"
	tell application "Terminal"
		set p to "" -- p to be used to store names of input files, so initialise with empty string
		if (count of input) is not 0 then
			repeat with fileToEdit in input
				set p to p & "\"" & (POSIX path of fileToEdit) & "\" " --Convert each file into posix paths
			end repeat
		end if
		set targetWindow to {}
		set allWindows to every window
		repeat with thisWindow in allWindows
			set allTabs to {}
			if exists tab in thisWindow then -- Handle Terminal weirdness since 1 window, 0 tabs possible
				set allTabs to every tab of the thisWindow
			end if
			repeat with thisTab in allTabs
				-- For whatever reason, we can't use 'busy' for test below; Terminal says tabs always busy
				-- So count processes. If not busy, should only be 2 (login & bash)
				if (count of (get processes of thisTab)) is equal to 2 then
					set selected of thisTab to true
					set targetWindow to thisWindow
					exit repeat
				end if
			end repeat
			if targetWindow is not {} then exit repeat
		end repeat
		if targetWindow is {} then
			set targetWindow to do script "" -- If all tabs are busy, launch new window
		end if
		do script "myemacs " & p in targetWindow
	end tell
