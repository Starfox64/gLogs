if SERVER then
	print("[gLogs] Initializing...")

	gLogs = {}

	AddCSLuaFile("sh_gversion.lua")
	include("sh_gversion.lua")
	include("glogs/sv_config.lua")
	include("glogs/sv_glogs.lua")

	local hooks = file.Find("glogs/hooks/*.lua", "LUA")
	for k,v in pairs(hooks) do
		include("glogs/hooks/"..v)
	end

	print("[gLogs] Initialized")
else
	include("sh_gversion.lua")
end