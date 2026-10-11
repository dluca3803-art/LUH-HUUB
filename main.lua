-- LUH HUB | Versão com Tamanho Responsivo para Celular / Arceus X

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("LUH_HUB") then
    playerGui.LUH_HUB:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "LUH_HUB"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

----------------------------------------------------
-- PAINEL PRINCIPAL (Tamanho adaptável e seguro para mobile)
----------------------------------------------------
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 380, 0, 260) -- Levemente mais compacto para não estourar telas menores
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centralização exata com AnchorPoint
main.BackgroundColor3 = Color3.fromRGB(30, 27, 19)
main.BorderSizePixel = 0
main.Visible = true
main.Parent = gui

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255, 193, 55)
stroke.Thickness = 1.6

----------------------------------------------------
-- BARRA SUPERIOR
----------------------------------------------------
local top = Instance.new("Frame", main)
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 45)
top.BackgroundColor3 = Color3.fromRGB(255, 193, 48)
top.BorderSizePixel = 0

local topCorner = Instance.new("UICorner", top)
topCorner.CornerRadius = UDim.new(0, 14)

local cover = Instance.new("Frame", top)
cover.Size = UDim2.new(1, 0, 0, 14)
cover.Position = UDim2.new(0, 0, 1, -14)
cover.BackgroundColor3 = Color3.fromRGB(255, 193, 48)
cover.BorderSizePixel = 0

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1, -110, 0, 20)
title.Position = UDim2.new(0, 15, 0, 4)
title.BackgroundTransparency = 1
title.Text = "LUH HUB"
title.TextColor3 = Color3.fromRGB(39, 30, 12)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left

local subtitle = Instance.new("TextLabel", top)
subtitle.Size = UDim2.new(1, -110, 0, 14)
subtitle.Position = UDim2.new(0, 15, 0, 24)
subtitle.BackgroundTransparency = 1
subtitle.Text = "MM2 CONTROL CENTER"
subtitle.TextColor3 = Color3.fromRGB(91, 67, 24)
subtitle.Font = Enum.Font.SourceSans
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO FECHAR (X)
local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0, 24, 0, 24)
close.Position = UDim2.new(1, -32, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(230, 158, 34)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(45, 32, 12)
close.Font = Enum.Font.SourceSansBold
close.TextSize = 15

local closeCorner = Instance.new("UICorner", close)
closeCorner.CornerRadius = UDim.new(0, 6)

-- BOTÃO MINIMIZAR (-)
local minimize = Instance.new("TextButton", top)
minimize.Size = UDim2.new(0, 24, 0, 24)
minimize.Position = UDim2.new(1, -62, 0, 10)
minimize.BackgroundColor3 = Color3.fromRGB(230, 158, 34)
minimize.Text = "-"
minimize.TextColor3 = Color3.fromRGB(45, 32, 12)
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 16

local minCorner = Instance.new("UICorner", minimize)
minCorner.CornerRadius = UDim.new(0, 6)

----------------------------------------------------
-- ESTRUTURA DE ABAS
----------------------------------------------------
local tabsBarContainer = Instance.new("ScrollingFrame", main)
tabsBarContainer.Name = "TabsBar"
tabsBarContainer.Size = UDim2.new(1, -20, 0, 32)
tabsBarContainer.Position = UDim2.new(0, 10, 0, 52)
tabsBarContainer.BackgroundColor3 = Color3.fromRGB(20, 18, 13)
tabsBarContainer.BorderSizePixel = 0
tabsBarContainer.CanvasSize = UDim2.new(0, 420, 0, 0)
tabsBarContainer.ScrollBarThickness = 0

local tabsCorner = Instance.new("UICorner", tabsBarContainer)
tabsCorner.CornerRadius = UDim.new(0, 6)

local tabsLayout = Instance.new("UIListLayout", tabsBarContainer)
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Padding = UDim.new(0, 5)

local tabsPadding = Instance.new("UIPadding", tabsBarContainer)
tabsPadding.PaddingLeft = UDim.new(0, 5)
tabsPadding.PaddingTop = UDim.new(0, 4)

local pagesContainer = Instance.new("Frame", main)
pagesContainer.Name = "PagesContainer"
pagesContainer.Size = UDim2.new(1, -20, 1, -98)
pagesContainer.Position = UDim2.new(0, 10, 0, 90)
pagesContainer.BackgroundTransparency = 1

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 3
    page.Parent = pagesContainer

    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)

    return page
