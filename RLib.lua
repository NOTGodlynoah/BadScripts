-- RLib v3.1 Ultimate - Made by NOTGodlynoah
-- Join discord.gg/asu for epic scripts!
local RLib = {}
local Players, RunService, UserInputService, TweenService, HttpService, Workspace, Lighting, SoundService, StarterGui, TeleportService, Teams, PathfindingService, VirtualInputManager, Camera, ReplicatedStorage, MarketplaceService, GuiService, TextService, Chat, Debris = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("HttpService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("SoundService"), game:GetService("StarterGui"), game:GetService("TeleportService"), game:GetService("Teams"), game:GetService("PathfindingService"), game:GetService("VirtualInputManager"), Workspace.CurrentCamera, game:GetService("ReplicatedStorage"), game:GetService("MarketplaceService"), game:GetService("GuiService"), game:GetService("TextService"), game:GetService("Chat"), game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer

-- player related stuff
function RLib.getPlayer(name) if not name then return LocalPlayer end name = name:lower() for _, p in pairs(Players:GetPlayers()) do if p.Name:lower():find(name) or p.DisplayName:lower():find(name) then return p end end end
function RLib.getAllPlayers() return Players:GetPlayers() end
function RLib.getRandomPlayer() local p = Players:GetPlayers() return p[math.random(#p)] end
function RLib.getPlayerPosition(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p.Character and p.Character.HumanoidRootPart and p.Character.HumanoidRootPart.Position end
function RLib.getPlayerHealth(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p.Character and p.Character.Humanoid and p.Character.Humanoid.Health or 0 end
function RLib.isPlayerAlive(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p and p.Character and p.Character.Humanoid and p.Character.Humanoid.Health > 0 end
function RLib.getPlayerTeam(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p.Team end
function RLib.getPlayerAge(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p.AccountAge end
function RLib.getPlayerUserId(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p.UserId end
function RLib.getPlayerDisplayName(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p.DisplayName end
function RLib.getPlayerThumbnail(p, size) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return "https://www.roblox.com/headshot-thumbnail/image?userId="..p.UserId.."&width="..(size or 150).."&height="..(size or 150).."&format=png" end
function RLib.getPlayerFromUserId(id) return Players:GetPlayerByUserId(id) end
function RLib.getPlayerFromCharacter(char) return Players:GetPlayerFromCharacter(char) end
function RLib.isPlayerFriend(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return LocalPlayer:IsFriendsWith(p.UserId) end
function RLib.getPlayerPing(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return p:GetNetworkPing() * 1000 end
function RLib.getPlayerJoinTime(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer return tick() - (p.Parent and Players or {PlayerAdded = {Connect = function() end}}).PlayerAdded.Connect and 0 or 0 end
function RLib.kickSelf() LocalPlayer:Kick("Kicked by script") end
function RLib.getPlayersByTeam(teamName) local tp = {} for _, p in pairs(Players:GetPlayers()) do if p.Team and p.Team.Name:lower():find(teamName:lower()) then table.insert(tp, p) end end return tp end
function RLib.getPlayersInRadius(pos, radius) local players = {} for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character.HumanoidRootPart and RLib.getDistance(pos, p.Character.HumanoidRootPart.Position) <= radius then table.insert(players, p) end end return players end
function RLib.getOldestPlayer() local oldest, oldestAge = nil, 0 for _, p in pairs(Players:GetPlayers()) do if p.AccountAge > oldestAge then oldest, oldestAge = p, p.AccountAge end end return oldest end
function RLib.getNewestPlayer() local newest, newestAge = nil, math.huge for _, p in pairs(Players:GetPlayers()) do if p.AccountAge < newestAge then newest, newestAge = p, p.AccountAge end end return newest end
function RLib.teleportTo(player, target) player = type(player)=="string" and RLib.getPlayer(player) or player target = type(target)=="string" and RLib.getPlayer(target) or target if player and player.Character and player.Character.HumanoidRootPart then if typeof(target)=="Vector3" then player.Character.HumanoidRootPart.CFrame = CFrame.new(target) elseif target and target.Character and target.Character.HumanoidRootPart then player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame end end end
function RLib.gotoPlayer(p) RLib.teleportTo(LocalPlayer, p) end
function RLib.setWalkSpeed(p, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.WalkSpeed = s or 16 end end
function RLib.setJumpPower(p, j) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.JumpPower = j or 50 end end
function RLib.setJumpHeight(p, h) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.JumpHeight = h or 7.2 end end
function RLib.setHealth(p, h) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.Health = h or 100 end end
function RLib.setMaxHealth(p, h) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.MaxHealth = h or 100 p.Character.Humanoid.Health = h or 100 end end
function RLib.healPlayer(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.Health = p.Character.Humanoid.MaxHealth end end
function RLib.godMode(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then if e then p.Character.Humanoid.MaxHealth, p.Character.Humanoid.Health = math.huge, math.huge else p.Character.Humanoid.MaxHealth, p.Character.Humanoid.Health = 100, 100 end end end
function RLib.invisibility(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.Transparency = e and 1 or 0 elseif part:IsA("Accessory") then part.Handle.Transparency = e and 1 or 0 end end if p.Character.Head and p.Character.Head.face then p.Character.Head.face.Transparency = e and 1 or 0 end end end
function RLib.noclip(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = not e end end end end
function RLib.sit(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.Sit = e end end
function RLib.platformStand(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.PlatformStand = e end end
function RLib.fly(p, e, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then local bv = p.Character.HumanoidRootPart:FindFirstChild("FlyVelocity") if e then if not bv then bv = Instance.new("BodyVelocity") bv.Name = "FlyVelocity" bv.MaxForce = Vector3.new(4000,4000,4000) bv.Velocity = Vector3.new(0,0,0) bv.Parent = p.Character.HumanoidRootPart end elseif bv then bv:Destroy() end end end
function RLib.freeze(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then local a = Instance.new("BodyPosition") a.MaxForce = Vector3.new(4000,4000,4000) a.Position = p.Character.HumanoidRootPart.Position a.Parent = p.Character.HumanoidRootPart return a end end
function RLib.unfreeze(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then for _, o in pairs(p.Character.HumanoidRootPart:GetChildren()) do if o:IsA("BodyPosition") then o:Destroy() end end end end
function RLib.fling(p, f) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then local bv = Instance.new("BodyVelocity") bv.MaxForce = Vector3.new(4000,4000,4000) bv.Velocity = Vector3.new(math.random(-(f or 50), f or 50), f or 50, math.random(-(f or 50), f or 50)) bv.Parent = p.Character.HumanoidRootPart Debris:AddItem(bv, 1) end end
function RLib.spin(p, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then local sp = Instance.new("BodyAngularVelocity") sp.AngularVelocity = Vector3.new(0, s or 20, 0) sp.MaxTorque = Vector3.new(0, math.huge, 0) sp.Parent = p.Character.HumanoidRootPart return sp end end
function RLib.stopSpin(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then for _, o in pairs(p.Character.HumanoidRootPart:GetChildren()) do if o:IsA("BodyAngularVelocity") then o:Destroy() end end end end
function RLib.changeCharacterSize(p, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.DepthScale.Value = s p.Character.Humanoid.HeightScale.Value = s p.Character.Humanoid.WidthScale.Value = s end end
function RLib.respawnPlayer(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer p:LoadCharacter() end
function RLib.removeAccessories(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, acc in pairs(p.Character:GetChildren()) do if acc:IsA("Accessory") then acc:Destroy() end end end end
function RLib.removeTools(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, tool in pairs(p.Character:GetChildren()) do if tool:IsA("Tool") then tool:Destroy() end end end end
function RLib.setCharacterAppearance(p, userId) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(userId)) end end
function RLib.setDisplayName(p, name) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.DisplayName = name end end
function RLib.setWalkSpeedScale(p, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.WalkSpeedScale.Value = s end end
function RLib.setJumpScale(p, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.JumpHeightScale.Value = s end end
function RLib.setHipHeight(p, h) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.HipHeight = h end end
function RLib.setPlatformStand(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid.PlatformStand = e end end
function RLib.swim(p, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then if e then p.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming) else p.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running) end end end
function RLib.setStateEnabled(p, state, e) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid:SetStateEnabled(state, e) end end
function RLib.changeState(p, state) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid:ChangeState(state) end end
function RLib.equipTool(p, tool) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid:EquipTool(tool) end end
function RLib.unequipTools(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then p.Character.Humanoid:UnequipTools() end end
function RLib.setNetworkOwner(p, owner) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then p.Character.HumanoidRootPart:SetNetworkOwner(owner) end end
function RLib.destroyCharacter(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then p.Character:Destroy() end end
function RLib.cloneCharacter(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then local c = p.Character:Clone() c.Name = p.Name.."_Clone" c.Parent = Workspace return c end end
function RLib.getCharacterMass(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer local mass = 0 if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then mass = mass + part:GetMass() end end end return mass end
function RLib.setCharacterTransparency(p, t) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = t end end end end
function RLib.setCharacterColor(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = c end end end end
function RLib.setCharacterMaterial(p, m) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.Material = m end end end end
function RLib.setCharacterReflectance(p, r) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.Reflectance = r end end end end
function RLib.setCharacterCanCollide(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = c end end end end
function RLib.getCharacterBoundingBox(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then return p.Character:GetBoundingBox() end end
function RLib.getCharacterPrimaryPart(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then return p.Character.PrimaryPart end end
function RLib.setCharacterPrimaryPart(p, part) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then p.Character.PrimaryPart = part end end
function RLib.moveCharacterTo(p, pos) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then p.Character:MoveTo(pos) end end
function RLib.setCharacterCFrame(p, cf) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then p.Character:SetPrimaryPartCFrame(cf) end end
function RLib.scaleCharacter(p, s) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.Size = part.Size * s end end end end
function RLib.addAccessory(p, id) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Humanoid then local acc = game:GetService("InsertService"):LoadAsset(id):GetChildren()[1] p.Character.Humanoid:AddAccessory(acc) end end
function RLib.removeHats(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then for _, hat in pairs(p.Character:GetChildren()) do if hat:IsA("Accessory") and hat.AccessoryType == Enum.AccessoryType.Hat then hat:Destroy() end end end end
function RLib.removeFace(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Head and p.Character.Head.face then p.Character.Head.face:Destroy() end end
function RLib.setFace(p, id) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Head then local face = p.Character.Head:FindFirstChild("face") or Instance.new("Decal", p.Character.Head) face.Name = "face" face.Face = Enum.NormalId.Front face.Texture = "rbxassetid://"..id end end
function RLib.attachTo(p, target) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer target = type(target)=="string" and RLib.getPlayer(target) or target if p.Character and p.Character.HumanoidRootPart and target.Character and target.Character.HumanoidRootPart then local weld = Instance.new("WeldConstraint") weld.Part0 = p.Character.HumanoidRootPart weld.Part1 = target.Character.HumanoidRootPart weld.Parent = p.Character.HumanoidRootPart return weld end end

-- Objects? In workspace?????
function RLib.deleteObject(n) for _, o in pairs(Workspace:GetDescendants()) do if o.Name:lower():find(n:lower()) then o:Destroy() end end end
function RLib.findObject(n) for _, o in pairs(Workspace:GetDescendants()) do if o.Name:lower():find(n:lower()) then return o end end end
function RLib.getAllObjects(c) local o = {} for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA(c) then table.insert(o, obj) end end return o end
function RLib.highlightObject(o, c) if o then local h = Instance.new("Highlight") h.FillColor = c or Color3.fromRGB(255,255,0) h.OutlineColor = Color3.fromRGB(255,255,255) h.Parent = o return h end end
function RLib.createPart(s, p, c, m) local part = Instance.new("Part") part.Size = s or Vector3.new(4,1,2) part.Position = p or Vector3.new(0,10,0) part.Color = c or Color3.new(1,1,1) part.Material = m or Enum.Material.Plastic part.Anchored = true part.Parent = Workspace return part end
function RLib.createExplosion(p, s, pr) local e = Instance.new("Explosion") e.Position = p or Vector3.new(0,10,0) e.BlastRadius = s or 50 e.BlastPressure = pr or 500000 e.Parent = Workspace return e end
function RLib.clearWorkspace() for _, o in pairs(Workspace:GetChildren()) do if not o:IsA("Terrain") and not o:IsA("Camera") and not Players:GetPlayerFromCharacter(o) then pcall(function() o:Destroy() end) end end end
function RLib.createBeam(start, endPos, color, width) local a1, a2 = Instance.new("Attachment"), Instance.new("Attachment") local p1, p2 = Instance.new("Part"), Instance.new("Part") p1.Anchored, p1.CanCollide, p1.Transparency, p1.Position, p1.Size = true, false, 1, start, Vector3.new(0.1,0.1,0.1) p2.Anchored, p2.CanCollide, p2.Transparency, p2.Position, p2.Size = true, false, 1, endPos, Vector3.new(0.1,0.1,0.1) p1.Parent, p2.Parent = Workspace, Workspace a1.Parent, a2.Parent = p1, p2 local beam = Instance.new("Beam") beam.Attachment0, beam.Attachment1 = a1, a2 beam.Color = ColorSequence.new(color or Color3.new(1,0,0)) beam.Width0, beam.Width1 = width or 1, width or 1 beam.Parent = p1 return beam, p1, p2 end
function RLib.createTrail(part, color, lifetime) local a1, a2 = Instance.new("Attachment"), Instance.new("Attachment") a1.Position, a2.Position = Vector3.new(-part.Size.X/2,0,0), Vector3.new(part.Size.X/2,0,0) a1.Parent, a2.Parent = part, part local trail = Instance.new("Trail") trail.Attachment0, trail.Attachment1 = a1, a2 trail.Color = ColorSequence.new(color or Color3.new(1,1,1)) trail.Lifetime = lifetime or 2 trail.Parent = part return trail end
function RLib.createWeld(p1, p2) local weld = Instance.new("WeldConstraint") weld.Part0, weld.Part1 = p1, p2 weld.Parent = p1 return weld end
function RLib.breakWeld(weld) if weld then weld:Destroy() end end
function RLib.anchorObject(obj, anchored) if obj and obj:IsA("BasePart") then obj.Anchored = anchored end end
function RLib.setObjectTransparency(obj, t) if obj and obj:IsA("BasePart") then obj.Transparency = t end end
function RLib.setObjectColor(obj, c) if obj and obj:IsA("BasePart") then obj.Color = c end end
function RLib.setObjectMaterial(obj, m) if obj and obj:IsA("BasePart") then obj.Material = m end end
function RLib.setObjectSize(obj, s) if obj and obj:IsA("BasePart") then obj.Size = s end end
function RLib.setObjectPosition(obj, p) if obj and obj:IsA("BasePart") then obj.Position = p end end
function RLib.setObjectCFrame(obj, cf) if obj and obj:IsA("BasePart") then obj.CFrame = cf end end
function RLib.setObjectVelocity(obj, v) if obj and obj:IsA("BasePart") then obj.Velocity = v end end
function RLib.setObjectAngularVelocity(obj, av) if obj and obj:IsA("BasePart") then obj.AngularVelocity = av end end
function RLib.setObjectCanCollide(obj, c) if obj and obj:IsA("BasePart") then obj.CanCollide = c end end
function RLib.setObjectLocked(obj, l) if obj and obj:IsA("BasePart") then obj.Locked = l end end
function RLib.setObjectReflectance(obj, r) if obj and obj:IsA("BasePart") then obj.Reflectance = r end end
function RLib.setObjectTopSurface(obj, s) if obj and obj:IsA("BasePart") then obj.TopSurface = s end end
function RLib.setObjectBottomSurface(obj, s) if obj and obj:IsA("BasePart") then obj.BottomSurface = s end end
function RLib.createFolder(name, parent) local folder = Instance.new("Folder") folder.Name = name or "Folder" folder.Parent = parent or Workspace return folder end
function RLib.createModel(name, parent) local model = Instance.new("Model") model.Name = name or "Model" model.Parent = parent or Workspace return model end
function RLib.cloneObject(obj) if obj then return obj:Clone() end end
function RLib.getObjectChildren(obj) if obj then return obj:GetChildren() end return {} end
function RLib.getObjectDescendants(obj) if obj then return obj:GetDescendants() end return {} end
function RLib.findFirstChild(obj, name) if obj then return obj:FindFirstChild(name) end end
function RLib.findFirstDescendant(obj, name) if obj then for _, desc in pairs(obj:GetDescendants()) do if desc.Name == name then return desc end end end end
function RLib.waitForChild(obj, name, timeout) if obj then return obj:WaitForChild(name, timeout) end end
function RLib.setParent(obj, parent) if obj then obj.Parent = parent end end
function RLib.getParent(obj) if obj then return obj.Parent end end
function RLib.isAncestorOf(obj, ancestor) if obj and ancestor then return ancestor:IsAncestorOf(obj) end return false end
function RLib.isDescendantOf(obj, descendant) if obj and descendant then return obj:IsDescendantOf(descendant) end return false end
function RLib.getService(name) return game:GetService(name) end
function RLib.createSpawnLocation(pos, teamColor) local spawn = Instance.new("SpawnLocation") spawn.Position = pos spawn.TeamColor = teamColor or BrickColor.new("Medium stone grey") spawn.Parent = Workspace return spawn end
function RLib.removeSpawnLocations() for _, spawn in pairs(Workspace:GetDescendants()) do if spawn:IsA("SpawnLocation") then spawn:Destroy() end end end
function RLib.createTeleporter(pos1, pos2) local tp1, tp2 = Instance.new("Part"), Instance.new("Part") tp1.Size, tp2.Size = Vector3.new(4,1,4), Vector3.new(4,1,4) tp1.Position, tp2.Position = pos1, pos2 tp1.BrickColor, tp2.BrickColor = BrickColor.new("Bright blue"), BrickColor.new("Bright red") tp1.Material, tp2.Material = Enum.Material.Neon, Enum.Material.Neon tp1.Anchored, tp2.Anchored = true, true tp1.Parent, tp2.Parent = Workspace, Workspace tp1.Touched:Connect(function(hit) local char = hit.Parent if char:FindFirstChild("Humanoid") then char:MoveTo(pos2 + Vector3.new(0,5,0)) end end) tp2.Touched:Connect(function(hit) local char = hit.Parent if char:FindFirstChild("Humanoid") then char:MoveTo(pos1 + Vector3.new(0,5,0)) end end) return tp1, tp2 end

-- Lighting and Environment Shit
function RLib.setTime(t) Lighting.TimeOfDay = t or "14:00:00" end
function RLib.setBrightness(b) Lighting.Brightness = b or 2 end
function RLib.setAmbient(c) Lighting.Ambient = c or Color3.fromRGB(70,70,70) end
function RLib.setFogEnd(d) Lighting.FogEnd = d or 100000 end
function RLib.setFogStart(d) Lighting.FogStart = d or 0 end
function RLib.setFogColor(c) Lighting.FogColor = c or Color3.fromRGB(192,192,192) end
function RLib.setSkybox(id) local s = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting) if id then local asset = "rbxassetid://"..id s.SkyboxBk, s.SkyboxDn, s.SkyboxFt, s.SkyboxLf, s.SkyboxRt, s.SkyboxUp = asset, asset, asset, asset, asset, asset end end
function RLib.removeSkybox() local sky = Lighting:FindFirstChild("Sky") if sky then sky:Destroy() end end
function RLib.setOutdoorAmbient(c) Lighting.OutdoorAmbient = c end
function RLib.setColorShift_Bottom(c) Lighting.ColorShift_Bottom = c end
function RLib.setColorShift_Top(c) Lighting.ColorShift_Top = c end
function RLib.setShadowSoftness(s) Lighting.ShadowSoftness = s end
function RLib.setExposureCompensation(e) Lighting.ExposureCompensation = e end
function RLib.createColorCorrection(b, c, s, t) local cc = Instance.new("ColorCorrectionEffect") cc.Brightness = b or 0 cc.Contrast = c or 0 cc.Saturation = s or 0 cc.TintColor = t or Color3.new(1,1,1) cc.Parent = Lighting return cc end
function RLib.createBloom(i, s, t) local bloom = Instance.new("BloomEffect") bloom.Intensity = i or 1 bloom.Size = s or 24 bloom.Threshold = t or 2 bloom.Parent = Lighting return bloom end
function RLib.createBlur(s) local blur = Instance.new("BlurEffect") blur.Size = s or 24 blur.Parent = Lighting return blur end
function RLib.createSunRays(i, s) local sr = Instance.new("SunRaysEffect") sr.Intensity = i or 0.25 sr.Spread = s or 1 sr.Parent = Lighting return sr end
function RLib.createDepthOfField(fb, fd, ic, nf, ff) local dof = Instance.new("DepthOfFieldEffect") dof.FarIntensity = fb or 0.75 dof.FocusDistance = fd or 0.05 dof.InFocusRadius = ic or 10 dof.NearIntensity = nf or 0.75 dof.FarIntensity = ff or 0.75 dof.Parent = Lighting return dof end
function RLib.rainbowLighting() spawn(function() while true do for i = 0, 1, 0.01 do Lighting.Ambient = Color3.fromHSV(i, 1, 1) wait(0.1) end end end) end
function RLib.dayNightCycle(speed) spawn(function() local time = 0 while true do time = time + (speed or 1) if time >= 24 then time = 0 end Lighting.TimeOfDay = string.format("%02d:00:00", math.floor(time)) wait(1) end end) end
function RLib.flashLighting(duration, color) spawn(function() local orig = Lighting.Ambient for i = 1, duration * 10 do Lighting.Ambient = i % 2 == 0 and (color or Color3.new(1,1,1)) or Color3.new(0,0,0) wait(0.1) end Lighting.Ambient = orig end) end
function RLib.setClockTime(h, m, s) Lighting.ClockTime = h + (m/60) + (s/3600) end
function RLib.setGeographicLatitude(lat) Lighting.GeographicLatitude = lat end
function RLib.setGlobalShadows(e) Lighting.GlobalShadows = e end
function RLib.setShadowColor(c) Lighting.ShadowColor = c end
function RLib.createAtmosphere() local atm = Instance.new("Atmosphere") atm.Parent = Lighting return atm end
function RLib.createClouds() local clouds = Instance.new("Clouds") clouds.Parent = Workspace.Terrain return clouds end
function RLib.removePostEffects() for _, effect in pairs(Lighting:GetChildren()) do if effect:IsA("PostEffect") then effect:Destroy() end end end
function RLib.setTechnology(tech) Lighting.Technology = tech end
function RLib.setShadowMapSize(size) Lighting.ShadowMapSize = size end
function RLib.setEnvironmentDiffuseScale(scale) Lighting.EnvironmentDiffuseScale = scale end
function RLib.setEnvironmentSpecularScale(scale) Lighting.EnvironmentSpecularScale = scale end

-- I ❤ guis
function RLib.createScreenGui(n) local g = Instance.new("ScreenGui") g.Name = n or "CustomGui" g.Parent = LocalPlayer.PlayerGui return g end
function RLib.createFrame(p, s, pos, c) local f = Instance.new("Frame") f.Size = s or UDim2.new(0.5,0,0.5,0) f.Position = pos or UDim2.new(0.25,0,0.25,0) f.BackgroundColor3 = c or Color3.fromRGB(50,50,50) f.Parent = p return f end
function RLib.createTextLabel(p, t, s, pos) local l = Instance.new("TextLabel") l.Text = t or "Label" l.Size = s or UDim2.new(1,0,0.2,0) l.Position = pos or UDim2.new(0,0,0,0) l.BackgroundTransparency = 1 l.TextColor3 = Color3.new(1,1,1) l.TextScaled = true l.Parent = p return l end
function RLib.createButton(p, t, s, pos, cb) local b = Instance.new("TextButton") b.Text = t or "Button" b.Size = s or UDim2.new(0.3,0,0.1,0) b.Position = pos or UDim2.new(0.35,0,0.45,0) b.BackgroundColor3 = Color3.fromRGB(70,70,70) b.TextColor3 = Color3.new(1,1,1) b.TextScaled = true b.Parent = p if cb then b.MouseButton1Click:Connect(cb) end return b end
function RLib.createTextBox(p, ph, s, pos) local t = Instance.new("TextBox") t.PlaceholderText = ph or "Enter text..." t.Size = s or UDim2.new(0.8,0,0.1,0) t.Position = pos or UDim2.new(0.1,0,0.3,0) t.BackgroundColor3 = Color3.fromRGB(40,40,40) t.TextColor3 = Color3.new(1,1,1) t.TextScaled = true t.Parent = p return t end
function RLib.createImageLabel(p, id, s, pos) local img = Instance.new("ImageLabel") img.Image = "rbxassetid://"..(id or "0") img.Size = s or UDim2.new(0.2,0,0.2,0) img.Position = pos or UDim2.new(0.4,0,0.4,0) img.BackgroundTransparency = 1 img.Parent = p return img end
function RLib.createScrollingFrame(p, s, pos, cs) local sf = Instance.new("ScrollingFrame") sf.Size = s or UDim2.new(0.8,0,0.8,0) sf.Position = pos or UDim2.new(0.1,0,0.1,0) sf.CanvasSize = cs or UDim2.new(0,0,2,0) sf.BackgroundColor3 = Color3.fromRGB(30,30,30) sf.Parent = p return sf end
function RLib.createImageButton(p, id, s, pos, cb) local ib = Instance.new("ImageButton") ib.Image = "rbxassetid://"..(id or "0") ib.Size = s or UDim2.new(0.1,0,0.1,0) ib.Position = pos or UDim2.new(0.45,0,0.45,0) ib.BackgroundTransparency = 1 ib.Parent = p if cb then ib.MouseButton1Click:Connect(cb) end return ib end
function RLib.createViewportFrame(p, s, pos) local vf = Instance.new("ViewportFrame") vf.Size = s or UDim2.new(0.5,0,0.5,0) vf.Position = pos or UDim2.new(0.25,0,0.25,0) vf.BackgroundColor3 = Color3.fromRGB(0,0,0) vf.Parent = p return vf end
function RLib.createUICorner(p, radius) local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, radius or 8) corner.Parent = p return corner end
function RLib.createUIStroke(p, color, thickness) local stroke = Instance.new("UIStroke") stroke.Color = color or Color3.new(1,1,1) stroke.Thickness = thickness or 1 stroke.Parent = p return stroke end
function RLib.createUIGradient(p, colors, rotation) local grad = Instance.new("UIGradient") grad.Color = colors or ColorSequence.new(Color3.new(1,1,1)) grad.Rotation = rotation or 0 grad.Parent = p return grad end
function RLib.createUIListLayout(p, direction, padding) local layout = Instance.new("UIListLayout") layout.FillDirection = direction or Enum.FillDirection.Vertical layout.Padding = UDim.new(0, padding or 5) layout.Parent = p return layout end
function RLib.createUIGridLayout(p, cellSize, cellPadding) local grid = Instance.new("UIGridLayout") grid.CellSize = cellSize or UDim2.new(0.2,0,0.2,0) grid.CellPadding = cellPadding or UDim2.new(0.05,0,0.05,0) grid.Parent = p return grid end
function RLib.createUIPadding(p, left, right, top, bottom) local pad = Instance.new("UIPadding") pad.PaddingLeft = UDim.new(0, left or 5) pad.PaddingRight = UDim.new(0, right or 5) pad.PaddingTop = UDim.new(0, top or 5) pad.PaddingBottom = UDim.new(0, bottom or 5) pad.Parent = p return pad end
function RLib.createUIScale(p, scale) local s = Instance.new("UIScale") s.Scale = scale or 1 s.Parent = p return s end
function RLib.createUIAspectRatioConstraint(p, ratio) local arc = Instance.new("UIAspectRatioConstraint") arc.AspectRatio = ratio or 1 arc.Parent = p return arc end
function RLib.createUISizeConstraint(p, minSize, maxSize) local sc = Instance.new("UISizeConstraint") sc.MinSize = minSize or Vector2.new(0,0) sc.MaxSize = maxSize or Vector2.new(math.huge, math.huge) sc.Parent = p return sc end
function RLib.createUITextSizeConstraint(p, minSize, maxSize) local tsc = Instance.new("UITextSizeConstraint") tsc.MinTextSize = minSize or 1 tsc.MaxTextSize = maxSize or 100 tsc.Parent = p return tsc end
function RLib.createBillboardGui(p, size, studsOffset) local bg = Instance.new("BillboardGui") bg.Size = size or UDim2.new(2,0,1,0) bg.StudsOffset = studsOffset or Vector3.new(0,0,0) bg.Parent = p return bg end
function RLib.createSurfaceGui(p, face) local sg = Instance.new("SurfaceGui") sg.Face = face or Enum.NormalId.Front sg.Parent = p return sg end
function RLib.destroyGui(gui) if gui then gui:Destroy() end end
function RLib.cloneGui(gui) if gui then return gui:Clone() end end
function RLib.setGuiParent(gui, parent) if gui then gui.Parent = parent end end
function RLib.getGuiChildren(gui) if gui then return gui:GetChildren() end return {} end
function RLib.findGuiChild(gui, name) if gui then return gui:FindFirstChild(name) end end
function RLib.setGuiVisible(gui, visible) if gui then gui.Visible = visible end end
function RLib.setGuiTransparency(gui, transparency) if gui then gui.BackgroundTransparency = transparency end end
function RLib.setGuiPosition(gui, position) if gui then gui.Position = position end end
function RLib.setGuiSize(gui, size) if gui then gui.Size = size end end
function RLib.setGuiColor(gui, color) if gui then gui.BackgroundColor3 = color end end
function RLib.setGuiText(gui, text) if gui and gui.Text then gui.Text = text end end
function RLib.setGuiTextColor(gui, color) if gui and gui.TextColor3 then gui.TextColor3 = color end end
function RLib.setGuiFont(gui, font) if gui and gui.Font then gui.Font = font end end
function RLib.setGuiTextSize(gui, size) if gui and gui.TextSize then gui.TextSize = size end end
function RLib.setGuiImage(gui, id) if gui and gui.Image then gui.Image = "rbxassetid://"..id end end

-- Noisy Bastard
function RLib.playSound(id, v, p) local s = Instance.new("Sound") s.SoundId = "rbxassetid://"..(id or "131961136") s.Volume = v or 0.5 s.Pitch = p or 1 s.Parent = Workspace s:Play() s.Ended:Connect(function() s:Destroy() end) return s end
function RLib.stopAllSounds() for _, s in pairs(Workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end end
function RLib.pauseAllSounds() for _, s in pairs(Workspace:GetDescendants()) do if s:IsA("Sound") then s:Pause() end end end
function RLib.resumeAllSounds() for _, s in pairs(Workspace:GetDescendants()) do if s:IsA("Sound") then s:Resume() end end end
function RLib.setMasterVolume(v) SoundService.AmbientReverb = Enum.ReverbType.NoReverb SoundService.RolloffScale = v or 1 end
function RLib.createSoundGroup(n) local sg = Instance.new("SoundGroup") sg.Name = n or "CustomSoundGroup" sg.Parent = SoundService return sg end
function RLib.createSound(id, parent, v, p, l) local s = Instance.new("Sound") s.SoundId = "rbxassetid://"..(id or "0") s.Volume = v or 0.5 s.Pitch = p or 1 s.Looped = l or false s.Parent = parent or Workspace return s end
function RLib.setSoundVolume(sound, volume) if sound then sound.Volume = volume end end
function RLib.setSoundPitch(sound, pitch) if sound then sound.Pitch = pitch end end
function RLib.setSoundLooped(sound, looped) if sound then sound.Looped = looped end end
function RLib.setSoundTimePosition(sound, time) if sound then sound.TimePosition = time end end
function RLib.getSoundLength(sound) if sound then return sound.TimeLength end return 0 end
function RLib.createEcho(parent, delay, feedback) local echo = Instance.new("EchoSoundEffect") echo.Delay = delay or 0.5 echo.Feedback = feedback or 0.5 echo.Parent = parent return echo end
function RLib.createReverb(parent, roomSize, decayTime) local reverb = Instance.new("ReverbSoundEffect") reverb.RoomSize = roomSize or 0.5 reverb.DecayTime = decayTime or 1.5 reverb.Parent = parent return reverb end
function RLib.createChorus(parent, depth, rate) local chorus = Instance.new("ChorusSoundEffect") chorus.Depth = depth or 0.45 chorus.Rate = rate or 5 chorus.Parent = parent return chorus end
function RLib.createDistortion(parent, level) local dist = Instance.new("DistortionSoundEffect") dist.Level = level or 0.75 dist.Parent = parent return dist end
function RLib.createFlange(parent, depth, rate) local flange = Instance.new("FlangeSoundEffect") flange.Depth = depth or 0.45 flange.Rate = rate or 5 flange.Parent = parent return flange end
function RLib.createTremolo(parent, depth, frequency) local tremolo = Instance.new("TremoloSoundEffect") tremolo.Depth = depth or 0.5 tremolo.Frequency = frequency or 5 tremolo.Parent = parent return tremolo end
function RLib.createCompressor(parent, attack, release) local comp = Instance.new("CompressorSoundEffect") comp.Attack = attack or 0.003 comp.Release = release or 0.1 comp.Parent = parent return comp end
function RLib.createEqualizer(parent, highGain, midGain, lowGain) local eq = Instance.new("EqualizerSoundEffect") eq.HighGain = highGain or 0 eq.MidGain = midGain or 0 eq.LowGain = lowGain or 0 eq.Parent = parent return eq end
function RLib.createPitchShift(parent, octave) local ps = Instance.new("PitchShiftSoundEffect") ps.Octave = octave or 1.25 ps.Parent = parent return ps end
function RLib.mutePlayer(player) player = type(player)=="string" and RLib.getPlayer(player) or player if player then for _, sound in pairs(player:GetDescendants()) do if sound:IsA("Sound") then sound.Volume = 0 end end end end
function RLib.unmutePlayer(player) player = type(player)=="string" and RLib.getPlayer(player) or player if player then for _, sound in pairs(player:GetDescendants()) do if sound:IsA("Sound") then sound.Volume = 0.5 end end end end
function RLib.setPlayerVolume(player, volume) player = type(player)=="string" and RLib.getPlayer(player) or player if player then for _, sound in pairs(player:GetDescendants()) do if sound:IsA("Sound") then sound.Volume = volume end end end end
function RLib.playSoundAtPosition(id, pos, v, p) local part = Instance.new("Part") part.Anchored = true part.CanCollide = false part.Transparency = 1 part.Position = pos part.Size = Vector3.new(1,1,1) part.Parent = Workspace local sound = RLib.createSound(id, part, v, p) sound:Play() sound.Ended:Connect(function() part:Destroy() end) return sound, part end

-- Camera Shits
function RLib.setCameraSubject(s) Camera.CameraSubject = s end
function RLib.setCameraType(t) Camera.CameraType = t end
function RLib.setCameraFOV(f) Camera.FieldOfView = f or 70 end
function RLib.shakeCam(i, d) spawn(function() local orig, start = Camera.CFrame, tick() while tick() - start < (d or 1) do local shake = Vector3.new(math.random(-(i or 5), i or 5), math.random(-(i or 5), i or 5), math.random(-(i or 5), i or 5)) Camera.CFrame = orig + shake wait() end Camera.CFrame = orig end) end
function RLib.smoothCameraMove(cf, d) local start, startTime = Camera.CFrame, tick() spawn(function() while tick() - startTime < (d or 2) do local alpha = (tick() - startTime) / (d or 2) Camera.CFrame = start:Lerp(cf, alpha) wait() end Camera.CFrame = cf end) end
function RLib.setCameraCFrame(cf) Camera.CFrame = cf end
function RLib.getCameraCFrame() return Camera.CFrame end
function RLib.setCameraCoordinateFrame(cf) Camera.CoordinateFrame = cf end
function RLib.setCameraFocus(cf) Camera.Focus = cf end
function RLib.getCameraFocus() return Camera.Focus end
function RLib.setCameraHeadLocked(locked) Camera.HeadLocked = locked end
function RLib.setCameraHeadScale(scale) Camera.HeadScale = scale end
function RLib.worldToScreenPoint(pos) return Camera:WorldToScreenPoint(pos) end
function RLib.screenToWorldRay(x, y) return Camera:ScreenPointToRay(x, y) end
function RLib.setCameraMaxZoomDistance(dist) LocalPlayer.CameraMaxZoomDistance = dist end
function RLib.setCameraMinZoomDistance(dist) LocalPlayer.CameraMinZoomDistance = dist end
function RLib.setCameraMode(mode) LocalPlayer.CameraMode = mode end
function RLib.getCameraMode() return LocalPlayer.CameraMode end
function RLib.zoomCamera(distance) Camera.CFrame = Camera.CFrame + Camera.CFrame.LookVector * distance end
function RLib.rotateCamera(x, y) local cf = Camera.CFrame Camera.CFrame = CFrame.new(cf.Position) * CFrame.Angles(math.rad(y), math.rad(x), 0) end

-- Input stuff
function RLib.getMousePosition() return UserInputService:GetMouseLocation() end
function RLib.isKeyDown(k) return UserInputService:IsKeyDown(Enum.KeyCode[k]) end
function RLib.onKeyPress(k, cb) UserInputService.InputBegan:Connect(function(i) if i.KeyCode == Enum.KeyCode[k] then cb() end end) end
function RLib.onKeyRelease(k, cb) UserInputService.InputEnded:Connect(function(i) if i.KeyCode == Enum.KeyCode[k] then cb() end end) end
function RLib.simulateKeyPress(k) VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[k], false, game) wait(0.1) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[k], false, game) end
function RLib.simulateMouseClick(p) VirtualInputManager:SendMouseButtonEvent(p.X, p.Y, 0, true, game, 1) wait(0.1) VirtualInputManager:SendMouseButtonEvent(p.X, p.Y, 0, false, game, 1) end
function RLib.simulateMouseMove(x, y) VirtualInputManager:SendMouseMoveEvent(x, y, game) end
function RLib.simulateMouseWheel(delta) VirtualInputManager:SendMouseWheelEvent(0, 0, false, delta, game) end
function RLib.getKeysPressed() local keys = {} for _, key in pairs(Enum.KeyCode:GetEnumItems()) do if UserInputService:IsKeyDown(key) then table.insert(keys, key.Name) end end return keys end
function RLib.isMouseButtonDown(button) return UserInputService:IsMouseButtonPressed(button) end
function RLib.isTouchEnabled() return UserInputService.TouchEnabled end
function RLib.isKeyboardEnabled() return UserInputService.KeyboardEnabled end
function RLib.isMouseEnabled() return UserInputService.MouseEnabled end
function RLib.isGamepadEnabled() return UserInputService.GamepadEnabled end
function RLib.getLastInputType() return UserInputService.LastInputType end

-- MaT H
function RLib.getDistance(p1, p2) return (p1-p2).Magnitude end
function RLib.lerp(a, b, t) return a + (b-a) * t end
function RLib.clamp(v, min, max) return math.max(min, math.min(max, v)) end
function RLib.round(n, d) local m = 10^(d or 0) return math.floor(n * m + 0.5) / m end
function RLib.randomFloat(min, max) return min + math.random() * (max - min) end
function RLib.randomVector3(min, max) return Vector3.new(math.random(min or -100, max or 100), math.random(min or -100, max or 100), math.random(min or -100, max or 100)) end
function RLib.randomCFrame(pos, rot) local p = pos or RLib.randomVector3() local r = rot or Vector3.new(math.random(0,360), math.random(0,360), math.random(0,360)) return CFrame.new(p) * CFrame.Angles(math.rad(r.X), math.rad(r.Y), math.rad(r.Z)) end
function RLib.map(v, inMin, inMax, outMin, outMax) return (v - inMin) * (outMax - outMin) / (inMax - inMin) + outMin end
function RLib.angleBetween(p1, p2) local dir = (p2 - p1).Unit return math.atan2(dir.Z, dir.X) end
function RLib.normalize(v) return v.Unit end
function RLib.dot(v1, v2) return v1:Dot(v2) end
function RLib.cross(v1, v2) return v1:Cross(v2) end
function RLib.magnitude(v) return v.Magnitude end
function RLib.distance2D(p1, p2) return math.sqrt((p1.X - p2.X)^2 + (p1.Z - p2.Z)^2) end
function RLib.midpoint(p1, p2) return (p1 + p2) / 2 end
function RLib.rotateVector(v, angle) local cos, sin = math.cos(angle), math.sin(angle) return Vector3.new(v.X * cos - v.Z * sin, v.Y, v.X * sin + v.Z * cos) end
function RLib.reflect(v, normal) return v - 2 * v:Dot(normal) * normal end
function RLib.project(v, onto) return onto * (v:Dot(onto) / onto:Dot(onto)) end
function RLib.reject(v, onto) return v - RLib.project(v, onto) end
function RLib.slerp(v1, v2, t) local dot = v1:Dot(v2) if dot > 0.9995 then return RLib.lerp(v1, v2, t) end local theta = math.acos(math.abs(dot)) local sinTheta = math.sin(theta) return (math.sin((1-t) * theta) / sinTheta) * v1 + (math.sin(t * theta) / sinTheta) * v2 end
function RLib.bezier(p0, p1, p2, p3, t) local u = 1 - t return u^3 * p0 + 3 * u^2 * t * p1 + 3 * u * t^2 * p2 + t^3 * p3 end
function RLib.catmullRom(p0, p1, p2, p3, t) return 0.5 * ((2 * p1) + (-p0 + p2) * t + (2*p0 - 5*p1 + 4*p2 - p3) * t^2 + (-p0 + 3*p1 - 3*p2 + p3) * t^3) end
function RLib.smoothstep(edge0, edge1, x) local t = RLib.clamp((x - edge0) / (edge1 - edge0), 0, 1) return t * t * (3 - 2 * t) end
function RLib.step(edge, x) return x < edge and 0 or 1 end
function RLib.sign(x) return x > 0 and 1 or x < 0 and -1 or 0 end

-- String Stuff
function RLib.split(s, d) local r, p, last = {}, "(.-)"..d, 1 for part in s:gmatch(p) do table.insert(r, part) last = last + #part + #d end table.insert(r, s:sub(last)) return r end
function RLib.trim(s) return s:match("^%s*(.-)%s*$") end
function RLib.capitalize(s) return s:sub(1,1):upper() .. s:sub(2):lower() end
function RLib.randomString(l) local c, r = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "" for i = 1, l or 10 do r = r .. c:sub(math.random(#c), math.random(#c)) end return r end
function RLib.reverse(s) return s:reverse() end
function RLib.contains(s, sub) return s:find(sub) ~= nil end
function RLib.startsWith(s, prefix) return s:sub(1, #prefix) == prefix end
function RLib.endsWith(s, suffix) return s:sub(-#suffix) == suffix end
function RLib.replace(s, old, new) return s:gsub(old, new) end
function RLib.replaceAll(s, replacements) for old, new in pairs(replacements) do s = s:gsub(old, new) end return s end
function RLib.count(s, sub) local _, count = s:gsub(sub, "") return count end
function RLib.padLeft(s, len, char) return string.rep(char or " ", len - #s) .. s end
function RLib.padRight(s, len, char) return s .. string.rep(char or " ", len - #s) end
function RLib.center(s, len, char) local pad = len - #s local left = math.floor(pad / 2) local right = pad - left return string.rep(char or " ", left) .. s .. string.rep(char or " ", right) end
function RLib.toHex(s) return s:gsub(".", function(c) return string.format("%02x", string.byte(c)) end) end

-- Table Flip
function RLib.deepCopy(orig) local copy if type(orig) == 'table' then copy = {} for k, v in next, orig, nil do copy[RLib.deepCopy(k)] = RLib.deepCopy(v) end setmetatable(copy, RLib.deepCopy(getmetatable(orig))) else copy = orig end return copy end
function RLib.tableLength(t) local count = 0 for _ in pairs(t) do count = count + 1 end return count end
function RLib.shuffleTable(t) for i = #t, 2, -1 do local j = math.random(i) t[i], t[j] = t[j], t[i] end return t end
function RLib.findInTable(t, v) for i, val in pairs(t) do if val == v then return i end end end
function RLib.merge(t1, t2) for k, v in pairs(t2) do t1[k] = v end return t1 end
function RLib.keys(t) local k = {} for key, _ in pairs(t) do table.insert(k, key) end return k end
function RLib.values(t) local v = {} for _, val in pairs(t) do table.insert(v, val) end return v end
function RLib.filter(t, func) local result = {} for k, v in pairs(t) do if func(v, k) then result[k] = v end end return result end
function RLib.map(t, func) local result = {} for k, v in pairs(t) do result[k] = func(v, k) end return result end
function RLib.reduce(t, func, init) local acc = init for k, v in pairs(t) do acc = func(acc, v, k) end return acc end
function RLib.reverse(t) local result = {} for i = #t, 1, -1 do table.insert(result, t[i]) end return result end
function RLib.slice(t, start, finish) local result = {} for i = start or 1, finish or #t do table.insert(result, t[i]) end return result end
function RLib.concat(t1, t2) local result = {} for _, v in ipairs(t1) do table.insert(result, v) end for _, v in ipairs(t2) do table.insert(result, v) end return result end
function RLib.unique(t) local seen, result = {}, {} for _, v in ipairs(t) do if not seen[v] then seen[v] = true table.insert(result, v) end end return result end
function RLib.flatten(t) local result = {} for _, v in ipairs(t) do if type(v) == "table" then for _, nested in ipairs(RLib.flatten(v)) do table.insert(result, nested) end else table.insert(result, v) end end return result end

-- Many a times
function RLib.wait(t) wait(t or 1) end
function RLib.formatTime(s) local h = math.floor(s / 3600) local m = math.floor((s % 3600) / 60) local sec = s % 60 return string.format("%02d:%02d:%02d", h, m, sec) end
function RLib.getTimestamp() return os.time() end
function RLib.delay(d, cb) spawn(function() wait(d) cb() end) end
function RLib.debounce(func, delay) local lastCall = 0 return function(...) local now = tick() if now - lastCall >= delay then lastCall = now return func(...) end end end
function RLib.throttle(func, limit) local inThrottle return function(...) if not inThrottle then inThrottle = true spawn(function() wait(limit) inThrottle = false end) return func(...) end end end
function RLib.timeout(func, delay) spawn(function() wait(delay) func() end) end
function RLib.interval(func, delay) spawn(function() while true do func() wait(delay) end end) end
function RLib.stopwatch() local start = tick() return function() return tick() - start end end
function RLib.benchmark(func) local start = tick() func() return tick() - start end

-- Random ass utilities
function RLib.randomColor() return Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255)) end
function RLib.rgbToHsv(r, g, b) r, g, b = r/255, g/255, b/255 local max, min = math.max(r,g,b), math.min(r,g,b) local h, s, v = 0, 0, max local d = max - min s = max == 0 and 0 or d / max if max ~= min then if max == r then h = (g - b) / d + (g < b and 6 or 0) elseif max == g then h = (b - r) / d + 2 elseif max == b then h = (r - g) / d + 4 end h = h / 6 end return h, s, v end
function RLib.hsvToRgb(h, s, v) local r, g, b local i = math.floor(h * 6) local f = h * 6 - i local p = v * (1 - s) local q = v * (1 - f * s) local t = v * (1 - (1 - f) * s) local imod = i % 6 if imod == 0 then r, g, b = v, t, p elseif imod == 1 then r, g, b = q, v, p elseif imod == 2 then r, g, b = p, v, t elseif imod == 3 then r, g, b = p, q, v elseif imod == 4 then r, g, b = t, p, v elseif imod == 5 then r, g, b = v, p, q end return Color3.fromRGB(r*255, g*255, b*255) end
function RLib.tween(o, props, d, es, ed) local t = TweenService:Create(o, TweenInfo.new(d or 1, es or Enum.EasingStyle.Linear, ed or Enum.EasingDirection.InOut), props) t:Play() return t end
function RLib.raycast(o, d, f) local r = RaycastParams.new() r.FilterType = Enum.RaycastFilterType.Blacklist r.FilterDescendantsInstances = f or {} return Workspace:Raycast(o, d, r) end
function RLib.getPlayerFromMouse() local m = LocalPlayer:GetMouse() if m.Target and m.Target.Parent:FindFirstChild("Humanoid") then return Players:GetPlayerFromCharacter(m.Target.Parent) end end
function RLib.getPartFromMouse() return LocalPlayer:GetMouse().Target end
function RLib.getPositionFromMouse() return LocalPlayer:GetMouse().Hit.Position end
function RLib.getClosestPlayer(pos) local closest, shortest = nil, math.huge for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character.HumanoidRootPart then local d = RLib.getDistance(pos, p.Character.HumanoidRootPart.Position) if d < shortest then shortest, closest = d, p end end end return closest, shortest end
function RLib.notify(t, txt, d) StarterGui:SetCore("SendNotification", {Title=t or "Notify", Text=txt or "Message", Duration=d or 3}) end
function RLib.optimizeGame() pcall(function() settings().Rendering.QualityLevel = 1 end) for _, e in pairs(Lighting:GetChildren()) do if e:IsA("PostEffect") then e.Enabled = false end end end
function RLib.getMemoryUsage() return collectgarbage("count") end
function RLib.cleanMemory() collectgarbage("collect") end
function RLib.createConnection(event, func) return event:Connect(func) end
function RLib.disconnectConnection(con) if con then con:Disconnect() end end
function RLib.fireEvent(event, ...) if event then event:Fire(...) end end
function RLib.createEvent() return Instance.new("BindableEvent").Event end
function RLib.createFunction() return Instance.new("BindableFunction") end
function RLib.uuid() return HttpService:GenerateGUID(false) end
function RLib.jsonEncode(data) return HttpService:JSONEncode(data) end
function RLib.jsonDecode(json) return HttpService:JSONDecode(json) end
function RLib.urlEncode(url) return HttpService:UrlEncode(url) end

-- experience game stuff idk
function RLib.getGameId() return game.GameId end
function RLib.getPlaceId() return game.PlaceId end
function RLib.rejoinGame() TeleportService:Teleport(game.PlaceId, LocalPlayer) end
function RLib.serverHop(fullServerCheck, targetPlayerCount, targetPing, pages) fullServerCheck = fullServerCheck ~= false targetPlayerCount = targetPlayerCount or nil targetPing = targetPing or nil pages = pages or 3 spawn(function() pcall(function() local bestServer, bestDifference, foundAnything, currentPage = nil, math.huge, "", 0 local function getServerScore(server) if server.id == game.JobId then return -1 end if fullServerCheck and server.playing >= server.maxPlayers then return -1 end local score = 0 if targetPlayerCount then local diff = math.abs(server.playing - targetPlayerCount) score = score + (1000 - diff * 10) if diff == 0 then score = score + 500 end if server.playing > targetPlayerCount and targetPlayerCount <= server.maxPlayers then score = score - 200 end else score = score + (server.maxPlayers - server.playing) * 5 end if targetPing and server.ping then local pingDiff = math.abs(server.ping - targetPing) score = score + (500 - pingDiff * 2) if pingDiff == 0 then score = score + 300 end elseif server.ping then score = score + (200 - server.ping) end return score + math.random(1, 25) end while currentPage < pages do local url = 'https://games.roblox.com/v1/games/'..game.PlaceId..'/servers/Public?sortOrder=Asc&limit=100' if foundAnything ~= "" then url = url .. '&cursor=' .. foundAnything end local success, response = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end) if not success then break end for _, server in pairs(response.data) do local score = getServerScore(server) if score > 0 then local playerDiff = targetPlayerCount and math.abs(server.playing - targetPlayerCount) or 0 local pingDiff = targetPing and server.ping and math.abs(server.ping - targetPing) or 0 local combinedDiff = playerDiff + (pingDiff * 0.1) if targetPlayerCount or targetPing then if combinedDiff < bestDifference or (combinedDiff == bestDifference and score > (bestServer and getServerScore(bestServer) or 0)) then bestServer, bestDifference = server, combinedDiff end else if score > (bestServer and getServerScore(bestServer) or 0) then bestServer = server end end end end if response.nextPageCursor and response.nextPageCursor ~= "null" then foundAnything, currentPage = response.nextPageCursor, currentPage + 1 else break end wait(0.1) end if bestServer then local pingText = bestServer.ping and (" | Ping: "..bestServer.ping.."ms") or "" RLib.notify("Server Hop", "Joining: "..bestServer.playing.."/"..bestServer.maxPlayers.." players"..pingText, 4) wait(1) TeleportService:TeleportToPlaceInstance(game.PlaceId, bestServer.id, LocalPlayer) else RLib.notify("Server Hop", "No match found, using fallback", 3) local simple = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/'..game.PlaceId..'/servers/Public?sortOrder=Asc&limit=100')) for _, server in pairs(simple.data) do if server.playing < server.maxPlayers and server.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer) break end end end end) end) end
function RLib.getServerInfo() return {JobId = game.JobId, PlaceId = game.PlaceId, GameId = game.GameId, PlayerCount = #Players:GetPlayers(), MaxPlayers = Players.MaxPlayers} end
function RLib.getGameName() return MarketplaceService:GetProductInfo(game.PlaceId).Name end
function RLib.getGameCreator() return MarketplaceService:GetProductInfo(game.PlaceId).Creator end
function RLib.isGameFavorited() return MarketplaceService:GetProductInfo(game.PlaceId).IsFavorited end
function RLib.getGameGenre() return MarketplaceService:GetProductInfo(game.PlaceId).Genre end
function RLib.getGameDescription() return MarketplaceService:GetProductInfo(game.PlaceId).Description end
function RLib.getGameThumbnail() return MarketplaceService:GetProductInfo(game.PlaceId).IconImageAssetId end
function RLib.getServerRegion() return game:GetService("LocalizationService").RobloxLocaleId end
function RLib.getFPS() return Workspace:GetRealPhysicsFPS() end
function RLib.getPing() return LocalPlayer:GetNetworkPing() * 1000 end
function RLib.isStudio() return game:GetService("RunService"):IsStudio() end
function RLib.getJobId() return game.JobId end

-- I love C:\Users\NOTGodlynoah\Desktop\Executors\Xeno\workspace
function RLib.saveData(k, d) if writefile then writefile(k..".json", HttpService:JSONEncode(d)) return true end return false end
function RLib.loadData(k) if readfile and isfile and isfile(k..".json") then return HttpService:JSONDecode(readfile(k..".json")) end end
function RLib.deleteData(k) if delfile and isfile and isfile(k..".json") then delfile(k..".json") return true end return false end
function RLib.fileExists(k) return isfile and isfile(k) end
function RLib.createFolder(name) if makefolder then makefolder(name) return true end return false end
function RLib.deleteFolder(name) if delfolder then delfolder(name) return true end return false end
function RLib.listFiles(path) if listfiles then return listfiles(path) end return {} end
function RLib.setClipboard(t) if setclipboard then setclipboard(t) return true end return false end
function RLib.getClipboard() if getclipboard then return getclipboard() end return "" end
function RLib.writeFile(name, content) if writefile then writefile(name, content) return true end return false end

-- exploring shitty poo (esp) and other stuff like that
function RLib.createESP(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.HumanoidRootPart then local bb = Instance.new("BillboardGui") bb.Size = UDim2.new(0,100,0,50) bb.StudsOffset = Vector3.new(0,3,0) bb.Parent = p.Character.HumanoidRootPart local nl = Instance.new("TextLabel") nl.Size = UDim2.new(1,0,0.5,0) nl.BackgroundTransparency = 1 nl.Text = p.Name nl.TextColor3 = c or Color3.new(1,1,1) nl.TextScaled = true nl.Parent = bb local dl = Instance.new("TextLabel") dl.Size = UDim2.new(1,0,0.5,0) dl.Position = UDim2.new(0,0,0.5,0) dl.BackgroundTransparency = 1 dl.TextColor3 = c or Color3.new(1,1,1) dl.TextScaled = true dl.Parent = bb local con = RunService.Heartbeat:Connect(function() if p.Character and p.Character.HumanoidRootPart and LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then dl.Text = math.floor(RLib.getDistance(LocalPlayer.Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position)).." studs" else bb:Destroy() con:Disconnect() end end) return bb end end
function RLib.removeESP(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.HumanoidRootPart then for _, g in pairs(p.Character.HumanoidRootPart:GetChildren()) do if g:IsA("BillboardGui") then g:Destroy() end end end end
function RLib.createChams(p, c, t) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character then for _, part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then local h = Instance.new("Highlight") h.FillColor = c or Color3.fromRGB(255,0,0) h.FillTransparency = t or 0.5 h.OutlineTransparency = 1 h.Parent = part end end end end
function RLib.removeChams(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character then for _, part in pairs(p.Character:GetDescendants()) do if part:IsA("Highlight") then part:Destroy() end end end end
function RLib.createTracers(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.HumanoidRootPart then local con = RunService.Heartbeat:Connect(function() if p.Character and p.Character.HumanoidRootPart and LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then local beam, p1, p2 = RLib.createBeam(LocalPlayer.Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position, c or Color3.new(1,0,0), 0.1) Debris:AddItem(p1, 0.1) Debris:AddItem(p2, 0.1) else con:Disconnect() end end) return con end end
function RLib.createBox(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.HumanoidRootPart then local box = Instance.new("SelectionBox") box.Adornee = p.Character box.Color3 = c or Color3.new(1,0,0) box.LineThickness = 0.1 box.Transparency = 0.5 box.Parent = p.Character return box end end
function RLib.removeBox(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character then for _, box in pairs(p.Character:GetDescendants()) do if box:IsA("SelectionBox") then box:Destroy() end end end end
function RLib.createHealthBar(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.HumanoidRootPart and p.Character.Humanoid then local gui = Instance.new("BillboardGui") gui.Size = UDim2.new(0,100,0,10) gui.StudsOffset = Vector3.new(0,-3,0) gui.Parent = p.Character.HumanoidRootPart local bg = Instance.new("Frame") bg.Size = UDim2.new(1,0,1,0) bg.BackgroundColor3 = Color3.new(0,0,0) bg.BorderSizePixel = 1 bg.Parent = gui local health = Instance.new("Frame") health.Size = UDim2.new(p.Character.Humanoid.Health/p.Character.Humanoid.MaxHealth,0,1,0) health.BackgroundColor3 = Color3.new(0,1,0) health.BorderSizePixel = 0 health.Parent = bg local con = RunService.Heartbeat:Connect(function() if p.Character and p.Character.Humanoid then local ratio = p.Character.Humanoid.Health/p.Character.Humanoid.MaxHealth health.Size = UDim2.new(ratio,0,1,0) health.BackgroundColor3 = Color3.new(1-ratio,ratio,0) else gui:Destroy() con:Disconnect() end end) return gui end end
function RLib.createSkeletonESP(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character then local bones = {} local function addBone(from, to) if p.Character:FindFirstChild(from) and p.Character:FindFirstChild(to) then local beam, p1, p2 = RLib.createBeam(p.Character[from].Position, p.Character[to].Position, c or Color3.new(1,1,1), 0.05) bones[from..to] = {beam, p1, p2} end end addBone("Head", "UpperTorso") addBone("UpperTorso", "LowerTorso") addBone("UpperTorso", "LeftUpperArm") addBone("UpperTorso", "RightUpperArm") addBone("LeftUpperArm", "LeftLowerArm") addBone("RightUpperArm", "RightLowerArm") addBone("LeftLowerArm", "LeftHand") addBone("RightLowerArm", "RightHand") addBone("LowerTorso", "LeftUpperLeg") addBone("LowerTorso", "RightUpperLeg") addBone("LeftUpperLeg", "LeftLowerLeg") addBone("RightUpperLeg", "RightLowerLeg") addBone("LeftLowerLeg", "LeftFoot") addBone("RightLowerLeg", "RightFoot") return bones end end
function RLib.create3DBox(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character then local box = Instance.new("BoxHandleAdornment") box.Adornee = p.Character.HumanoidRootPart box.Size = p.Character.HumanoidRootPart.Size + Vector3.new(1,1,1) box.Color3 = c or Color3.new(1,0,0) box.Transparency = 0.5 box.AlwaysOnTop = true box.Parent = p.Character.HumanoidRootPart return box end end
function RLib.createHeadDot(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.Head then local sphere = Instance.new("SphereHandleAdornment") sphere.Adornee = p.Character.Head sphere.Radius = 0.5 sphere.Color3 = c or Color3.new(1,0,0) sphere.AlwaysOnTop = true sphere.Parent = p.Character.Head return sphere end end
function RLib.createNameTag(p, text, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.Head then local gui = Instance.new("BillboardGui") gui.Size = UDim2.new(0,200,0,50) gui.StudsOffset = Vector3.new(0,2,0) gui.Parent = p.Character.Head local label = Instance.new("TextLabel") label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1 label.Text = text or p.Name label.TextColor3 = c or Color3.new(1,1,1) label.TextScaled = true label.Font = Enum.Font.SourceSansBold label.Parent = gui return gui end end
function RLib.createDistanceTracker(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p and p.Character and p.Character.HumanoidRootPart then local gui = Instance.new("BillboardGui") gui.Size = UDim2.new(0,100,0,25) gui.StudsOffset = Vector3.new(0,4,0) gui.Parent = p.Character.HumanoidRootPart local label = Instance.new("TextLabel") label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1 label.TextColor3 = Color3.new(1,1,1) label.TextScaled = true label.Parent = gui local con = RunService.Heartbeat:Connect(function() if p.Character and p.Character.HumanoidRootPart and LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then local dist = RLib.getDistance(LocalPlayer.Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position) label.Text = math.floor(dist).." studs" else gui:Destroy() con:Disconnect() end end) return gui end end
function RLib.clearAllESP() for _, p in pairs(Players:GetPlayers()) do RLib.removeESP(p) RLib.removeChams(p) RLib.removeBox(p) end end

-- random advanced shit
function RLib.createClone(p) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character then local c = p.Character:Clone() c.Name = p.Name.."_Clone" c.Parent = Workspace return c end end
function RLib.orbitPlayer(t, r, s) t = type(t)=="string" and RLib.getPlayer(t) or t if t and t.Character and LocalPlayer.Character then local con, ang = nil, 0 con = RunService.Heartbeat:Connect(function() if t.Character and t.Character.HumanoidRootPart and LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then ang = ang + (s or 0.1) local x, z = math.cos(ang) * (r or 10), math.sin(ang) * (r or 10) LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(t.Character.HumanoidRootPart.Position + Vector3.new(x, 5, z), t.Character.HumanoidRootPart.Position) else con:Disconnect() end end) return con end end
function RLib.followPlayer(t, d) t = type(t)=="string" and RLib.getPlayer(t) or t if t and t.Character and LocalPlayer.Character then local con = RunService.Heartbeat:Connect(function() if t.Character and t.Character.HumanoidRootPart and LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then local tPos, myPos = t.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position local dir = (tPos - myPos).Unit LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(tPos - dir * (d or 5), tPos) else con:Disconnect() end end) return con end end
function RLib.antiAfk() return LocalPlayer.Idled:Connect(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game) wait(0.1) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game) end) end
function RLib.pathfindTo(pos) if LocalPlayer.Character and LocalPlayer.Character.Humanoid then local path = PathfindingService:CreatePath() path:ComputeAsync(LocalPlayer.Character.HumanoidRootPart.Position, pos) if path.Status == Enum.PathStatus.Success then LocalPlayer.Character.Humanoid:MoveTo(pos) return true end end return false end
function RLib.smoothTeleport(p, pos, d) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.HumanoidRootPart then local tween = TweenService:Create(p.Character.HumanoidRootPart, TweenInfo.new(d or 2, Enum.EasingStyle.Sine), {CFrame = CFrame.new(pos)}) tween:Play() return tween end end
function RLib.createWaypoint(name, pos) return {Name = name, Position = pos, Created = tick()} end
function RLib.saveWaypoint(name, pos) RLib.saveData("waypoint_"..name, {Position = pos, Created = tick()}) end
function RLib.loadWaypoint(name) return RLib.loadData("waypoint_"..name) end
function RLib.deleteWaypoint(name) RLib.deleteData("waypoint_"..name) end

-- chat stuff
function RLib.sendMessage(m) local c = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") if c then c.SayMessageRequest:FireServer(m, "All") end end
function RLib.spamChat(m, t, d) spawn(function() for i = 1, t or 10 do RLib.sendMessage(m or "Spam "..i) wait(d or 1) end end) end
function RLib.createChatBubble(p, m, d) p = type(p)=="string" and RLib.getPlayer(p) or p or LocalPlayer if p.Character and p.Character.Head then Chat:Chat(p.Character.Head, m, Enum.ChatColor.White) if d then spawn(function() wait(d) end) end end end
function RLib.clearChat() StarterGui:SetCore("ChatMakeSystemMessage", {Text = "", Color = Color3.new(0,0,0), Font = Enum.Font.SourceSans, FontSize = Enum.FontSize.Size18}) end
function RLib.getChatHistory() return {} end
function RLib.muteChatFor(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p then StarterGui:SetCore("ChatBarDisabled", true) end end
function RLib.unmuteChatFor(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p then StarterGui:SetCore("ChatBarDisabled", false) end end
function RLib.setChatBubbleColor(p, c) p = type(p)=="string" and RLib.getPlayer(p) or p if p.Character and p.Character.Head then Chat:Chat(p.Character.Head, "", c) end end
function RLib.createSystemMessage(text, color) StarterGui:SetCore("ChatMakeSystemMessage", {Text = text, Color = color or Color3.new(1,1,1), Font = Enum.Font.SourceSans, FontSize = Enum.FontSize.Size18}) end
function RLib.whisperPlayer(p, msg) p = type(p)=="string" and RLib.getPlayer(p) or p local c = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") if c and p then c.SayMessageRequest:FireServer("/w "..p.Name.." "..msg, "All") end end
function RLib.teamChat(msg) local c = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") if c then c.SayMessageRequest:FireServer(msg, "Team") end end
function RLib.setChatVisible(visible) StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, visible) end

-- microsoft teams :3
function RLib.switchTeam(n) for _, t in pairs(Teams:GetTeams()) do if t.Name:lower():find(n:lower()) then LocalPlayer.Team = t break end end end
function RLib.getTeamPlayers(n) local tp = {} for _, p in pairs(Players:GetPlayers()) do if p.Team and p.Team.Name:lower():find(n:lower()) then table.insert(tp, p) end end return tp end
function RLib.getAllTeams() return Teams:GetTeams() end
function RLib.createTeam(name, color) local team = Instance.new("Team") team.Name = name team.TeamColor = color or BrickColor.random() team.Parent = Teams return team end
function RLib.deleteTeam(name) for _, team in pairs(Teams:GetTeams()) do if team.Name:lower():find(name:lower()) then team:Destroy() break end end end
function RLib.setTeamColor(name, color) for _, team in pairs(Teams:GetTeams()) do if team.Name:lower():find(name:lower()) then team.TeamColor = color break end end end
function RLib.setAutoAssignable(name, auto) for _, team in pairs(Teams:GetTeams()) do if team.Name:lower():find(name:lower()) then team.AutoAssignable = auto break end end end
function RLib.getTeamScore(name) for _, team in pairs(Teams:GetTeams()) do if team.Name:lower():find(name:lower()) then return team.Score.Value end end return 0 end
function RLib.setTeamScore(name, score) for _, team in pairs(Teams:GetTeams()) do if team.Name:lower():find(name:lower()) then team.Score.Value = score break end end end
function RLib.balanceTeams() local teams = Teams:GetTeams() if #teams > 1 then local players = Players:GetPlayers() for i, p in ipairs(players) do p.Team = teams[((i-1) % #teams) + 1] end end end

-- drawing ig. 
function RLib.createDrawing(t) if Drawing then return Drawing.new(t) end end
function RLib.createLine(from, to, color, thickness) if Drawing then local line = Drawing.new("Line") line.From = from line.To = to line.Color = color or Color3.new(1,1,1) line.Thickness = thickness or 1 line.Visible = true return line end end
function RLib.createCircle(pos, radius, color, filled) if Drawing then local circle = Drawing.new("Circle") circle.Position = pos circle.Radius = radius or 50 circle.Color = color or Color3.new(1,1,1) circle.Filled = filled or false circle.Visible = true return circle end end
function RLib.createSquare(pos, size, color, filled) if Drawing then local square = Drawing.new("Square") square.Position = pos square.Size = size or Vector2.new(50,50) square.Color = color or Color3.new(1,1,1) square.Filled = filled or false square.Visible = true return square end end
function RLib.createTriangle(p1, p2, p3, color, filled) if Drawing then local tri = Drawing.new("Triangle") tri.PointA = p1 tri.PointB = p2 tri.PointC = p3 tri.Color = color or Color3.new(1,1,1) tri.Filled = filled or false tri.Visible = true return tri end end
function RLib.createText(pos, text, size, color) if Drawing then local txt = Drawing.new("Text") txt.Position = pos txt.Text = text or "Text" txt.Size = size or 18 txt.Color = color or Color3.new(1,1,1) txt.Center = true txt.Outline = true txt.Visible = true return txt end end
function RLib.createQuad(p1, p2, p3, p4, color, filled) if Drawing then local quad = Drawing.new("Quad") quad.PointA = p1 quad.PointB = p2 quad.PointC = p3 quad.PointD = p4 quad.Color = color or Color3.new(1,1,1) quad.Filled = filled or false quad.Visible = true return quad end end
function RLib.hideDrawing(drawing) if drawing then drawing.Visible = false end end
function RLib.showDrawing(drawing) if drawing then drawing.Visible = true end end
function RLib.removeDrawing(drawing) if drawing then drawing:Remove() end end
function RLib.setDrawingColor(drawing, color) if drawing then drawing.Color = color end end
function RLib.setDrawingTransparency(drawing, transparency) if drawing then drawing.Transparency = transparency end end
function RLib.setDrawingThickness(drawing, thickness) if drawing and drawing.Thickness then drawing.Thickness = thickness end end
function RLib.setDrawingPosition(drawing, pos) if drawing and drawing.Position then drawing.Position = pos end end
function RLib.clearAllDrawings() if Drawing then for _, obj in pairs(getgenv().drawings or {}) do pcall(function() obj:Remove() end) end getgenv().drawings = {} end end

-- http n network stuff
function RLib.httpGet(url) return game:HttpGet(url) end
function RLib.httpPost(url, data) return game:HttpPost(url, data) end
function RLib.getProductInfo(id) return MarketplaceService:GetProductInfo(id) end
function RLib.getUserInfo(id) return Players:GetUserInfoFromUserId(id) end
function RLib.checkGamepass(p, id) p = type(p)=="string" and RLib.getPlayer(p) or p return MarketplaceService:UserOwnsGamePassAsync(p.UserId, id) end
function RLib.checkAsset(p, id) p = type(p)=="string" and RLib.getPlayer(p) or p return MarketplaceService:PlayerOwnsAsset(p, id) end
function RLib.getUniverseInfo(id) return MarketplaceService:GetProductInfo(id, Enum.InfoType.Product) end
function RLib.getBundleInfo(id) return MarketplaceService:GetBundleDetailsAsync(id) end
function RLib.searchCatalog(keyword) return MarketplaceService:GetProductInfo(keyword) end
function RLib.downloadAsset(id) if syn and syn.request then return syn.request({Url = "https://assetdelivery.roblox.com/v1/asset/?id="..id, Method = "GET"}).Body end end

-- obfuscation and encryption stuffs
function RLib.obfuscateString(str) local result = "" for i = 1, #str do result = result .. string.char(str:byte(i) + 1) end return result end
function RLib.deobfuscateString(str) local result = "" for i = 1, #str do result = result .. string.char(str:byte(i) - 1) end return result end
function RLib.encodeBase64(str) local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" local result = "" for i = 1, #str, 3 do local b1, b2, b3 = str:byte(i, i+2) local bitmap = (b1 << 16) + ((b2 or 0) << 8) + (b3 or 0) result = result .. chars:sub((bitmap >> 18) + 1, (bitmap >> 18) + 1) .. chars:sub(((bitmap >> 12) & 63) + 1, ((bitmap >> 12) & 63) + 1) .. (b2 and chars:sub(((bitmap >> 6) & 63) + 1, ((bitmap >> 6) & 63) + 1) or "=") .. (b3 and chars:sub((bitmap & 63) + 1, (bitmap & 63) + 1) or "=") end return result end
function RLib.hashString(str) local hash = 0 for i = 1, #str do hash = ((hash << 5) - hash + str:byte(i)) & 0xFFFFFFFF end return hash end
function RLib.xorEncrypt(str, key) local result = "" for i = 1, #str do result = result .. string.char(str:byte(i) ~ key:byte(((i-1) % #key) + 1)) end return result end
function RLib.xorDecrypt(str, key) return RLib.xorEncrypt(str, key) end
function RLib.generateKey(len) return RLib.randomString(len or 32) end
function RLib.validateKey(key, expected) return key == expected end
function RLib.checksum(str) local sum = 0 for i = 1, #str do sum = sum + str:byte(i) end return sum end
function RLib.scrambleFunction(func) return function(...) return func(...) end end

-- I love it when i watch and monitor things with way too many methods.
function RLib.monitorPlayer(p) p = type(p)=="string" and RLib.getPlayer(p) or p local data = {Player = p, StartTime = tick(), Positions = {}, Health = {}, Actions = {}} spawn(function() while p.Parent do if p.Character and p.Character.HumanoidRootPart then table.insert(data.Positions, {Position = p.Character.HumanoidRootPart.Position, Time = tick()}) end if p.Character and p.Character.Humanoid then table.insert(data.Health, {Health = p.Character.Humanoid.Health, Time = tick()}) end wait(1) end end) return data end
function RLib.getPlayerStats(p) p = type(p)=="string" and RLib.getPlayer(p) or p return {Name = p.Name, UserId = p.UserId, AccountAge = p.AccountAge, MembershipType = p.MembershipType, JoinTime = tick()} end
function RLib.trackMovement(p) p = type(p)=="string" and RLib.getPlayer(p) or p local positions = {} local con = RunService.Heartbeat:Connect(function() if p.Character and p.Character.HumanoidRootPart then table.insert(positions, {pos = p.Character.HumanoidRootPart.Position, time = tick()}) if #positions > 100 then table.remove(positions, 1) end end end) return positions, con end
function RLib.calculateSpeed(p) p = type(p)=="string" and RLib.getPlayer(p) or p if p.Character and p.Character.HumanoidRootPart then return p.Character.HumanoidRootPart.Velocity.Magnitude end return 0 end
function RLib.getPlaytime(p) p = type(p)=="string" and RLib.getPlayer(p) or p return tick() - (p.DataReady and 0 or 0) end
function RLib.logAction(p, action) p = type(p)=="string" and RLib.getPlayer(p) or p local log = string.format("[%s] %s: %s", os.date("%X"), p.Name, action) if writefile then appendfile("player_logs.txt", log.."\n") end return log end
function RLib.monitorChat(enabled) if enabled then local con = ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(data) RLib.logAction(data.FromSpeaker, "Said: "..data.Message) end) return con end end
function RLib.detectExploit(p) p = type(p)=="string" and RLib.getPlayer(p) or p local suspicious = false if p.Character then local speed = RLib.calculateSpeed(p) if speed > 100 then suspicious = true end if p.Character.Humanoid.Health > p.Character.Humanoid.MaxHealth then suspicious = true end end return suspicious end
function RLib.getPerformanceStats() return {FPS = Workspace:GetRealPhysicsFPS(), Memory = RLib.getMemoryUsage(), Ping = RLib.getPing()} end
function RLib.benchmark(func) local start = tick() local result = func() return tick() - start, result end

-- textures exist ig
function RLib.setTexture(obj, id) if obj and obj:IsA("BasePart") then local texture = obj:FindFirstChild("Texture") or Instance.new("Texture", obj) texture.Texture = "rbxassetid://"..id texture.Face = Enum.NormalId.Top end end
function RLib.setDecal(obj, id, face) if obj and obj:IsA("BasePart") then local decal = obj:FindFirstChild("Decal") or Instance.new("Decal", obj) decal.Texture = "rbxassetid://"..id decal.Face = face or Enum.NormalId.Front end end
function RLib.removeTextures(obj) if obj then for _, child in pairs(obj:GetChildren()) do if child:IsA("Texture") or child:IsA("Decal") then child:Destroy() end end end end
function RLib.setAllTextures(id) for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("BasePart") then RLib.setTexture(obj, id) end end end
function RLib.clearAllTextures() for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("Texture") or obj:IsA("Decal") then obj:Destroy() end end end

-- More utility shit
function RLib.executeLuaCode(code) return loadstring(code)() end
function RLib.safeExecute(func) return pcall(func) end
function RLib.asyncExecute(func) spawn(func) end
function RLib.createAlias(original, alias) RLib[alias] = RLib[original] end
function RLib.version() return "3.1" end

return RLib

