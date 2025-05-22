-- EPILIPSY WARNING.
-- SCRIPT RAPIDLY TELEPORTS THE PLAYER WITH ITS HEAD HALFWAY IN THE GROUND.
-- MAKE THE CAMERA BE HIGH IN THE AIR FACING DOWNWARDS AT THE PLAYER TO MINIMISE EFFECTS (it also just looks better anyways)

-- ";maxzoom 200" on betteriy is recommended: loadstring(game:HttpGet("https://raw.githubusercontent.com/Malrous/betteriy/refs/heads/main/biy"))()

-- // Made By: NOTGodlynoah \\
-- // Join the Discord at \\
-- // discord.gg/asu \\
-- // Made for: roblox.com/games/10106105124 \\

-- How to use:
-- Hit "p" to open shop to upgrade your tool faster.
-- Hit = and backspace at the same time to kill the script.
-- Profit.

-- // Config \\
local sellAfter = 50
local refresh = 5
local harvestRadius = 25  -- // Radius to harvest MORE wheat. \\
local shopPos = CFrame.new(226, 46, -444)
local sellPos = CFrame.new(93, 47, -439)
local YOffset = -2.5
local Enabled = true
local antiafk = true
local harvestEvent = game:GetService("ReplicatedStorage").RemoteEvents.Harvest
local sellPart = workspace:FindFirstChild("Sell") or workspace:WaitForChild("Sell", 10)
local wheatCache = {}

-- // The actual garbage code: \\






local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:FindFirstChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
getgenv().afk6464 = antiafk

-- // Anti-AFK \\
local vu, afkConn = game:GetService("VirtualUser")
local function afkOn()
    if not afkConn then
        afkConn = lp.Idled:Connect(function()
            if getgenv().afk6464 then
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end
        end)
    end
end
local function afkOff()
    if afkConn then afkConn:Disconnect() afkConn = nil end
end

-- // Keybinds \\
local bsDown, eqDown = false, false
local scriptDead = false
local beganConn, endedConn

-- // Im too fucking lazy to comment the rest \\
beganConn = uis.InputBegan:Connect(function(i, gp)
    if scriptDead or not Enabled then return end
    if i.KeyCode == Enum.KeyCode.Backspace then
        bsDown = true
    elseif i.KeyCode == Enum.KeyCode.Equals then
        eqDown = true
    elseif i.KeyCode == Enum.KeyCode.P then
        if not uis:GetFocusedTextBox() then
            local old = hrp.CFrame
            hrp.CFrame = shopPos * CFrame.Angles(math.rad(90),0,0) + Vector3.new(0, YOffset, 0)
            task.wait()
            hrp.CFrame = old
            task.wait()
        end
    end
    if bsDown and eqDown then
        Enabled = false
        scriptDead = true
        afkOff() getgenv().afk6464 = false
        if beganConn then beganConn:Disconnect() beganConn = nil end
        if endedConn then endedConn:Disconnect() endedConn = nil end
        print("Script Killed")
    end 
end)

endedConn = uis.InputEnded:Connect(function(i)
    if scriptDead then return end
    if i.KeyCode == Enum.KeyCode.Backspace then
        bsDown = false
    elseif i.KeyCode == Enum.KeyCode.Equals then
        eqDown = false
    end 
end)

local function getW()
    wheatCache = {rainbow={}, gold={}, norm={}}
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Wheat" and v.Parent then
            local pn = v.Parent.Name
            if pn:find("Rainbow",1,true) then 
                table.insert(wheatCache.rainbow,v)
            elseif pn:find("Golden",1,true) then 
                table.insert(wheatCache.gold,v)
            else 
                table.insert(wheatCache.norm,v)
            end 
        end 
    end
end

local function FatterHarvest()
    for _,wheatType in pairs({"rainbow","gold","norm"}) do
        for i,w in ipairs(wheatCache[wheatType]) do
            if w and w.Parent then
                local dist = (hrp.Position - w.Position).Magnitude
                if dist <= harvestRadius then
                    harvestEvent:FireServer({[1] = w:FindFirstChildOfClass("Vector3Value")})
                    table.remove(wheatCache[wheatType], i)
                end
            end
        end
    end
end

local function betterSell()
    if sellPart then
        firetouchinterest(hrp, sellPart, 0)
        task.wait()
        firetouchinterest(hrp, sellPart, 1)
    end
end

if getgenv().afk6464 then afkOn() end
local got = 0
while Enabled and task.wait(0.15 + math.random()*0.1) do
    if got % refresh == 0 then getW() end
    
    FatterHarvest()
    
    if math.random(3) == 1 then
        local t = #wheatCache.rainbow>0 and wheatCache.rainbow 
            or #wheatCache.gold>0 and wheatCache.gold 
            or wheatCache.norm
        if #t > 0 then
            local w = t[math.random(#t)]
            hrp.CFrame = CFrame.new(w.Position + Vector3.new(math.random(-2,2), YOffset, math.random(-2,2))) 
                * CFrame.Angles(math.rad(180),0,0)
        end
    end
    
    got = got + 1
    if got % sellAfter == 0 then
        betterSell()
    end 
end

afkOff()
print("Script Killed")








-- {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
-- {}                                                              {}
-- {}                                                              {}
-- {}    ███╗   ██╗ ██████╗ ████████╗ ██████╗  ██████╗ ██████╗     {}
-- {}    ████╗  ██║██╔═══██╗╚══██╔══╝██╔════╝ ██╔═══██╗██╔══██╗    {}
-- {}    ██╔██╗ ██║██║   ██║   ██║   ██║  ███╗██║   ██║██║  ██║    {}
-- {}    ██║╚██╗██║██║   ██║   ██║   ██║   ██║██║   ██║██║  ██║    {}
-- {}    ██║ ╚████║╚██████╔╝   ██║   ╚██████╔╝╚██████╔╝██████╔╝    {}
-- {}    ╚═╝  ╚═══╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝ ╚═════╝     {}
-- {}                                                              {}
-- {}                                                              {}
-- {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}






