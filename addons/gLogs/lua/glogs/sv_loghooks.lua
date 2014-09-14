-- Log Hooks --
-- Here you can add existing logging systems to gLogs by either using a hook if the existing system has one or by overriding their 'AddLog' function.

-- ULX --
/* To integrate ULX add the 'gLogs.AddLog' function to the ULX's log function like shown below (ULX/lua/ulx/log.lua)
function ulx.logString( str, log_to_main )
	gLogs.AddLog("ulx", str, false) -- gLogs AddLog function added to ULX's. Notice that I don't use ULX's timestamp system to have standard timestamps in the logs.
	if not ulx.log_file then return end

	local dateStr = os.date( "%Y-%m-%d" )
	if curDateStr < dateStr then
		next_log()
	end

	if log_to_main then
		ServerLog( "[ULX] " .. str .. "\n" )
	end
	local date = os.date( "*t" )
	ulx.logWriteln( string.format( "[%02i:%02i:%02i] ", date.hour, date.min, date.sec ) .. str )
end
You will also need to add the ulx (ULX) type in your control panel!
*/

-- DarkRP --
if gLogs.DarkRP then -- if DarkRP's logging integration is enabled in gLogs's config file.
	timer.Simple(1, function() -- Required to make sure we override the functions.
		local function AdminLog(message, colour) -- Dependence for DarkRP
			local RF = RecipientFilter()
			for k,v in pairs(player.GetAll()) do
				local canHear = hook.Call("canSeeLogMessage", GAMEMODE, v, message, colour)

				if canHear then
					RF:AddPlayer(v)
				end
			end
			umsg.Start("DRPLogMsg", RF)
				umsg.Short(colour.r)
				umsg.Short(colour.g)
				umsg.Short(colour.b) -- Alpha is not needed
				umsg.String(message)
			umsg.End()
		end

		local DarkRPFile
		function DarkRP.log(text, colour)
			gLogs.AddLog("darkrp", text, false) -- gLogs AddLog function added to DarkRP's. Notice that I don't use DarkRP's timestamp system to have standard timestamps in the logs.
			if colour then
				AdminLog(text, colour)
			end
			if not GAMEMODE.Config.logging or not text then return end
			if not DarkRPFile then -- The log file of this session, if it's not there then make it!
				if not file.IsDir("DarkRP_logs", "DATA") then
					file.CreateDir("DarkRP_logs")
				end
				DarkRPFile = "DarkRP_logs/"..os.date("%m_%d_%Y %I_%M %p")..".txt"
				file.Write(DarkRPFile, os.date().. "\t".. text)
				return
			end
			file.Append(DarkRPFile, "\n"..os.date().. "\t"..(text or ""))
		end
	end)
end

-- Custom Logs --
if gLogs.Custom then
	-- First spawn (connection) --
	hook.Add("PlayerInitialSpawn", "gLogsConnectionHook", function( ply )
		gLogs.AddLog("connections", ply:Name().."("..ply:SteamID()..") spawned for the first time.", false)
	end)
	-- Death --
	hook.Add("PlayerDeath", "gLogsDeathHook", function( ply, ent, att )
		if att:IsPlayer() then
			gLogs.AddLog("deaths", ply:Name().."("..ply:SteamID()..") was killed by "..att:Name().."("..att:SteamID()..") with "..ent:GetClass()..".", false)
		else
			gLogs.AddLog("deaths", ply:Name().."("..ply:SteamID()..") was killed by the world.", false)
		end
	end)
	-- Disconnect --
	hook.Add("PlayerDisconnect", "gLogsDisconnectionHook", function( ply )
		gLogs.AddLog("disconnections", ply:Name().."("..ply:SteamID()..") disconnected.", false)
	end)
end