gLogs = {}

print("[gLogs] Initializing...")
-- Load files...
include("glogs/sv_config.lua")
include("glogs/sv_glogs.lua")
-- Load log hooks...
local hooks = file.Find("glogs/hooks/*.lua", "LUA")
for k,v in pairs(hooks) do
	include("glogs/hooks/"..v)
end
-- Lets let them know that we are done.
print("[gLogs] Initialized Version: "..gLogs.Version)