end

local pageSpeed = createPage()
local pageAvatar = createPage()
local pageToys = createPage()
local pageVisual = createPage()

-- FUNÇÃO PARA CRIAR BOTÕES TOGGLE (ON/OFF)
local function createToggle(parentPage, name, callback)
    local state = false

    local toggleBtn = Instance.new("TextButton", parentPage)
    toggleBtn.Size = UDim2.new(1, -4, 0, 32)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 20, 16)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""

    local tCorner = Instance.new("UICorner", toggleBtn)
    tCorner.CornerRadius = UDim.new(0, 6)

    local tStroke = Instance.new("UIStroke", toggleBtn)
    tStroke.Color = Color3.fromRGB(50, 42, 26)
    tStroke.Thickness = 1.2

    local label = Instance.new("TextLabel", toggleBtn)
    label.Size = UDim2.new(1, -100, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(240, 230, 200)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left

    local stateLabel = Instance.new("TextLabel", toggleBtn)
    stateLabel.Size = UDim2.new(0, 80, 1, 0)
    stateLabel.Position = UDim2.new(1, -90, 0, 0)
    stateLabel.BackgroundTransparency = 1
    stateLabel.Text = "● OFF"
    stateLabel.TextColor3 = Color3.fromRGB(130, 120, 100)
    stateLabel.Font = Enum.Font.SourceSansBold
    stateLabel.TextSize = 13
    stateLabel.TextXAlignment = Enum.TextXAlignment.Right

    toggleBtn.Activated:Connect(function()
        state = not state
        stateLabel.Text = state and "● ON" or "● OFF"
        stateLabel.TextColor3 = state and Color3.fromRGB(255, 193, 48) or Color3.fromRGB(130, 120, 100)
        tStroke.Color = state and Color3.fromRGB(255, 193, 48) or Color3.fromRGB(50, 42, 26)
        pcall(function()
            callback(state)
        end)
    end)
end

----------------------------------------------------
-- LÓGICAS DOS SCRIPTS (SPEED GLITCH)
----------------------------------------------------
local function enableSpeedOld()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/bitotoso/speed/refs/heads/main/script.lua"))()
    end)
end

local function disableSpeedOld()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end

----------------------------------------------------
-- LÓGICAS DOS SCRIPTS (AVATAR)
----------------------------------------------------
local korbloxBielConnections = {}

local function applyKorbloxBiel()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid", 5)

    if not hum or char:FindFirstChild("KorbloxFolder") then return end

    local folder = Instance.new("Folder", char)
    folder.Name = "KorbloxFolder"

    if hum.RigType == Enum.HumanoidRigType.R15 then
        local ru = char:WaitForChild("RightUpperLeg", 3)
        local rl = char:WaitForChild("RightLowerLeg", 3)
        local rf = char:WaitForChild("RightFoot", 3)
        if not (ru and rl and rf) then return end

        ru.Transparency = 1
        rl.Transparency = 1
        rf.Transparency = 1

        local korbloxPart = Instance.new("Part", folder)
        korbloxPart.Name = "KorbloxR15Visual"
        korbloxPart.Size = Vector3.new(1, 2, 1)
        korbloxPart.CanCollide = false
        korbloxPart.Massless = true

        local mesh = Instance.new("SpecialMesh", korbloxPart)
        mesh.MeshId = "rbxassetid://902942096"
        mesh.TextureId = "rbxassetid://902843398"
        mesh.Scale = Vector3.new(1, 1, 1)

        local weld = Instance.new("Weld", korbloxPart)
        weld.Part0 = ru
        weld.Part1 = korbloxPart
        weld.C0 = CFrame.new(0.1, 0.2, 0)

    elseif hum.RigType == Enum.HumanoidRigType.R6 then
        local rightLeg = char:WaitForChild("Right Leg", 3)
        if not rightLeg then return end

        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.RightLeg then
                v:Destroy()
            end
        end

        rightLeg.Transparency = 1

        local korbloxLeg = Instance.new("Part", folder)
        korbloxLeg.Name = "KorbloxR6Visual"
        korbloxLeg.Size = Vector3.new(1, 2, 1)
        korbloxLeg.CanCollide = false
        korbloxLeg.Massless = true

        local mesh = Instance.new("SpecialMesh", korbloxLeg)
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://101851696"
        mesh.TextureId = "rbxassetid://101851254"
        mesh.Scale = Vector3.new(1, 1, 1)

        local weld = Instance.new("Weld", korbloxLeg)
        weld.Part0 = rightLeg
        weld.Part1 = korbloxLeg
        weld.C0 = CFrame.new(0, 0, 0)
    end
