-- Not_Lowest#0317, Not_Lowest
-- Contact me and I will update if you find bugs, or ways to improve it :)
-- Also please dont take my work and claim it as your own

-- Want this to autoupdate?! in a script do `local module = require(6591584739)` boom, autoupdate
--[[
	:BanPlr(name,reason) - Requires datastore
	:UnbanPlr(name,msg) - Requires datastore
	.IsStudio -- Checks if its studio
	:Notify(name,msg) -- Notifies the player
	:Announce(msg) - Well, announces
	.HTTPEnabled -- Checks if http requests are enabled
	.APIEnabled -- Checks if Studio Access to API is enabled
	.Error -- Legit just errors and breaks the module
	:GetRankInGroupMinMax(name,groupid,min,max) -- Checks if player is in group and if their between or equal to said ranks
	:GetRankInGroupMin(name,groupid,min) - checks if player is in group and if their at least minimum rank
	:GetPlrInGroup(name,groupid) -  Checks if player is in group
	:SpawnDummy(name,type,dummyname,shirtid,pantsid) -- spawns a dummy on the players name
	CHANGELOGS
	ADDED - Anticheat module
	ADDED - Load Trello
	ADDED - AntiBot credit to pasja
	ADDED - Resources in examples
	ADDED - Datastore2, recommended over Trello
	REMOVED - Auto Anticheat fork loading
]]

local GuiFolder = script.GUI
local Client = script.Client
local Server = script.Server
local ServerAssets = Server.Assets
local Main = script

local core = require(Main.CoreLoader)
local datastore = require(Server.DataStore2)
core.setup()

local t = {}

function findplr(name)
	return core.FindPlr(name)
end

--== Core Functions ==--

function t.IsStudio()
	return core.IsStudio()
end

function t.HTTPEnabled()
	return core.HttpEnabled()
end

function t.APIEnabled()

	return print("APIEnabled is currently under maintence")
end

--== Bans ==--

function t:SpawnDummy(name,type,dummyname,shirtid,pantsid)
	local plr = findplr(name)
	if type == "R6" or type == "R15" then
		if type == "R6" then
			local clone = ServerAssets.R6:Clone()
			if dummyname then
				clone.Name = dummyname				
			end
			if shirtid then
				local s = Instance.new("Shirt",clone)
				s.ShirtTemplate = shirtid
			end
			if pantsid then
				local p = Instance.new("Pants",clone)
				p.PantsTemplate = pantsid
			end
			clone.Parent = workspace
			clone:SetPrimaryPartCframe(plr.Character.Position)
		elseif type == "R15" then
			local clone = ServerAssets.R15:Clone()
			if dummyname then
				clone.Name = dummyname				
			end
			if shirtid then
				local s = Instance.new("Shirt",clone)
				s.ShirtTemplate = shirtid
			end
			if pantsid then
				local p = Instance.new("Pants",clone)
				p.PantsTemplate = pantsid
			end
			clone.Parent = workspace
			clone:SetPrimaryPartCframe(plr.Character.Position)
		end
	else
		return "Cannot spawn, type not specified"
	end
end

function t:BanPlr(name,reason)
	local plr = findplr(name)
	local TOS = "TOS Violation"
	print("WARNING: "..plr.Name.." IS A CHEATER!")
	local statsMain = game.ReplicatedStorage:FindFirstChild("StatsMain")
	local playerStats = statsMain:FindFirstChild(plr.Name)
	if playerStats then
		playerStats.BanReason = reason
		wait(2)
		playerStats.Banned = true
	end
end

function t:UnbanPlr(name)
	local plr = findplr(name)
	local id = game.Players:GetUserIdFromNameAsync(plr)
	local ds = game:GetService("DataStoreService"):GetDataStore("Stats")
	local key = ("id-"..id)
	local ban = false
	ds:SetAsync(key,ban)
end

function t.GiveGUI(name,gui)
	local plr = t.findplr(name)
	if gui:IsA("ScreenGui") then
		local c = gui:Clone()
		c.Parent = plr.PlayerGui
	end
end

--== Announce/Notify ==--

function t:Notify(name,msg)
	local plr = findplr(name)
	wait()
	print(plr)
	local UI = GuiFolder.Notif:Clone()
	UI.Frame.TextLabel.Text = msg
	UI.Parent = plr.PlayerGui
	UI.Frame:TweenPosition(UDim2.new(0.756,0,0.869,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,1)
	wait(5)
	UI.Frame:TweenPosition(UDim2.new(0.756,0,1,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,1)

end

function t:Announce(msg)
	for i,v in pairs(game.Players:GetChildren()) do
		local UI = GuiFolder.ANN:Clone()
		UI.Frame.TextLabel.Text = msg
		UI.Parent = v.PlayerGui
		UI.Frame:TweenPosition(UDim2.new(0.307,0,0,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,1)
		wait(5)
		UI.Frame:TweenPosition(UDim2.new(0.307,0,-0.15,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,1)
	end
end

--== Group Stuff ==--
function t:GetPlrRankMinMax(name,groupid,min,max)
	local plr = findplr(name)
	if plr:GetRankInGroup(groupid) >= min and plr:GetRankInGroup(groupid) <= max then
		return true
	end
end

function t:GetPlrRankMin(name,groupid,min)
	local plr = findplr(name)
	if plr:GetRankInGroup(groupid) >= min then
		return true
	end
end

function t:GetPlrInGroup(name,groupid)
	local plr = findplr(name)
	if plr:GetRankInGroup(groupid) then
		return true
	end
end

function t.Error()
	error("lol")
end


return t
