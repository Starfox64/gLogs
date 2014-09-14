gLogs = {}

print("[gLogs] Initializing...")
-- Load files...
include("glogs/sv_config.lua")
include("glogs/sv_glogs.lua")
include("glogs/sv_loghooks.lua")
-- Lets let them know that we are done.
print("[gLogs] Initialized Version: "..gLogs.Version)