end

local function korbloxBielOn()
    if player.Character then task.spawn(applyKorbloxBiel) end
    table.insert(korbloxBielConnections, player.CharacterAdded:Connect(function()
        task.wait(0.5)
        applyKorbloxBiel()
    end))
end

local function korbloxBielOff()
    for _, conn in ipairs(korbloxBielConnections) do
        pcall(function() conn:Disconnect() end)
    end
    korbloxBielConnections = {}

    local char = player.Character
    if char then
        local folder = char:FindFirstChild("KorbloxFolder")
        if folder then folder:Destroy() end

        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if hum.RigType == Enum.HumanoidRigType.R15 then
                for _, name in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
                    local part = char:FindFirstChild(name)
                    if part then part.Transparency = 0 end
                end
            elseif hum.RigType == Enum.HumanoidRigType.R6 then
                local rl = char:FindFirstChild("Right Leg")
                if rl then rl.Transparency = 0 end
            end
        end
    end
end

local headlessAtivo = false
local function setHeadless(character, state)
    local head = character:FindFirstChild("Head")
    if head then
        head.Transparency = state and 1 or 0
        if head:FindFirstChild("face") then
            head.face.Transparency = state and 1 or 0
        end
    end
end
local function aplicarHeadless()
    if player.Character then setHeadless(player.Character, headlessAtivo) end
end
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Head")
    task.wait(0.2)
    aplicarHeadless()
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        headlessAtivo = not headlessAtivo
        aplicarHeadless()
    end
end)

local bodyScaleAtivo = false
local bodyScaleConnection
local function applyBodyScale(character)
    if not character or not bodyScaleAtivo then return end
    local humanoid = character:WaitForChild("Humanoid", 10)
    if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R15 then return end
    humanoid.AutomaticScalingEnabled = false
    humanoid:WaitForChild("BodyHeightScale").Value = 1.0
    humanoid:WaitForChild("BodyWidthScale").Value  = 1.0
    humanoid:WaitForChild("BodyDepthScale").Value  = 0.8
    humanoid:WaitForChild("HeadScale").Value       = 1.0
    task.wait(0.2)
    humanoid.AutomaticScalingEnabled = true
end
local function resetBodyScale(character)
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R15 then return end
    humanoid.AutomaticScalingEnabled = false
    humanoid:WaitForChild("BodyHeightScale").Value = 1.0
    humanoid:WaitForChild("BodyWidthScale").Value  = 1.0
    humanoid:WaitForChild("BodyDepthScale").Value  = 1.0
    humanoid:WaitForChild("HeadScale").Value       = 1.0
    task.wait(0.2)
    humanoid.AutomaticScalingEnabled = true
end
local function enableBodyScale()
    bodyScaleAtivo = true
    if player.Character then applyBodyScale(player.Character) end
    if not bodyScaleConnection then
        bodyScaleConnection = player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            applyBodyScale(char)
        end)
    end
end
local function disableBodyScale()
    bodyScaleAtivo = false
    if bodyScaleConnection then
        bodyScaleConnection:Disconnect()
        bodyScaleConnection = nil
    end
    if player.Character then resetBodyScale(player.Character) end
end

