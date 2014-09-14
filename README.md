gLogs
=====

gLogs is a MySQL logging framework for Garry's Mod. It permits server admins to easily look through their logs on a web interface.

Requirements
------------
* [mysqloo]
* PHP
* MySQL

Installation
------------
To install gLogs simply drag and drop the addons folder in your 'garrysmod' root folder.
Open 'addons/gLogs/lua/glogs/sv_config.lua' in a text editor and enter your MySQL credentials as well as your server id, the log expiration time and if you wish to enable some of the existing log hooks already made. Make sure that your server id is different for every server that is connecting to your database.

To install the gLogs website simply copy the files in the 'Web' folder to the root or in a folder on your web host.
Now open your web browser and navigate to 'www.yourwebsite.com/(gLogsInstallPath)/install' and follow the instructions on screen.

gLogs for Devs
--------------
```lua
if gLogs then -- Let's check if gLogs is installed.
    gLogs.AddLog("mylogtype", "MyFancyLog", false)
end
```
Arguments:
* Log Type (string): The type of log. This will be used as a filter on the website.
* Log (string): The text that is your log.
* No Timestamp (bool): If you wish to disable gLogs timestamps.

[mysqloo]:http://facepunch.com/showthread.php?t=1357773
