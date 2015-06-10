-- Database Settings --
gLogs.Host = "localhost"    -- The IP of your MySQL server ('localhost' if on the same machine).
gLogs.User = "glogsuser"    -- The username that you wish to use to connect.
gLogs.Pass = "glogspasswd"  -- Duh...
gLogs.Database = "glogs"    -- The name of the database that you are using.
gLogs.Port = 3306           -- The port of your MySQL server.

-- Server Settings --
gLogs.ServerID = 1          -- The ID of your server (available in the 'servers' panel).
gLogs.ExpTime = 604800      -- Amount of time in seconds before the destruction of a log table (604800 = 7 days).
gLogs.Master = true         -- Is this server the master server meaning it will be the one dealing with old log tables.

-- gLogs Hooks --
gLogs.DarkRP = false        -- Hook DarkRP's logging system to gLogs.
gLogs.Nutscript = false     -- Hook Nutscript's logging system to gLogs.
gLogs.Custom = true         -- Enable various custom logs like Deaths and connections.