----------------------------------------------------
-- LÓGICAS DOS SCRIPTS (TOYS / ITEMS)
----------------------------------------------------

-- 1. GRAVITY COIL
local gravityCoilActive = false
local gravityCoilConnection
local GRAVITY_REDUCTION = 0.75
local gravityConnections = {}

local function removeGravityEffect(p)
    local data = gravityConnections[p]
    if data then
        if data.connection then data.connection:Disconnect() end
        if data.heartbeat then data.heartbeat:Disconnect() end
        gravityConnections[p] = nil
    end
    local character = p.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local force = root:FindFirstChild("GravityCoilEffect")
            if force then force:Destroy() end
        end
    end
end

local function applyGravityEffect(p, tool)
    removeGravityEffect(p)
    local character = p.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    local force = Instance.new("BodyForce", root)
    force.Name = "GravityCoilEffect"
    force.Force = Vector3.new(0, root.AssemblyMass * workspace.Gravity * GRAVITY_REDUCTION, 0)

    local oldJumpPower = humanoid.JumpPower
    local oldJumpHeight = humanoid.JumpHeight
    local useJumpPower = humanoid.UseJumpPower

    if useJumpPower then humanoid.JumpPower = 75 else humanoid.JumpHeight = 18 end

    local connection
    local heartbeat

    connection = tool.Unequipped:Connect(function()
        if connection then connection:Disconnect() end
        if heartbeat then heartbeat:Disconnect() end
        if force then force:Destroy() end
        if humanoid and humanoid.Parent then
            if useJumpPower then humanoid.JumpPower = oldJumpPower else humanoid.JumpHeight = oldJumpHeight end
        end
        gravityConnections[p] = nil
    end)

    heartbeat = RunService.Heartbeat:Connect(function()
        if not tool.Parent or tool.Parent ~= character or not character.Parent or not humanoid.Parent or not root.Parent then
            removeGravityEffect(p)
            return
        end
        force.Force = Vector3.new(0, root.AssemblyMass * workspace.Gravity * GRAVITY_REDUCTION, 0)
    end)

    gravityConnections[p] = { connection = connection, heartbeat = heartbeat }
end

local function createGravityCoil()
    local tool = Instance.new("Tool")
    tool.Name = "Gravity Coil"
    tool.ToolTip = "Jump higher!"
    tool.CanBeDropped = false
    tool.RequiresHandle = true
    tool.TextureId = "rbxassetid://16619617"

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1.2, 2)
    handle.CanCollide = false
    handle.Massless = true

    local mesh = Instance.new("SpecialMesh", handle)
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://16606212"
    mesh.TextureId = "rbxassetid://16606141"
    mesh.Scale = Vector3.new(0.7, 0.7, 0.7)

    tool.Equipped:Connect(function() applyGravityEffect(player, tool) end)
    tool.Unequipped:Connect(function() removeGravityEffect(player) end)

    return tool
end

local function giveGravityCoil()
    if not gravityCoilActive then return end
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    if backpack and not backpack:FindFirstChild("Gravity Coil") and (not character or not character:FindFirstChild("Gravity Coil")) then
        createGravityCoil().Parent = backpack
    end
end

local function enableGravityCoil()
    gravityCoilActive = true
    giveGravityCoil()
    if not gravityCoilConnection then
        gravityCoilConnection = player.CharacterAdded:Connect(function()
            task.wait(0.6)
            giveGravityCoil()
        end)
    end
end

local function disableGravityCoil()
    gravityCoilActive = false
    if gravityCoilConnection then
        gravityCoilConnection:Disconnect()
        gravityCoilConnection = nil
    end
    removeGravityEffect(player)
    local backpack = player:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChild("Gravity Coil") then backpack["Gravity Coil"]:Destroy() end
    if player.Character and player.Character:FindFirstChild("Gravity Coil") then player.Character["Gravity Coil"]:Destroy() end
end

-- 2. SPEED COIL
local speedCoilActive = false
local function enableSpeedCoil()
    speedCoilActive = true
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZoeWarOnTop/Speed-coil/refs/heads/main/Speed-Coil"))()
    end)
