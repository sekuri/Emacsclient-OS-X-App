-- This applescript can be pasted in Automator applescript action where it replaces "(* Your script goes here *)"
   --p to be used to store list of input files, so need to initialise with empty string
   set p to ""
   if (count of input) is not 0 then
      repeat with fileToEdit in input
      	     --Convert each file in to posix paths
	     set p to p & "\"" & (POSIX path of fileToEdit) & "\" "
      end repeat
   end if
	tell application "Terminal"
	     if (count of windows) is 0 then
		do script with command "" -- Open a terminal window if one doesn't exist
	     end if
		do script "myemacs " & p in window 1
	end tell
