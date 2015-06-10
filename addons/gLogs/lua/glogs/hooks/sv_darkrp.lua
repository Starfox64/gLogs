-- DarkRP --
if gLogs.DarkRP then -- if DarkRP's logging integration is enabled in gLogs's config file.
	timer.Simple(1, function() -- Required to make sure we override the functions.
		local function AdminLog(message, colour) -- Required for DarkRP
			local RF = RecipientFilter()
			for k,v in pairs(player.GetAll()) do
				local canHear = hook.Call("canSeeLogMessage",GAMEMODE,v,message,colour)

				if canHear then
					RF:AddPlayer(v)
				end
			end
			umsg.Start("DRPLogMsg",RF)
				umsg.Short(colour.r)
				umsg.Short(colour.g)
				umsg.Short(colour.b)
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
			if not DarkRPFile then
				if not file.IsDir("DarkRP_logs","DATA") then
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
-- DarkRP's comments were removed so you can quickly identify the important ones for gLogs.