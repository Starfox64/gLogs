-- Log Hooks --
-- Here you can add existing logging systems to gLogs by either using a hook if the existing system has one or by overriding their 'AddLog' function.

-- ULX EXAMPLE --
-- To integrate ULX add the 'gLogs.AddLog' function to the ULX's log function like shown below (ULX/lua/ulx/log.lua)
function ulx.logString(str,log_to_main)
	gLogs.AddLog("ulx",str,false) -- gLogs AddLog function added to ULX's. Notice that I don't use ULX's timestamp system to have standard timestamps in the logs.
	if not ulx.log_file then return end

	local dateStr = os.date("%Y-%m-%d")
	if curDateStr < dateStr then
		next_log()
	end

	if log_to_main then
		ServerLog("[ULX] " .. str .. "\n")
	end
	local date = os.date("*t")
	ulx.logWriteln(string.format("[%02i:%02i:%02i]",date.hour,date.min,date.sec) ..str)
end
-- You will also need to add the ulx (ULX) type in your control panel!