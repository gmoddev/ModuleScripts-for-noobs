--module script
local core = {}

local main = script.Parent
local server = main.Server

function core.LoadTrello(key,token)
	print("== WARNING ==")
	print("You can only set the key and token once!")
	server.Trello.Key = key
	server.Trello.Token = token
	require(server.Trello)
end

function core.HttpEnabled()
	return pcall(function()
		game:GetService('HttpService'):GetAsync('http://www.google.com/')
	end)
end
function core.APIEnabled()
	return pcall(function()
		local st = game:GetService("DataStoreService"):GetDataStore('test')
	end)
end

function core.IsStudio()
	return game:GetService("RunService"):IsStudio()
end

function core.FindPlr(name)
	for i,v in pairs(game.Players:GetChildren()) do
		if v.Name == name then
			return v
		end
	end
end


function core.setup()
	script.Parent.Parent = game.ServerScriptService
	script.Parent.ThumbnailCamera:Destroy()
	require(1936396537) -- Loads datastore2
	script.Name = "AdminModule"
	print([[		
	==== Admin Module Loaded ====
	     ==== Commands ====
	:BanPlr(name,reason) - Requires datastore
	:UnbanPlr(name,msg) - Requires datastore
	.IsStudio -- Checks if its studio
	:Notify(name,msg) -- Notifies the player
	:Announce(msg) - Well, announces
	.HTTPEnabled -- Checks if http requests are enabled
	.APIEnabled -- Checks if Studio Access to API is enabled
	.Error - what do you think it does? errors
	:GetRankInGroupMinMax(name,groupid,min,max) -- Checks if player is in group and if their between or equal to said ranks
	:GetRankInGroupMin(name,groupid,min) - checks if player is in group and if their at least minimum rank
	:GetPlrInGroup(name,groupid) -  Checks if player is in group
	:SpawnDummy(name,type,dummyname,shirtid,pantsid) -- spawns a dummy on the players name
	CHANGELOGS
	ADDED - Anticheat module
	ADDED - Load Trello
	ADDED - AntiBot credit to pasja
	ADDED - Resources in examples
	ADDED - Datastore2 - Reccomended over Trello
	REMOVED - Auto Anticheat fork loading
	     ==== Credits ====
	     Made by Not_Lowest
	     pasja for AntiBot
	     Testing done by: 
	     scaryf0x39
	     AidenGamingUk
	     Bug Finders:
	     None Yet :(
	==== Admin Module Loaded ====
	]])
	warn("admin module loaded made by: Not_Lowest")
	if not core.HttpEnabled() then
		warn("===================== WARNING =====================")
		warn("HTTP Requests is not enabled, please enable it as the datastore will not work.")
		warn("To enable HTTP Requests in studio click on Game Settings, and go to security!")
		warn("===================== WARNING =====================")
		wait()
		script:Destroy()
	end
	if not core.APIEnabled() then
		warn([[		
	=============== WARNING ===============
			Studio Access to API Server is off!
		To enable API Services; Click on Game Settings, and go to security!
	=============== WARNING ===============
	]])
	end
end

return core
