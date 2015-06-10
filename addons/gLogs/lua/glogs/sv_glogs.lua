require("mysqloo")

gLogs.db = mysqloo.connect(gLogs.Host,gLogs.User,gLogs.Pass,gLogs.Database,gLogs.Port)

function gLogs.db:onConnected()
	print("[gLogs] Successfully connected!")
	gLogs.InitializeTable()
	if gLogs.Master then
		gLogs.CleanUpLogs()
	end
end

function gLogs.db:onConnectionFailed(err)
	print("[gLogs] Connection Failed!")
	print("Error:\n"..err)
end

gLogs.db:connect()

function gLogs.AddLog(logtype,log)
	if not gLogs.CurrentTable then return end

	if type(logtype) != "string" then
		error("string expected, got "..type(logtype))
	elseif type(log) != "string" then
		error("string expected, got "..type(log))
	end	

	logtype = gLogs.db:escape(logtype)
	log = gLogs.db:escape(log)
	
	local query = gLogs.db:query("INSERT INTO `"..gLogs.Database.."`.`"..gLogs.CurrentTable.."` (`line`, `type`, `time`, `log`) VALUES (NULL, '"..logtype.."', "..os.time()..",'"..log.."');")

	function query:onError(err,sql)
		print("[gLogs] Failed to insert log!")
		print("Query:\n"..sql)
		print("Error:\n"..err)
	end

	query:start()
end

function gLogs.InitializeTable()
	local date = string.Replace(string.Replace(string.Replace(os.date(),":","-"),"/","-")," ","-")
	gLogs.CurrentTable = gLogs.ServerID.."-"..date
	local query = gLogs.db:query("CREATE TABLE IF NOT EXISTS `"..gLogs.Database.."`.`"..gLogs.CurrentTable.."` ( `line` int(10) NOT NULL AUTO_INCREMENT, `type` varchar(20) NOT NULL, `time` int(10) NOT NULL, `log` text NOT NULL, PRIMARY KEY (`line`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;")

	function query:onSuccess(data)
		print("[gLogs] Today's log table successfully created!")
	end

	function query:onError(err,sql)
		print("[gLogs] Failed to create today's log table!")
		print("Error:\n"..err)
	end

	query:start()

	local manifest = gLogs.db:query("INSERT INTO `"..gLogs.Database.."`.`manifest` (`logname`, `server`, `expire`) VALUES ('"..gLogs.CurrentTable.."', '"..gLogs.ServerID.."', '"..os.time() + gLogs.ExpTime.."');")

	function manifest:onSuccess(data)
		print("[gLogs] Today's log table added to the manifest!")
	end

	function manifest:onError(err,sql)
		print("[gLogs] Failed to add today's log table to the manifest!")
		print("Error:\n"..err)
	end

	manifest:start()
end

function gLogs.CleanUpLogs()
	local query = gLogs.db:query("SELECT `logname`,`expire` FROM `"..gLogs.Database.."`.`manifest` WHERE `server` = "..gLogs.ServerID..";")

	function query:onSuccess(data)
		print("[gLogs] Looking for old log tables...")
		for k,log in pairs(data) do
			if tonumber(log.expire) < os.time() then
				local clear = gLogs.db:query("DELETE FROM `"..gLogs.Database.."`.`manifest` WHERE `logname` = \""..log.logname.."\";")

				function clear:onSuccess(data)
					print("[gLogs] "..log.logname.." Removed.")
				end

				function clear:onError(err,sql)
					print("[gLogs] Failed to update the manifest ("..log.logname..")!")
					print("Error:\n"..err)
				end

				clear:start()

				local drop = gLogs.db:query("DROP TABLE `"..gLogs.Database.."`.`"..log.logname.."`;")

				function drop:onError(err,sql)
					print("[gLogs] Failed to remove old log table ("..log.logname..")!")
					print("Error:\n"..err)
				end

				drop:start()
			end
		end
	end

	function query:onError(err,sql)
		print("[gLogs] Failed to retrieve the log manifest!")
		print("Error:\n"..err)
	end

	query:start()

	timer.Simple(600,function()
		gLogs.CleanUpLogs()
	end)
end