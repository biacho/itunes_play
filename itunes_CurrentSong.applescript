
repeat
	tell application "System Events"
		set num to count (every process whose name is "iTunes")
	end tell
	
	if num > 0 then
		tell application "iTunes"
			set playState to (player state as text)
			if playState is equal to "playing" then
				set trackName to name of current track
				set artistName to artist of current track
				set albumName to album of current track
				
				if artistName is equal to "" then
					set trackInfo to "Apple Radio: " & trackName
				else
					set trackInfo to artistName & " | " & "(" & albumName & ")" & " - " & trackName
				end if
				
			else if playState is equal to "stop" then
				set trackInfo to "Pause"
			else
				set trackInfo to "Nothing playing"
			end if
			set scriptPath to POSIX path of ((path to me as text) & "::" & "iTunes_CurrentSong.txt")
			do shell script "echo " & scriptPath
			do shell script "echo " & quoted form of trackInfo & " > " & quoted form of scriptPath
		end tell
	else
		set trackInfo to "iTunes is OFF"
		set scriptPath to POSIX path of ((path to me as text) & "::" & "iTunes_CurrentSong.txt")
		do shell script "echo " & scriptPath
		do shell script "echo " & quoted form of trackInfo & " > " & quoted form of scriptPath
		
		set answ to (display alert "iTunes is OFF. Do you want to run iTunes?" buttons {"Yes", "No"})
		if button returned of result = "Yes" then
			run application "iTunes"
		else if button returned of result = "No" then
			return answ
		end if
		
	end if
	delay 5
end repeat