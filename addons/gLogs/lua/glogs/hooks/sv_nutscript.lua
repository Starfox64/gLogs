-- Nutscript --
if gLogs.Nutscript then -- if Nutscript's logging integration is enabled in gLogs's config file.
	timer.Simple(1,function() -- Required to make sure we override the functions.
		local serverLog = {}
		local autosavePerLines = 1000

		function nut.util.AddLog(string,filter,consoleprint)
			if (consoleprint != false) then
				MsgC(timeColor,"[" .. os.date() .. "] ")
				MsgC(textColor,string .. "\n")
				
				for k, client in pairs(player.GetAll()) do
					if (client:IsAdmin() and client:GetInfoNum("nut_showlogs", 1) > 0) then
						netstream.Start(client,"nut_SendLogLine",string)
					end
				end
			end

			if (filter != LOG_FILTER_NOSAVE) then
				table.insert(serverLog,"[" .. os.date() .. "] " .. string)
				gLogs.AddLog("nutscript",string,false) -- gLogs AddLog function added to Nutscript's.
			end

			if (#serverLog >= autosavePerLines) then
				nut.util.SaveLog()
			end
		end

		function nut.util.GetLog()
			return serverLog
		end

		function nut.util.SaveLog(autosave)
			local string = ""
			for k, v in pairs(serverLog) do
				string = string .. v .. "\n"
			end
			local filename = string.Replace(os.date(),":","_")
			filename = string.Replace(filename,"/","_")
			filename = filename .. "_readable"
			file.CreateDir("nutscript/"..SCHEMA.uniqueID.."/logs")
			file.Write("nutscript/"..SCHEMA.uniqueID.."/logs/".. filename ..".txt", string)
			serverLog = {}
		end
	end)
end
-- Nutscript's comments were removed so you can quickly identify the important ones for gLogs.