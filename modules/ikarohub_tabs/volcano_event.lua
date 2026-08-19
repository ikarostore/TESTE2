local Module = {Name = "volcano event"}

-- Volcano Event: modulo independente do IKAROHUB.
function Module.Init(ctx)
	local Tabs, Options, Fluent = ctx.Tabs, ctx.Options, ctx.Fluent
	local VolcanoTab = Tabs.VolcanoEvent
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local VirtualInputManager = game:GetService("VirtualInputManager")
	local player = Players.LocalPlayer
	local activeTween
	local movementEnabled = false
	local movementRoot
	local movementHumanoid
	local fullyBoatName = "Guardian"
	local fullyBoatSpeed = 330
	local lastBoatPurchase = 0
	local sailingSeat
	local sailingAttachment
	local sailingVelocity
	local sailingOrientation
	local sailingCollisionCache = {}
	local sailingObstacleCache = {}
	local fullyIslandReached = false
	local hadActiveBoat = false
	local recoveryInProgress = false
	local recoverFullyVolcano

	local function notifyVolcano(content)
		Fluent:Notify({Title = "Volcano Event", Content = content, Duration = 5})
	end

	local function getIsland()
		local map = workspace:FindFirstChild("Map")
		return map and map:FindFirstChild("PrehistoricIsland")
	end

	local function getCharacter()
		local character = player.Character or player.CharacterAdded:Wait()
		return character, character:WaitForChild("HumanoidRootPart")
	end

	local function stopVolcanoMovement()
		movementEnabled = false
		if activeTween then
			pcall(function() activeTween:Cancel() end)
			activeTween = nil
		end
		if movementRoot and movementRoot.Parent then
			movementRoot.Anchored = false
			movementRoot.AssemblyLinearVelocity = Vector3.zero
			movementRoot.AssemblyAngularVelocity = Vector3.zero
		end
		if movementHumanoid and movementHumanoid.Parent then
			movementHumanoid.PlatformStand = false
			movementHumanoid.AutoRotate = true
			movementHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
		movementRoot = nil
		movementHumanoid = nil
	end

	RunService.Stepped:Connect(function()
		if not movementEnabled then return end
		local character = player.Character
		if not character then return end
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Physics) end
	end)

	local function moveTo(target)
		if not target then return false end
		stopVolcanoMovement()
		local character, root = getCharacter()
		local distance = (root.Position - target.Position).Magnitude
		if distance <= 7 then return true end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		movementEnabled = true
		movementRoot = root
		movementHumanoid = humanoid
		if humanoid then
			humanoid.AutoRotate = false
			humanoid.PlatformStand = true
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		root.Anchored = true
		activeTween = TweenService:Create(root, TweenInfo.new(math.max(distance / 400, 0.1), Enum.EasingStyle.Linear), {CFrame = target})
		activeTween:Play()
		local state = activeTween.Completed:Wait()
		stopVolcanoMovement()
		return state == Enum.PlaybackState.Completed
	end

	local status = VolcanoTab:AddParagraph({
		Title = "Prehistoric Island Status",
		Content = "Procurando a ilha..."
	})

	VolcanoTab:AddSection("Fully Volcano")
	VolcanoTab:AddToggle("VolcanoFullyIgnoreMagnet", {
		Title = "Ignore Craft Volcanic Magnet [ Fully ]",
		Description = "Nao tenta fabricar o Volcanic Magnet no modo Fully",
		Default = false
	})
	VolcanoTab:AddToggle("VolcanoFullyIgnoreBone", {
		Title = "Ignore Collect Bone [ Fully ]",
		Description = "Nao coleta Dinosaur Bones no modo Fully",
		Default = false
	})
	VolcanoTab:AddToggle("VolcanoFullyEvent", {
		Title = "Fully Event Prehistoric Island",
		Description = "Executa automaticamente todas as etapas disponiveis",
		Default = false
	})
	VolcanoTab:AddDropdown("VolcanoFullyBoat", {
		Title = "Fully Volcano Boat",
		Description = "Barco usado para procurar a ilha",
		Values = {"Guardian", "Lantern", "Sleigh", "Miracle", "The Sentinel", "Dinghy"},
		Multi = false,
		Default = "Guardian",
		Callback = function(value) fullyBoatName = value end
	})
	VolcanoTab:AddSlider("VolcanoFullyBoatSpeed", {
		Title = "Boat Speed",
		Default = 330,
		Min = 100,
		Max = 350,
		Rounding = 0,
		Callback = function(value) fullyBoatSpeed = value end
	})

	task.spawn(function()
		while task.wait(1) do
			local island = getIsland()
			status:SetDesc(island and "Prehistoric Island: SPAWNADA" or "Prehistoric Island: nao encontrada")
		end
	end)

	VolcanoTab:AddSection("Prehistoric Island")
	local flyTrial = VolcanoTab:AddToggle("VolcanoFlyTrialDoor", {
		Title = "Fly To Trial Door",
		Description = "Vai ate o TrialTeleport da ilha",
		Default = false
	})
	local flyIsland = VolcanoTab:AddToggle("VolcanoFlyIsland", {
		Title = "Fly To Prehistoric Island",
		Description = "Vai ate o cranio da Prehistoric Relic",
		Default = false
	})
	local defend = VolcanoTab:AddToggle("VolcanoDefend", {
		Title = "Safe / Defend Volcano",
		Description = "Remove a lava localmente e ataca as rochas vermelhas",
		Default = false
	})

	VolcanoTab:AddSection("Weapons")
	VolcanoTab:AddToggle("VolcanoUseMelee", {Title = "Use Melee", Default = true})
	VolcanoTab:AddToggle("VolcanoUseSword", {Title = "Use Sword", Default = false})
	VolcanoTab:AddToggle("VolcanoUseGun", {Title = "Use Gun", Default = false})

	local function pressKey(key)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
		task.wait(0.04)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
	end

	local function enableHaki()
		local character = player.Character
		if character and not character:FindFirstChild("HasBuso") then
			local remotes = ReplicatedStorage:FindFirstChild("Remotes")
			local comm = remotes and remotes:FindFirstChild("CommF_")
			if comm then pcall(function() comm:InvokeServer("Buso") end) end
		end
	end

	local function equipAndCast(toolTip)
		local character = player.Character
		local backpack = player:FindFirstChild("Backpack")
		if not character or not backpack then return end
		for _, tool in ipairs(backpack:GetChildren()) do
			if tool:IsA("Tool") and tool.ToolTip == toolTip then
				tool.Parent = character
				pcall(function() tool:Activate() end)
				for _, key in ipairs({"Z", "X", "C", "V", "F"}) do
					pcall(pressKey, key)
					task.wait(0.08)
				end
				return
			end
		end
	end

	local function disableLava(island)
		for _, object in ipairs(island:GetDescendants()) do
			if object:IsA("BasePart") and string.find(string.lower(object.Name), "lava", 1, true) then
				object.CanCollide = false
				object.CanTouch = false
				object.Transparency = 1
			end
		end
	end

	local function findRedRock(island)
		local core = island:FindFirstChild("Core")
		local rocks = core and core:FindFirstChild("VolcanoRocks")
		if not rocks then return nil end
		for _, object in ipairs(rocks:GetDescendants()) do
			if object:IsA("BasePart") and string.lower(object.Name) == "volcanorock" then
				local color = object.Color
				if color == Color3.fromRGB(185, 53, 56) or color == Color3.fromRGB(185, 53, 57) then
					return object
				end
			end
		end
		return nil
	end

	task.spawn(function()
		while task.wait(0.25) do
			if Options.VolcanoFlyTrialDoor.Value then
				local island = getIsland()
				local trial = island and island:FindFirstChild("TrialTeleport", true)
				if trial and trial:IsA("BasePart") and moveTo(trial.CFrame) then
					Options.VolcanoFlyTrialDoor:SetValue(false)
				end
			elseif Options.VolcanoFlyIsland.Value then
				local island = getIsland()
				local skull = island and island:FindFirstChild("Skull", true)
				if skull and skull:IsA("BasePart") and moveTo(skull.CFrame) then
					Options.VolcanoFlyIsland:SetValue(false)
				elseif not island then
					task.wait(1)
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(0.35) do
			if Options.VolcanoDefend.Value then
				local island = getIsland()
				if island then
					disableLava(island)
					enableHaki()
					local rock = findRedRock(island)
					if rock then
						moveTo(rock.CFrame * CFrame.new(0, 4, 0))
						if Options.VolcanoUseMelee.Value then equipAndCast("Melee") end
						if Options.VolcanoUseSword.Value then equipAndCast("Sword") end
						if Options.VolcanoUseGun.Value then equipAndCast("Gun") end
					end
				end
			end
		end
	end)

	VolcanoTab:AddSection("Collect / Combat")
	VolcanoTab:AddToggle("VolcanoAttackGolems", {Title = "Attack Golems Aura", Default = false})
	VolcanoTab:AddToggle("VolcanoCollectBone", {Title = "Collect Dinosaur Bones", Default = false})
	VolcanoTab:AddToggle("VolcanoCollectEgg", {Title = "Collect Dragon Egg", Default = false})

	local function selectedAttack()
		enableHaki()
		if Options.VolcanoUseMelee.Value then equipAndCast("Melee") end
		if Options.VolcanoUseSword.Value then equipAndCast("Sword") end
		if Options.VolcanoUseGun.Value then equipAndCast("Gun") end
	end

	task.spawn(function()
		while task.wait(0.35) do
			if Options.VolcanoAttackGolems.Value then
				local enemies = workspace:FindFirstChild("Enemies")
				local target
				if enemies then
					for _, enemy in ipairs(enemies:GetChildren()) do
						local humanoid = enemy:FindFirstChildOfClass("Humanoid")
						local root = enemy:FindFirstChild("HumanoidRootPart")
						if humanoid and root and humanoid.Health > 0 and string.find(string.lower(enemy.Name), "golem", 1, true) then
							target = root
							break
						end
					end
				end
				if target then
					moveTo(target.CFrame * CFrame.new(0, 18, 0))
					selectedAttack()
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(0.3) do
			if Options.VolcanoCollectBone.Value then
				local island = getIsland()
				local bone = island and island:FindFirstChild("DinoBone", true)
				if bone and bone:IsA("BasePart") then
					local collectedBone = bone
					if moveTo(bone.CFrame) then
						task.wait(0.5)
						if not collectedBone.Parent and recoverFullyVolcano then
							recoverFullyVolcano("Dinosaur Bone coletado; iniciando novo ciclo.", true)
						end
					end
				end
			end
			if Options.VolcanoCollectEgg.Value then
				local island = getIsland()
				local eggs = island and island:FindFirstChild("SpawnedDragonEggs", true)
				local egg = eggs and eggs:GetChildren()[1]
				local part = egg and (egg:IsA("BasePart") and egg or egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart", true))
				if part and moveTo(part.CFrame) then
					local prompt = egg:FindFirstChildWhichIsA("ProximityPrompt", true)
					if prompt and fireproximityprompt then
						pcall(fireproximityprompt, prompt)
					else
						pcall(pressKey, "E")
					end
					task.wait(0.5)
					if (not egg.Parent or (prompt and not prompt.Enabled)) and recoverFullyVolcano then
						recoverFullyVolcano("Dragon Egg coletado; iniciando novo ciclo.", true)
					end
				end
			end
		end
	end)

	for _, id in ipairs({"VolcanoFlyTrialDoor", "VolcanoFlyIsland", "VolcanoDefend"}) do
		Options[id]:OnChanged(function(value)
			if not value then stopVolcanoMovement() end
		end)
	end

	local lastMagnetCraft = 0
	local function craftVolcanicMagnet()
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		local comm = remotes and remotes:FindFirstChild("CommF_")
		if not comm then return false end
		local ok = pcall(function()
			comm:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
		end)
		return ok
	end
	local function hasLivingGolem()
		local enemies = workspace:FindFirstChild("Enemies")
		if not enemies then return false end
		for _, enemy in ipairs(enemies:GetChildren()) do
			local humanoid = enemy:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 and string.find(string.lower(enemy.Name), "golem", 1, true) then
				return true
			end
		end
		return false
	end
	local function boatOwnerMatches(boat)
		for _, valueName in ipairs({"BoatOwner", "Owner", "owner"}) do
			local value = boat:FindFirstChild(valueName, true)
			if value and value:IsA("StringValue") and value.Value == player.Name then return true end
			if value and value:IsA("ObjectValue") and value.Value == player then return true end
		end
		return false
	end
	local function findMyBoatSeat()
		local boats = workspace:FindFirstChild("Boats")
		if not boats then return nil end
		local fallback
		local _, root = getCharacter()
		for _, boat in ipairs(boats:GetChildren()) do
			local seat = boat:FindFirstChild("VehicleSeat", true)
			if seat and seat:IsA("VehicleSeat") then
				if seat.Occupant and seat.Occupant.Parent == player.Character then return seat end
				if not seat.Occupant and boatOwnerMatches(boat) then return seat end
				if not fallback and not seat.Occupant and boat.Name == fullyBoatName and (seat.Position - root.Position).Magnitude <= 1200 then
					fallback = seat
				end
			end
		end
		return fallback
	end
	local function buyFullyBoat()
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		local comm = remotes and remotes:FindFirstChild("CommF_")
		if not comm then return end
		pcall(function() comm:InvokeServer("BuyBoat", fullyBoatName) end)
	end
	local function releaseSailingControls()
		pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game) end)
		if sailingSeat and sailingSeat.Parent then
			pcall(function() sailingSeat.Throttle = 0 end)
		end
		for _, actuator in pairs({sailingVelocity, sailingOrientation, sailingAttachment}) do
			if actuator then pcall(function() actuator:Destroy() end) end
		end
		sailingVelocity, sailingOrientation, sailingAttachment = nil, nil, nil
		for part, oldValue in pairs(sailingCollisionCache) do
			if part and part.Parent then pcall(function() part.CanCollide = oldValue end) end
		end
		for part, oldValue in pairs(sailingObstacleCache) do
			if part and part.Parent then pcall(function() part.CanCollide = oldValue end) end
		end
		sailingCollisionCache = {}
		sailingObstacleCache = {}
		sailingSeat = nil
	end
	recoverFullyVolcano = function(reason, forceReset)
		if recoveryInProgress or not Options.VolcanoFullyEvent.Value then return end
		recoveryInProgress = true
		hadActiveBoat = false
		releaseSailingControls()
		stopVolcanoMovement()
		notifyVolcano(reason .. " Resetando e retomando o Fully Volcano.")
		task.spawn(function()
			local oldCharacter = player.Character
			local humanoid = oldCharacter and oldCharacter:FindFirstChildOfClass("Humanoid")
			if forceReset and humanoid and humanoid.Health > 0 then
				pcall(function() oldCharacter:BreakJoints() end)
			end
			repeat
				task.wait(0.5)
				local character = player.Character
				local newHumanoid = character and character:FindFirstChildOfClass("Humanoid")
				if character and character ~= oldCharacter and character:FindFirstChild("HumanoidRootPart") and newHumanoid and newHumanoid.Health > 0 then
					break
				end
			until not Options.VolcanoFullyEvent.Value
			lastBoatPurchase = 0
			fullyIslandReached = false
			recoveryInProgress = false
		end)
	end
	local function applyFlyingBoatNoclip(boat, drivePart, direction)
		for _, object in ipairs(boat:GetDescendants()) do
			if object:IsA("BasePart") then
				if sailingCollisionCache[object] == nil then sailingCollisionCache[object] = object.CanCollide end
				object.CanCollide = false
			end
		end
		local params = OverlapParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = player.Character and {boat, player.Character} or {boat}
		params.MaxParts = 0
		local center = drivePart.Position + direction * 55
		local scan = CFrame.lookAt(center, center + direction)
		local seen = {}
		for _, part in ipairs(workspace:GetPartBoundsInBox(scan, Vector3.new(150, 150, 190), params)) do
			if part:IsA("BasePart") and part.Anchored and (part.CanCollide or sailingObstacleCache[part] ~= nil) and not part:IsDescendantOf(boat) then
				if sailingObstacleCache[part] == nil then sailingObstacleCache[part] = part.CanCollide end
				seen[part] = true
				part.CanCollide = false
			end
		end
		for part, oldValue in pairs(sailingObstacleCache) do
			if not part or not part.Parent then
				sailingObstacleCache[part] = nil
			elseif not seen[part] then
				pcall(function() part.CanCollide = oldValue end)
				sailingObstacleCache[part] = nil
			end
		end
	end
	local function getCompleteBoatFromSeat(seat)
		local boats = workspace:FindFirstChild("Boats")
		if not boats then return seat:FindFirstAncestorOfClass("Model") end
		local current = seat
		while current and current.Parent ~= boats do current = current.Parent end
		return current and current:IsA("Model") and current or seat:FindFirstAncestorOfClass("Model")
	end
	local function activeBoatDestroyed()
		if not sailingSeat or not sailingSeat.Parent or not sailingSeat:IsDescendantOf(workspace) then return true end
		local boat = getCompleteBoatFromSeat(sailingSeat)
		if not boat or not boat.Parent then return true end
		local health = boat:FindFirstChild("Health", true)
		if health and (health:IsA("NumberValue") or health:IsA("IntValue")) and health.Value <= 0 then return true end
		local humanoid = boat:FindFirstChildOfClass("Humanoid")
		return humanoid ~= nil and humanoid.Health <= 0
	end
	local function ensureFlyingBoatPhysics(seat, direction)
		local drivePart = seat.AssemblyRootPart or seat
		local boat = getCompleteBoatFromSeat(seat)
		if not boat then return nil end
		if not sailingAttachment or sailingAttachment.Parent ~= drivePart then
			for _, actuator in pairs({sailingVelocity, sailingOrientation, sailingAttachment}) do
				if actuator then pcall(function() actuator:Destroy() end) end
			end
			sailingAttachment = Instance.new("Attachment")
			sailingAttachment.Name = "IKARO_VolcanoBoatFlightAttachment"
			sailingAttachment.Parent = drivePart
			sailingVelocity = Instance.new("LinearVelocity")
			sailingVelocity.Attachment0 = sailingAttachment
			sailingVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
			sailingVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
			sailingVelocity.MaxForce = math.huge
			sailingVelocity.Parent = drivePart
			sailingOrientation = Instance.new("AlignOrientation")
			sailingOrientation.Attachment0 = sailingAttachment
			sailingOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
			sailingOrientation.RigidityEnabled = false
			sailingOrientation.Responsiveness = 35
			sailingOrientation.MaxTorque = math.huge
			sailingOrientation.Parent = drivePart
		end
		applyFlyingBoatNoclip(boat, drivePart, direction)
		return drivePart
	end
	local function sailForPrehistoricIsland()
		if recoveryInProgress then return end
		if hadActiveBoat and activeBoatDestroyed() then
			recoverFullyVolcano("Barco destruido.", true)
			return
		end
		local character, root = getCharacter()
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			recoverFullyVolcano("Personagem morreu.", false)
			return
		end
		local seat = findMyBoatSeat()
		if not seat then
			if hadActiveBoat then
				recoverFullyVolcano("Barco destruido.", true)
				return
			end
			-- Luxury Boat Dealer de Tiki; o servidor atual valida proximidade
			-- antes de aceitar BuyBoat.
			local boatDealer = CFrame.new(-16917.154296875, 7.757596015930176, 511.8203125)
			if (root.Position - boatDealer.Position).Magnitude > 80 then
				moveTo(boatDealer)
				return
			end
			if os.clock() - lastBoatPurchase >= 8 then
				lastBoatPurchase = os.clock()
				buyFullyBoat()
				notifyVolcano("Comprando " .. fullyBoatName .. " para procurar a ilha.")
			end
			return
		end
		if seat.Occupant ~= humanoid then
			moveTo(seat.CFrame * CFrame.new(0, 3, 0))
			pcall(function() seat:Sit(humanoid) end)
			task.wait(0.4)
			return
		end
		sailingSeat = seat
		hadActiveBoat = true
		seat.MaxSpeed = fullyBoatSpeed
		pcall(function() sethiddenproperty(player, "SimulationRadius", math.huge) end)
		local seaDirection = Vector3.new(-0.9999496936798096, 0, -0.010028315708041191)
		local drivePart = ensureFlyingBoatPhysics(seat, seaDirection)
		if not drivePart then return end
		local flightHeight = 70
		local verticalSpeed = math.clamp((flightHeight - drivePart.Position.Y) * 7, -140, 140)
		sailingVelocity.VectorVelocity = seaDirection * fullyBoatSpeed + Vector3.new(0, verticalSpeed, 0)
		sailingOrientation.CFrame = CFrame.lookAt(Vector3.zero, seaDirection, Vector3.yAxis)
		-- LinearVelocity e o motor nativo nao podem disputar a mesma assembly;
		-- essa disputa causava rollback (barco indo e voltando).
		pcall(function()
			seat.Throttle = 0
			seat.Steer = 0
		end)
	end

	Options.VolcanoFullyEvent:OnChanged(function(value)
		if value then
			fullyIslandReached = false
			hadActiveBoat = false
			recoveryInProgress = false
			notifyVolcano("Modo Fully iniciado.")
		else
			hadActiveBoat = false
			recoveryInProgress = false
			releaseSailingControls()
			fullyIslandReached = false
			Options.VolcanoFlyIsland:SetValue(false)
			Options.VolcanoFlyTrialDoor:SetValue(false)
			Options.VolcanoDefend:SetValue(false)
			Options.VolcanoAttackGolems:SetValue(false)
			Options.VolcanoCollectBone:SetValue(false)
			Options.VolcanoCollectEgg:SetValue(false)
			stopVolcanoMovement()
		end
	end)

	task.spawn(function()
		while task.wait(0.10) do
			if Options.VolcanoFullyEvent.Value then
				local island = getIsland()
				if not island then
					fullyIslandReached = false
					sailForPrehistoricIsland()
					if not Options.VolcanoFullyIgnoreMagnet.Value and os.clock() - lastMagnetCraft >= 20 then
						lastMagnetCraft = os.clock()
						craftVolcanicMagnet()
						notifyVolcano("Volcanic Magnet: pedido de craft enviado. Aguardando Prehistoric Island.")
					end
				else
					hadActiveBoat = false
					releaseSailingControls()
					if not fullyIslandReached then
						local skull = island:FindFirstChild("Skull", true)
						if skull and skull:IsA("BasePart") then
							fullyIslandReached = moveTo(skull.CFrame)
						end
					end
					if fullyIslandReached then
						local redRock = findRedRock(island)
						local golemActive = not redRock and hasLivingGolem()
						local bone = not redRock and not golemActive and island:FindFirstChild("DinoBone", true)
						local shouldCollectBone = bone ~= nil and not Options.VolcanoFullyIgnoreBone.Value
						Options.VolcanoDefend:SetValue(redRock ~= nil)
						Options.VolcanoAttackGolems:SetValue(golemActive)
						Options.VolcanoCollectBone:SetValue(shouldCollectBone)
						Options.VolcanoCollectEgg:SetValue(not redRock and not golemActive and not shouldCollectBone)
					end
				end
			end
		end
	end)
end

return Module
