--[[
    GHOST HUB V3 (FINAL)
    Funções: ESP, Speed, Fly, Noclip, Aimbot e WalkFling
    Atalho: RightShift
]]

local L_1 = Instance.new("ScreenGui")
local L_2 = Instance.new("Frame")
local L_3 = Instance.new("TextLabel")
local L_4 = Instance.new("ScrollingFrame")
local L_5 = Instance.new("UIListLayout")
local Close = Instance.new("TextButton")

L_1.Name = "GhostHubV3"
L_1.Parent = game.CoreGui
L_1.ResetOnSpawn = false

L_2.Name = "Main"
L_2.Parent = L_1
L_2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
L_2.BorderSizePixel = 0
L_2.Position = UDim2.new(0.5, -100, 0.5, -150)
L_2.Size = UDim2.new(0, 200, 0, 300)
L_2.Active = true

-- Sistema de Arrastar
local dragging, dragInput, dragStart, startPos
L_2.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = L_2.Position
    end
end)
L_2.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        L_2.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

L_3.Name = "Title"
L_3.Parent = L_2
L_3.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
L_3.Size = UDim2.new(1, 0, 0, 30)
L_3.Font = Enum.Font.GothamBold
L_3.Text = "GHOST HUB V3"
L_3.TextColor3 = Color3.fromRGB(255, 255, 255)
L_3.TextSize = 14

Close.Name = "Close"
Close.Parent = L_2
Close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Close.Position = UDim2.new(1, -25, 0, 5)
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.MouseButton1Click:Connect(function() L_1:Destroy() end)

L_4.Name = "Container"
L_4.Parent = L_2
L_4.BackgroundTransparency = 1
L_4.Position = UDim2.new(0, 5, 0, 35)
L_4.Size = UDim2.new(1, -10, 1, -40)
L_4.CanvasSize = UDim2.new(0, 0, 2, 0)
L_4.ScrollBarThickness = 2

L_5.Parent = L_4
L_5.SortOrder = Enum.SortOrder.LayoutOrder
L_5.Padding = UDim.new(0, 5)

local function CreateButton(txt, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = L_4
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Font = Enum.Font.SourceSans
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
end

local lp = game.Players.LocalPlayer
local flying = false
local noclip = false
local aimbot = false

-- 1. Velocidade
CreateButton("Velocidade (100)", function()
    lp.Character.Humanoid.WalkSpeed = 100
end)

-- 2. Fly Otimizado
CreateButton("Voo (Fly)", function()
    flying = not flying
    if flying then
        local bv = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                local cam = workspace.CurrentCamera
                local dir = Vector3.new(0,0,0)
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                bv.Velocity = dir * 60
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- 3. Noclip (Atravessar Paredes)
CreateButton("Noclip", function()
    noclip = not noclip
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

-- 4. Aimbot Suave (Trava no mais próximo)
CreateButton("Aimbot Suave", function()
    aimbot = not aimbot
    task.spawn(function()
        while aimbot do
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                    local d = (lp.Character.Head.Position - v.Character.Head.Position).Magnitude
                    if d < dist then
                        dist = d
                        target = v
                    end
                end
            end
            if target then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
            end
            task.wait()
        end
    end)
end)

-- 5. ESP
CreateButton("ESP Vermelho", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= lp and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- Toggle Menu
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
        L_2.Visible = not L_2.Visible
    end
end)
