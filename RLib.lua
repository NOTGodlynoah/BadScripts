-- rlib by NOTGodlynoah
local rlib = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function getRoot(char)
    return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
end

local function toVec3(a, b, c)
    if typeof(a) == "Vector3" then
        return a
    elseif tonumber(a) and tonumber(b) and tonumber(c) then
        return Vector3.new(tonumber(a), tonumber(b), tonumber(c))
    else
        error("Invalid arguments for Vector3")
    end
end

function rlib.tppos(a, b, c)
    local root = getRoot(LocalPlayer.Character)
    if root then root.CFrame = CFrame.new(toVec3(a, b, c)) end
end

function rlib.leave()
    game:Shutdown()
end

function rlib.tp(username)
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Name:lower():sub(1, #username) == username:lower() then
            local theirRoot = getRoot(plr.Character)
            if theirRoot then rlib.tppos(theirRoot.Position) end
            break
        end
    end
end

function rlib.moveto(a, b, c, speed, timeout)
    local root = getRoot(LocalPlayer.Character)
    if not root then return end
    local pos = toVec3(a, b, c)
    local start = tick()
    while (root.Position - pos).Magnitude > 3 and (not timeout or tick() - start < timeout) do
        local dir = (pos - root.Position).Unit
        root.CFrame = root.CFrame + dir * (speed or 16) * RunService.Heartbeat:Wait()
    end
end

function rlib.follow(username, seconds)
    local target = nil
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Name:lower():sub(1, #username) == username:lower() then
            target = plr
            break
        end
    end
    if not target then return end
    local start = tick()
    while tick() - start < (seconds or 10) do
        local theirRoot = getRoot(target.Character)
        if theirRoot then rlib.tppos(theirRoot.Position + Vector3.new(0,2,0)) end
        RunService.Heartbeat:Wait()
    end
end

function rlib.pathwalk(points, speed)
    for _,pos in ipairs(points) do
        if typeof(pos) == "table" and #pos == 3 then
            pos = Vector3.new(pos[1], pos[2], pos[3])
        end
        rlib.moveto(pos, speed)
    end
end

function rlib.noclip(state)
    local char = LocalPlayer.Character
    if not char then return end
    for _,v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = not state end
    end
end

function rlib.lockplayer(state)
    local char = LocalPlayer.Character
    if not char then return end
    for _,v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then v.Anchored = state end
    end
end

function rlib.antiVoid(state, a, b, c)
    if state then
        rlib._antivoidConn = RunService.Heartbeat:Connect(function()
            local root = getRoot(LocalPlayer.Character)
            if root and root.Position.Y < -10 then
                root.CFrame = CFrame.new(toVec3(a or 0, b or 10, c or 0))
            end
        end)
    elseif rlib._antivoidConn then
        rlib._antivoidConn:Disconnect()
        rlib._antivoidConn = nil
    end
end

function rlib.setvel(a, b, c)
    local root = getRoot(LocalPlayer.Character)
    if root then root.Velocity = toVec3(a, b, c) end
end

function rlib.novel(t)
    local root = getRoot(LocalPlayer.Character)
    if not root then return end
    local stop = tick() + (t or 1)
    while tick() < stop do
        root.Velocity = Vector3.new()
        RunService.Heartbeat:Wait()
    end
end

function rlib.rot(x,y,z)
    local root = getRoot(LocalPlayer.Character)
    if root then root.CFrame = root.CFrame * CFrame.Angles(math.rad(x or 0), math.rad(y or 0), math.rad(z or 0)) end
end

function rlib.rotvel(x,y,z)
    local root = getRoot(LocalPlayer.Character)
    if root then root.RotVelocity = Vector3.new(x or 0, y or 0, z or 0) end
end

function rlib.jump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end

function rlib.sit()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then hum.Sit = true end
end

function rlib.anim(id)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://"..tostring(id)
        local track = hum:LoadAnimation(anim)
        track:Play()
    end
end

function rlib.reset()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then hum.Health = 0 end
end

function rlib.antiRagdoll(state)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then hum.PlatformStand = not state end
end

function rlib.walkspeed(v) local h=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")if h then h.WalkSpeed=v end end
function rlib.ws(v) rlib.walkspeed(v) end
function rlib.jumppower(v) local h=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")if h then h.JumpPower=v end end
function rlib.jp(v) rlib.jumppower(v) end
function rlib.grav(v) workspace.Gravity=v end
function rlib.fpslimit(v) setfpscap(v) end
function rlib.fps() return math.floor(1/RunService.RenderStepped:Wait()) end
function rlib.ping() return LocalPlayer:GetNetworkPing() or 0 end

function rlib.givetool(toolName)
    for _,v in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("Tool") and v.Name:lower():find(toolName:lower()) then
            v.Parent = LocalPlayer.Backpack
        end
    end
end

function rlib.destroytools()
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then v:Destroy() end
    end
end

function rlib.dropAllTools()
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then v.Parent = workspace end
    end
end

function rlib.gettools()
    local t={}
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(t,v.Name) end
    end
    return t
end

function rlib.clonetool(toolName)
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find(toolName:lower()) then
            v:Clone().Parent = LocalPlayer.Backpack
        end
    end
end

function rlib.Usetools()
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then pcall(function() v:Activate() end) end
    end
end

function rlib.HoldTool(idx)
    local tools = LocalPlayer.Backpack:GetChildren()
    if tonumber(idx) and tools[tonumber(idx)] then
        tools[tonumber(idx)].Parent = LocalPlayer.Character
    else
        for _,v in ipairs(tools) do
            if v.Name:lower():find(tostring(idx):lower()) then
                v.Parent = LocalPlayer.Character
                break
            end
        end
    end
end

function rlib.UnHoldTools()
    for _,v in ipairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then v.Parent = LocalPlayer.Backpack end
    end
end

-- rendering and camera stuff
function rlib.fov(v) workspace.CurrentCamera.FieldOfView = v end
function rlib.firstperson() LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson end
function rlib.thirdperson() LocalPlayer.CameraMode = Enum.CameraMode.Classic end
function rlib.nametag(txt)
    local char = LocalPlayer.Character
    if char then
        local tag = char:FindFirstChild("Head") and char.Head:FindFirstChild("Nametag")
        if not tag then
            tag = Instance.new("BillboardGui", char.Head)
            tag.Name = "Nametag"
            tag.Size = UDim2.new(0,100,0,40)
            tag.StudsOffset = Vector3.new(0,2,0)
            tag.AlwaysOnTop = true
            local label = Instance.new("TextLabel", tag)
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextStrokeTransparency = 0
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = true
            label.Text = txt
        else
            tag.TextLabel.Text = txt
        end
    end
end

function rlib.norender(enable)
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local SoundService = game:GetService("SoundService")
    local Workspace = game:GetService("Workspace")
    local setfpscap = setfpscap or function() end

    if enable then
        pcall(function() RunService:Set3dRenderingEnabled(false) end)
        pcall(function() setfpscap(10) end)
        for _,v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                v.Parent = nil
            end
        end
        pcall(function() Lighting.GlobalShadows = false end)
        pcall(function() Lighting.FogEnd = 1e9 end)
        pcall(function() Lighting.Brightness = 0 end)
        pcall(function() Lighting.OutdoorAmbient = Color3.new(0,0,0) end)
        pcall(function() Lighting.ClockTime = 14 end)
        for _,s in ipairs(SoundService:GetDescendants()) do
            if s:IsA("Sound") then s.Volume = 0 end
        end
        pcall(function() SoundService.RespectFilteringEnabled = true end)
        for _,v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") then
                v.Enabled = false
            elseif v:IsA("VideoFrame") then
                v.Playing = false
            end
        end
    else
        pcall(function() RunService:Set3dRenderingEnabled(true) end)
        pcall(function() setfpscap(60) end)
        for _,s in ipairs(SoundService:GetDescendants()) do
            if s:IsA("Sound") then s.Volume = 1 end
        end
    end
end


function rlib.spamChat(txt, count, delay)
    for i=1, count or 10 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(txt, "All")
        task.wait(delay or 0.2)
    end
end

function rlib.chat(txt)
    local tcs = game:GetService("TextChatService")
    local channel = tcs.TextChannels:FindFirstChild("RBXGeneral")
    if channel then
        channel:SendAsync(txt)
    end
end

-- WIP, NOT DONE YET.
--function rlib.getchat(amount)
--    return {}
--end

--function rlib.chatspy(state)
--end

--function rlib.chatlog(state)
--end

--function rlib.webhook(txt, url)
--end
-- WIP, NOT DONE YET.

function rlib.copy(text)
    setclipboard(tostring(text))
end

function rlib.getpos(target)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local function getRoot(char)
        return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
    end

    if not target then
        local root = getRoot(LocalPlayer.Character)
        return root and root.Position
    end

    if typeof(target) == "string" then
        for _,plr in ipairs(Players:GetPlayers()) do
            if plr.Name:lower():sub(1, #target) == target:lower() then
                local root = getRoot(plr.Character)
                return root and root.Position
            end
        end
        local char = LocalPlayer.Character
        if char then
            local part = char:FindFirstChild(target)
            if part and part:IsA("BasePart") then
                return part.Position
            end
        end
    elseif typeof(target) == "table" then
        local char = LocalPlayer.Character
        local positions = {}
        for _,name in ipairs(target) do
            if char then
                local part = char:FindFirstChild(name)
                if part and part:IsA("BasePart") then
                    table.insert(positions, part.Position)
                end
            end
        end
        return positions
    end
end

function rlib.getclosest(list, pos, filter, ret)
    if not pos then
        local lp = game:GetService("Players").LocalPlayer
        local char = lp and lp.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        pos = hrp and hrp.Position or Vector3.new(0,0,0)
    end

    local closest, closestPos, dist = nil, nil, math.huge
    for _, v in ipairs(list) do
        local p
        if v:IsA("BasePart") then
            p = v.Position
        elseif v:IsA("Model") and v.PrimaryPart then
            p = v.PrimaryPart.Position
        elseif v:IsA("Model") and v:GetPivot() then
            p = v:GetPivot().Position
        end
        if p and (not filter or filter(v)) then
            local d = (p - pos).Magnitude
            if d < dist then
                closest, closestPos, dist = v, p, d
            end
        end
    end
    if (ret or "obj") == "pos" then
        return closestPos
    else
        return closest
    end
end



function rlib.userid(username)
    for _,plr in ipairs(Players:GetPlayers()) do
        if not username or plr.Name:lower():sub(1, #username) == username:lower() then
            return plr.UserId
        end
    end
end

function rlib.placeid() return game.PlaceId end
function rlib.placename() return game.Name end
function rlib.serverid() return game.JobId end
function rlib.joinserver(id) game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, id) end
function rlib.getplayers()
    local t = {}
    for _,plr in ipairs(Players:GetPlayers()) do table.insert(t, plr.Name) end
    return t
end
function rlib.rejoin() game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end
function rlib.rj() rlib.rejoin() end
function rlib.serverhop() game:GetService("TeleportService"):Teleport(game.PlaceId) end
function rlib.shop() rlib.serverhop() end

return rlib
