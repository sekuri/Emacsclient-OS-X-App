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
			try -- Handle possibility of window w/o tabs, e.g. when running command not in shell
				set allTabs to every tab of the thisWindow
			end try
			repeat with thisTab in allTabs
				-- Can't use 'busy' for test below. If shell is active then always busy at least \
				-- running login & bash. So OK to use if only those 2 processes running.
				set procs to (get processes of thisTab)
				if (count of procs) is equal to 2 and procs contains "login" and procs contains "bash" then
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
		tell application "System Events"
		    keystroke "c" using {control down}
		end tell
		do script "myemacs " & p in targetWindow
	end tell