end
local function disableSpeedCoil()
    speedCoilActive = false
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") and string.find(string.lower(item.Name), "speed") then item:Destroy() end
        end
    end
    if player.Character then
        for _, item in ipairs(player.Character:GetChildren()) do
            if item:IsA("Tool") and string.find(string.lower(item.Name), "speed") then item:Destroy() end
        end
    end
end

-- 3. WATERBALLOON
local waterballoonActive = false
local waterballoonConnections = {}
local waterballoonThread
local canThrowBalloon = true

local function createWaterballoonTool()
    if not waterballoonActive then return end
    local backpack = player:WaitForChild("Backpack", 5)
    if not backpack then return end

    if backpack:FindFirstChild("waterballoon") or (player.Character and player.Character:FindFirstChild("waterballoon")) then
        return
    end

    local tool = Instance.new("Tool")
    tool.Name = "waterballoon"
    tool.RequiresHandle = true
    tool.CanBeDropped = false
    tool.TextureId = "rbxassetid://89108586792149"
    tool.Grip = CFrame.new(0.2, 0, 0) * CFrame.Angles(0, 0, math.rad(90))

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(1.2, 1.2, 1.2)
    handle.CanCollide = false
    handle.CanTouch = false
    handle.CanQuery = false
    handle.Massless = true
    handle.Color = Color3.fromRGB(235, 64, 88)
    handle.Material = Enum.Material.SmoothPlastic

    local mesh = Instance.new("SpecialMesh", handle)
    mesh.MeshId = "rbxassetid://137510221029430"
    mesh.Scale = Vector3.new(0.45, 0.45, 0.45)

    local throwTrack
    local function loadAnimation()
        local character = player.Character
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://18324269091"
        pcall(function() throwTrack = animator:LoadAnimation(animation) end)
    end
    loadAnimation()

    tool.Activated:Connect(function()
        if not waterballoonActive or not canThrowBalloon or not tool.Parent then return end
        canThrowBalloon = false
        if not throwTrack then loadAnimation() end
        if throwTrack then pcall(function() throwTrack:Play() end) end
        task.wait(0.6)
        if handle and handle.Parent then handle.Transparency = 1 end
        task.wait(math.max(0, 2.5 - 0.6))
        if handle and handle.Parent then handle.Transparency = 0 end
        canThrowBalloon = true
    end)

    tool.Parent = backpack
end

local function enableWaterballoon()
    waterballoonActive = true
    canThrowBalloon = true
    createWaterballoonTool()

    table.insert(waterballoonConnections, player.CharacterAdded:Connect(function()
        task.wait(1)
        if not waterballoonActive then return end
        canThrowBalloon = true
        createWaterballoonTool()
    end))

    waterballoonThread = task.spawn(function()
        while waterballoonActive do
            task.wait(2)
            if not waterballoonActive then break end
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local hasTool = backpack:FindFirstChild("waterballoon") or (player.Character and player.Character:FindFirstChild("waterballoon"))
                if not hasTool then createWaterballoonTool() end
            end
        end
    end)
end

local function disableWaterballoon()
    waterballoonActive = false
    canThrowBalloon = true
    for _, conn in ipairs(waterballoonConnections) do
        pcall(function() conn:Disconnect() end)
    end
    waterballoonConnections = {}
    if waterballoonThread then
        task.cancel(waterballoonThread)
        waterballoonThread = nil
    end

    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        local item = backpack:FindFirstChild("waterballoon")
        if item then item:Destroy() end
    end
    if player.Character then
        local item = player.Character:FindFirstChild("waterballoon")
        if item then item:Destroy() end
    end
end

-- 4. SNOWBALL
local snowballActive = false
local snowballConnections = {}

