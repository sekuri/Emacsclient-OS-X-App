-- This applescript can be pasted in Automator applescript action where it replaces "(* Your script goes here *)"
on run {input, parameters}
   set doesExist to false --assume iTerm2 does not exist
   --p to be used to store list of input files, so need to initialise with empty string
   set p to ""
   if (count of input) is not 0 then
      repeat with fileToEdit in input
      	     --Convert each file in to posix paths
	     set p to p &amp; "\"" &amp; (POSIX path of fileToEdit) &amp; "\" "
      end repeat
   end if
   try
	do shell script "osascript -e 'exists application \"iTerm2\"'"
	set doesExist to true
   end try
   if doesExist is true then
      tell application "iTerm2"
      	   if (count of terminals) = 0 then
	      	set t to (make new terminal)
	   else
		set t to current terminal
	   end if
	   tell t
	   	tell the last session
		     write text "myemacs " &amp; p &amp; ";"
		end tell
	   end tell
      end tell
   else
	tell application "Terminal"
	     if (count of windows) is 0 then
		do script with command "" -- Open a terminal window if one doesn't exist
	     end if
		do script "myemacs " &amp; p in window 1
	end tell
   end if
   return input
end run
