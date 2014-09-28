local gVersion = {}
gVersion.FilePath = "data/glogs_version.txt" -- Where is the local version file stored.
gVersion.Cloud = "https://raw.githubusercontent.com/Starfox64/gLogs/master/addons/gLogs/data/glogs_version.txt" -- The URL of the remote version file if you are using a file from GitHub you can get this link by hitting 'RAW' on it.
gVersion.AddonName = "gLogs" -- The name of your addon. (Must be unique to avoid conflicts with other gVersion instances.)
gVersion.NotifyClient = true -- Should gVersion echo whether or not the addon is up to date to clients?

if SERVER then
	function gVersion.CheckForUpdates()
		http.Fetch(gVersion.Cloud,
			function( data )
				if file.Exists(gVersion.FilePath, "GAME") then
					gVersion.Local = tonumber(file.Read(gVersion.FilePath, "GAME")) or 0
				else
					gVersion.Local = 0
					MsgC(Color(255, 100, 100), "[gVersion] ")
					MsgC(Color(255, 100, 100), gVersion.AddonName.." could not find it's local version!\n")
				end
				gVersion.Remote = tonumber(data) or 0
				MsgC(Color(255, 100, 100), "[gVersion] ")
				if gVersion.Remote <= gVersion.Local then
					gVersion.Status = 3
					MsgC(Color(100, 255, 100), gVersion.AddonName.." is up to date! (Revision: "..gVersion.Remote..")\n")
				else
					gVersion.Status = 2
					MsgC(Color(255, 255, 100), gVersion.AddonName.." is not up to date! (Local: "..gVersion.Local..", Remote: "..gVersion.Remote..")\n")
				end
			end,
			function( err )
				gVersion.Status = 1
				MsgC(Color(255, 100, 100), "[gVersion] ")
				MsgC(Color(255, 100, 100), gVersion.AddonName.." could not check for updates!\n")
				MsgN(err)
			end
		)
	end
	gVersion.CheckForUpdates()
end

if gVersion.NotifyClient then
	if SERVER then
		util.AddNetworkString("gVersionNotify")
		hook.Add("PlayerInitialSpawn", "gVersion_"..gVersion.AddonName, function( ply )
			net.Start("gVersionNotify")
			net.WriteInt(gVersion.Status or 0, 4)
			net.WriteString(gVersion.AddonName)
			net.Send(ply)
		end)
	else
		net.Receive("gVersionNotify", function()
			local status = net.ReadInt(4)
			local name = net.ReadString()
			MsgC(Color(255, 100, 100), "[gVersion] ")
			if status == 0 then
				MsgC(Color(255, 100, 100), name.." unknown error!\n")
			elseif status == 1 then
				MsgC(Color(255, 100, 100), name.." could not check for updates!\n")
			elseif status == 2 then
				MsgC(Color(255, 255, 100), name.." is not up to date!\n")
			elseif status == 3 then
				MsgC(Color(100, 255, 100), name.." is up to date!\n")
			end
		end)
	end
end