local function createSnowballTool()
    if not snowballActive then return end
    local backpack = player:WaitForChild("Backpack", 5)
    if not backpack then return end

    if backpack:FindFirstChild("Snowball2020") or (player.Character and player.Character:FindFirstChild("Snowball2020")) then
        return
    end

    local tool = Instance.new("Tool")
    tool.Name = "Snowball2020"
    tool.RequiresHandle = true
    tool.CanBeDropped = false
    tool.TextureId = "rbxassetid://123812553371268"
    tool.Grip = CFrame.new(0, -0.2, 0) * CFrame.Angles(0, math.rad(90), 0)

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(1.1, 1.1, 1.1)
    handle.Shape = Enum.PartType.Ball
    handle.Color = Color3.fromRGB(250, 250, 250)
    handle.Material = Enum.Material.SmoothPlastic
    handle.CanCollide = false

    local throwTrack = nil
    local function loadAnimationTrack()
        local character = player.Character
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid
            local throwAnimation = Instance.new("Animation")
            throwAnimation.AnimationId = "rbxassetid://18324269091"
            pcall(function()
                throwTrack = animator:LoadAnimation(throwAnimation)
            end)
        end
    end

    loadAnimationTrack()

    tool.Activated:Connect(function()
        if not snowballActive then return end
        if throwTrack then
            throwTrack:Play()
        else
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid
                    local throwAnimation = Instance.new("Animation")
                    throwAnimation.AnimationId = "rbxassetid://18324269091"
                    local tempTrack = animator:LoadAnimation(throwAnimation)
                    tempTrack:Play()
                end
            end
        end
    end)

    tool.Parent = backpack
end

local function enableSnowball()
    snowballActive = true
    createSnowballTool()

    table.insert(snowballConnections, player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if not snowballActive then return end
        createSnowballTool()
    end))
end

local function disableSnowball()
    snowballActive = false
    for _, conn in ipairs(snowballConnections) do
        pcall(function() conn:Disconnect() end)
    end
    snowballConnections = {}

    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        local item = backpack:FindFirstChild("Snowball2020")
        if item then item:Destroy() end
    end
    if player.Character then
        local item = player.Character:FindFirstChild("Snowball2020")
        if item then item:Destroy() end
    end
end

----------------------------------------------------
-- REGISTRO DOS BOTÕES
----------------------------------------------------
createToggle(pageSpeed, "SPEED OLD", function(state)
    if state then enableSpeedOld() else disableSpeedOld() end
end)

createToggle(pageAvatar, "KORBLOX", function(state)
    if state then korbloxBielOn() else korbloxBielOff() end
end)

createToggle(pageAvatar, "HEADLESS (TECLA H)", function(state)
    headlessAtivo = state
    aplicarHeadless()
end)

createToggle(pageAvatar, "BODY SCALE (BODY OLD)", function(state)
    if state then enableBodyScale() else disableBodyScale() end
end)

createToggle(pageAvatar, "ANIMATION OLD", function(state)
    if state then game.Workspace.Retargeting = Enum.AnimatorRetargetingMode.Disabled else game.Workspace.Retargeting = Enum.AnimatorRetargetingMode.Default end
end)

createToggle(pageToys, "GRAVITY COIL", function(state)
    if state then enableGravityCoil() else disableGravityCoil() end
end)

createToggle(pageToys, "SPEED COIL", function(state)
    if state then enableSpeedCoil() else disableSpeedCoil() end
end)

createToggle(pageToys, "WATERBALLOON", function(state)
    if state then enableWaterballoon() else disableWaterballoon() end
end)

createToggle(pageToys, "SNOWBALL", function(state)
    if state then enableSnowball() else disableSnowball() end
end)

----------------------------------------------------
-- CRIAÇÃO DAS ABAS NO TOPO
----------------------------------------------------
local function createTab(name, order, targetPage)
    local tabBtn = Instance.new("TextButton", tabsBarContainer)
    tabBtn.Size = UDim2.new(0, 95, 0, 24)
    tabBtn.BackgroundColor3 = Color3.fromRGB(45, 38, 24)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(200, 190, 160)
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 11
    tabBtn.LayoutOrder = order

    local tCorner = Instance.new("UICorner", tabBtn)
    tCorner.CornerRadius = UDim.new(0, 5)

    return tabBtn, targetPage
end

local t1, p1 = createTab("SPEED GLITCH", 1, pageSpeed)
local t2, p2 = createTab("AVATAR", 2, pageAvatar)
local t3, p3 = createTab("TOYS / ITEMS", 3, pageToys)
local t4, p4 = createTab("VISUAL", 4, pageVisual)

