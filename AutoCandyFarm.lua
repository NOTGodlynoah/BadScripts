--[[ THIS SCRIPT IS A SOMEWHAT SHITTY RECRETION OF A PART OF THIS SCRIPT: loadstring(game:HttpGet('https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/CandyFarm.lua'))()

                ,_
                 :`.            .--//._
                  `.`-.        /  ',-""""'
                    `. ``~-._.'_."/
                      `~-._ .` `~;
                           ;.    /
                          /     /
                 Asu ,_.-';_,.'`
                      `"-;`/
                        ,'`

        October 2025 Halloween BABFT source 
           Thanks for using this script

                  love you all <3

]]
--// This script was made by ASU, with a few improvements on the server hopping method added by me.
if not game:IsLoaded() then
    game.Loaded:Wait()
end

if getgenv().CANDY_LOOP == true then --// Anti run twice
    return
else
    getgenv().CANDY_LOOP = true
end

--// Services
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

--// Vars
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local Houses = workspace:WaitForChild("Houses")

player.CharacterAdded:Connect(function(char)
    character = char
    hrp = character:WaitForChild("HumanoidRootPart")
end)

    local UserInventory = {}
    local Inventory = player.Data

    for _, child in pairs(Inventory:GetChildren()) do
        if child:IsA("IntValue") then

            UserInventory[child.Name] = child.Value
        end
    end

local Pool = {}

local function Force(part, ws)
    if Pool[part] then return end

    Pool[part] = RunService.Heartbeat:Connect(function()
        if not part or not part.Parent then
            Pool[part]:Disconnect()
            Pool[part] = nil
            return
        end
        part.CFrame = hrp.CFrame
        part.Size = Vector3.new(10, 10, 10)
        part.CanCollide = false
        part.Transparency = 1

        if ws ~= 0 then
            character:WaitForChild("Humanoid").WalkSpeed = ws
        end
    end)
end

local a = 0
local function AutoFarm()
    local ws = character:WaitForChild("Humanoid").WalkSpeed
    local h = Houses:GetDescendants()
    for _, sdf in ipairs(h) do
        if sdf.Name == "DoorInnerTouch" and sdf:IsA("BasePart") then
            if not sdf:GetAttribute("Forced") then
                a = a + 1
                Force(sdf, ws)
                sdf:SetAttribute("Forced", true)
            end
        end
    end

    for _, sdf in ipairs(h) do
        if sdf.Name == "GiantHand" then
            sdf:Destroy()
        end
    end
end

AutoFarm()
StarterGui:SetCore("SendNotification", {
    Title = "Candy Farm - Asu",
    Text = string.format("Claiming %d Houses...", a),
    Icon = "rbxassetid://7781284023", 
    Duration = 4
})

wait(0.2)

if a ~= 0 then
    local to = 10
    local st = tick()

    repeat
        task.wait()
    until player.Data.CandyBlue.Value ~= UserInventory["CandyBlue"]
       or player.Data.CandyOrange.Value ~= UserInventory["CandyOrange"]
       or player.Data.CandyPurple.Value ~= UserInventory["CandyPurple"]
       or (tick() - st) >= to

    if (tick() - st) >= to then
        StarterGui:SetCore("SendNotification", {
            Title = "Candy Farm - Asu",
            Text = "Something went wrong..",
            Icon = "rbxassetid://7781288646", 
            Duration = 3
        })
    end
end
wait(2)

--// Server hop and handling shop errors
StarterGui:SetCore("SendNotification", {
    Title = "Candy Farm - NOTGod",
    Text = "Server Hopping...",
    Icon = "rbxassetid://7781288646", 
    Duration = 3
})

local JobId = game.JobId
local PlaceId = game.PlaceId
local HttpService = cloneref(game:GetService("HttpService"))
local TeleportService = cloneref(game:GetService("TeleportService"))

function missing(t, f, fallback) --// IY shop and queueteleport as fallback
    if type(f) == t then return f end
    return fallback
end

queueteleport =  missing("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or queueonteleport)
httprequest =  missing("function", request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request))

-- Noahs dum server hopping/saving api stuff to make it more efficient
local wsFolder="candyfarm"local apiFile=wsFolder.."/lastapi.txt"
if not isfolder(wsFolder)then makefolder(wsFolder)end 
local function lApiData()if isfile(apiFile)then return HttpService:JSONDecode(readfile(apiFile))else writefile(apiFile,HttpService:JSONEncode({servers={}}))return{servers={}}end end
local function sApiData(data)writefile(apiFile,HttpService:JSONEncode(data))end
local function UpdVisCount(data,curId)for sid,info in pairs(data.servers)do if info.VisCount and info.VisCount>0 then info.VisCount=info.VisCount-1 end if info.VisCount==0 then data.servers[sid]=nil end end data.servers[curId]={VisCount=10} end-- NOTGodlynoah on top (lol)
local function grabSL()local r=httprequest({Url="https://games.roblox.com/v1/games/537413528/servers/Public?sortOrder=Asc&limit=100"})return HttpService:JSONDecode(r.Body)end
local curId=game.JobId local apiData=lApiData()UpdVisCount(apiData,curId)sApiData(apiData)local serverList=grabSL().data
local Blklist={}for sid,info in pairs(apiData.servers)do if info.VisCount and info.VisCount>=1 then Blklist[sid]=true end end
local canHop={}for _,s in ipairs(serverList)do if not Blklist[s.id]and s.playing>=2 and s.playing<=5 then table.insert(canHop,s.id)end end
apiData.servers[curId]={VisCount=10,playercount=#game.Players:GetPlayers(),serverid=curId}
sApiData(apiData)

local function SHPer() local plr = game:GetService("Players").LocalPlayer
if plr and typeof(plr.OnTeleport)=="RBXScriptSignal"then plr.OnTeleport:Connect(function(state)
if state == Enum.TeleportState.Started and typeof(queueteleport) == "function" then
queueteleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/NOTGodlynoah/BadScripts/refs/heads/main/AutoCandyFarm.lua"))()]])
end end)end end
SHPer()

local function getServers()
    local servers = {}
    local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", 537413528)})
    local body = HttpService:JSONDecode(req.Body)

    if body and body.data then
        for _, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end
    return servers
end

local function Shop()
    local servers = {}
    for _,id in ipairs(canHop) do table.insert(servers,id) end
    if #servers == 0 then
        StarterGui:SetCore("SendNotification", {
          Title = "Candy Farm - Asu",
          Text = "No server found, retrying in 5 seconds (NOTGOD SUCKS AT CODING)",
          Icon = "rbxassetid://7781250539", 
          Duration = 4
        })
        task.wait(5)
        return Shop()
    end

    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
    end)

    if not success then
        StarterGui:SetCore("SendNotification", {
          Title = "Candy Farm - Asu",
          Text = "Failed to Server Hop, retrying in 2 seconds (NOTGOD SUCKS AT CODING)",
          Icon = "rbxassetid://7781250539", 
          Duration = 4
        })
        task.wait(2)
        Shop()
    end
end

TeleportService.TeleportInitFailed:Connect(function(player, errorMessage)
    if player == Players.LocalPlayer then
        StarterGui:SetCore("SendNotification", {
            Title = "Candy Farm - Asu",
            Text = "Server full, retrying in 2 seconds (NOTGOD SUCKS AT CODING)",
            Icon = "rbxassetid://7781250539",
            Duration = 4
        })
        task.wait(2)
        Shop()
    end
end)

Shop()
