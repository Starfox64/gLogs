-- Custom Logs --
if gLogs.Custom then
	-- First spawn (connection) --
	hook.Add("PlayerInitialSpawn","gLogsConnectionHook",function(ply)
		gLogs.AddLog("connections",ply:Name().."("..ply:SteamID()..") spawned for the first time.",false)
	end)
	-- Death --
	hook.Add("PlayerDeath","gLogsDeathHook",function(ply,ent,att)
		if att:IsPlayer() then
			gLogs.AddLog("deaths",ply:Name().."("..ply:SteamID()..") was killed by "..att:Name().."("..att:SteamID()..") with "..ent:GetClass()..".",false)
		else
			gLogs.AddLog("deaths",ply:Name().."("..ply:SteamID()..") was killed by the world.",false)
		end
	end)
	-- Disconnect --
	hook.Add("PlayerDisconnect","gLogsDisconnectionHook",function(ply)
		gLogs.AddLog("disconnections",ply:Name().."("..ply:SteamID()..") disconnected.",false)
	end)
end
-- These are just examples of how gLogs can be used and you probably won't need to use it as most gamemodes (DarkRP, Nutscript) have theirs.