local tabsList = {
    {btn = t1, page = p1},
    {btn = t2, page = p2},
    {btn = t3, page = p3},
    {btn = t4, page = p4}
}

local function selectTab(selectedTab)
    for _, item in ipairs(tabsList) do
        if item.btn == selectedTab.btn then
            item.btn.BackgroundColor3 = Color3.fromRGB(255, 193, 48)
            item.btn.TextColor3 = Color3.fromRGB(45, 32, 12)
            item.page.Visible = true
        else
            item.btn.BackgroundColor3 = Color3.fromRGB(45, 38, 24)
            item.btn.TextColor3 = Color3.fromRGB(200, 190, 160)
            item.page.Visible = false
        end
    end
end

for _, item in ipairs(tabsList) do
    item.btn.Activated:Connect(function() selectTab(item) end)
end

selectTab(tabsList[1])

----------------------------------------------------
-- BOTÃO FLUTUANTE (CAIXINHA ARRASTÁVEL)
----------------------------------------------------
local openButton = Instance.new("TextButton", gui)
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 170, 0, 38)
openButton.Position = UDim2.new(0.05, 0, 0.4, 0)
openButton.BackgroundColor3 = Color3.fromRGB(22, 20, 16)
openButton.Text = ""
openButton.Visible = false

local openCorner = Instance.new("UICorner", openButton)
openCorner.CornerRadius = UDim.new(1, 0)

local openStroke = Instance.new("UIStroke", openButton)
openStroke.Color = Color3.fromRGB(255, 193, 55)
openStroke.Thickness = 1.5

local iconCircle = Instance.new("Frame", openButton)
iconCircle.Size = UDim2.new(0, 30, 0, 30)
iconCircle.Position = UDim2.new(0, 4, 0.5, -15)
iconCircle.BackgroundColor3 = Color3.fromRGB(255, 193, 48)
iconCircle.BorderSizePixel = 0

local circleCorner = Instance.new("UICorner", iconCircle)
circleCorner.CornerRadius = UDim.new(1, 0)

local iconText = Instance.new("TextLabel", iconCircle)
iconText.Size = UDim2.new(1, 0, 1, 0)
iconText.BackgroundTransparency = 1
iconText.Text = "LUH"
iconText.TextColor3 = Color3.fromRGB(39, 30, 12)
iconText.Font = Enum.Font.SourceSansBold
iconText.TextSize = 12

local openTitle = Instance.new("TextLabel", openButton)
openTitle.Size = UDim2.new(0, 120, 0, 16)
openTitle.Position = UDim2.new(0, 40, 0, 4)
openTitle.BackgroundTransparency = 1
openTitle.Text = "LUH HUB"
openTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
openTitle.Font = Enum.Font.SourceSansBold
openTitle.TextSize = 13
openTitle.TextXAlignment = Enum.TextXAlignment.Left

local openSubtitle = Instance.new("TextLabel", openButton)
openSubtitle.Size = UDim2.new(0, 120, 0, 12)
openSubtitle.Position = UDim2.new(0, 40, 0, 20)
openSubtitle.BackgroundTransparency = 1
openSubtitle.Text = "TOQUE PARA ABRIR"
openSubtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
openSubtitle.Font = Enum.Font.SourceSans
openSubtitle.TextSize = 9
openSubtitle.TextXAlignment = Enum.TextXAlignment.Left

----------------------------------------------------
-- CONTROLES E SISTEMA DE ARRASTAR
----------------------------------------------------
close.Activated:Connect(function()
    main.Visible = false
    openButton.Visible = true
end)

minimize.Activated:Connect(function()
    main.Visible = false
    openButton.Visible = true
end)

openButton.Activated:Connect(function()
    main.Visible = true
    openButton.Visible = false
end)

local function setupDraggable(dragFrame, parentFrame)
    local dragging = false
    local dragStart, startPos, dragInput

    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = parentFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end    
    end)

    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            parentFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

setupDraggable(top, main)
setupDraggable(openButton, openButton)
