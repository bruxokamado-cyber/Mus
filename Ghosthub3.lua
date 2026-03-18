local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local RunService = game:GetService("RunService")

-- =========================
-- 📦 "MÓDULOS" (tipo scripts separados)
-- =========================

local Modules = {}

-- 🕊️ FLY MODULE
Modules.Fly = {
	Enabled = false,
	Connection = nil,
	BodyVelocity = nil
}

function Modules.Fly:Start()
	if self.Enabled then return end
	self.Enabled = true
	
	self.BodyVelocity = Instance.new("BodyVelocity")
	self.BodyVelocity.MaxForce = Vector3.new(1,1,1)*100000
	self.BodyVelocity.Parent = root
	
	self.Connection = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		self.BodyVelocity.Velocity = cam.CFrame.LookVector * 50
	end)
end

function Modules.Fly:Stop()
	if not self.Enabled then return end
	self.Enabled = false
	
	if self.Connection then
		self.Connection:Disconnect()
	end
	
	if self.BodyVelocity then
		self.BodyVelocity:Destroy()
	end
end

-- ⚡ SPEED MODULE
Modules.Speed = {
	Enabled = false,
	Value = 16
}

function Modules.Speed:Start()
	self.Enabled = true
	humanoid.WalkSpeed = self.Value
end

function Modules.Speed:Stop()
	self.Enabled = false
	humanoid.WalkSpeed = 16
end

-- 🧗 WALL MODULE
Modules.Wall = {
	Enabled = false,
	Connection = nil
}

function Modules.Wall:Start()
	if self.Enabled then return end
	self.Enabled = true
	
	self.Connection = RunService.Stepped:Connect(function()
		root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
	end)
end

function Modules.Wall:Stop()
	if not self.Enabled then return end
	self.Enabled = false
	
	if self.Connection then
		self.Connection:Disconnect()
	end
end

-- =========================
-- 📱 GUI
-- =========================

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

local function createButton(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,150,0,50)
	btn.Position = UDim2.new(0,10,0,y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Parent = gui
	return btn
end

local flyBtn = createButton("Fly OFF", 10)
local speedBtn = createButton("Speed OFF", 70)
local wallBtn = createButton("Wall OFF", 130)

-- =========================
-- 🔘 BOTÕES (liga/desliga tipo script separado)
-- =========================

flyBtn.MouseButton1Click:Connect(function()
	if Modules.Fly.Enabled then
		Modules.Fly:Stop()
		flyBtn.Text = "Fly OFF"
	else
		Modules.Fly:Start()
		flyBtn.Text = "Fly ON"
	end
end)

speedBtn.MouseButton1Click:Connect(function()
	if Modules.Speed.Enabled then
		Modules.Speed:Stop()
		speedBtn.Text = "Speed OFF"
	else
		Modules.Speed:Start()
		speedBtn.Text = "Speed ON"
	end
end)

wallBtn.MouseButton1Click:Connect(function()
	if Modules.Wall.Enabled then
		Modules.Wall:Stop()
		wallBtn.Text = "Wall OFF"
	else
		Modules.Wall:Start()
		wallBtn.Text = "Wall ON"
	end
end)
