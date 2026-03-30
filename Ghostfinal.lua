local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "👻 GHOST HUB | V1.0",
   LoadingTitle = "Iniciando Ghost Hub...",
   LoadingSubtitle = "por SeuNome",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
   KeySettings = {
      Title = "Sistema de Chave",
      Subtitle = "Link: discord.gg/ghosthub",
      Note = "🔑 Chave dura 48h | 🎁 +30min para Delta Users",
      FileName = "GhostKey",
      SaveKey = true, -- Salva a chave no PC por 48h (padrão do arquivo)
      GrabKeyFromSite = false,
      Key = {"nobru"} 
   }
})

-- [ LÓGICA DE EXECUTOR (DELTA) ] --
-- Verifica se o usuário está no Delta para exibir o bônus na notificação
local isDelta = (identifyexecutor and string.find(string.lower(identifyexecutor()), "delta")) and true or false

-- [ AUTO ANTI-AFK ] --
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    Rayfield:Notify({Title = "Ghost Anti-AFK", Content = "Movimento fantasma executado!"})
end)

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

--- [ ABA MOVIMENTO ] ---
local MainTab = Window:CreateTab("Movimento", 4483362458)
local FlySpeed = 50
local Flying = false

MainTab:CreateSlider({
   Name = "Velocidade",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) Character.Humanoid.WalkSpeed = v end,
})

MainTab:CreateToggle({
   Name = "Ativar Fly (Vôo)",
   CurrentValue = false,
   Callback = function(v)
      Flying = v
      if Flying then
         local bv = Instance.new("BodyVelocity", Character.HumanoidRootPart)
         bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
         bv.Name = "FlyForce"
         task.spawn(function()
            while Flying do
               bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * FlySpeed
               task.wait()
            end
            bv:Destroy()
         end)
      end
   end,
})

--- [ ABA TROLL & VISUAL ] ---
local TrollTab = Window:CreateTab("Troll & Ban", 4483362458)

TrollTab:CreateButton({
   Name = "Copiar Link Discord",
   Callback = function()
      setclipboard("https://discord.gg")
      Rayfield:Notify({Title = "Discord", Content = "Link copiado para a área de transferência!"})
   end,
})

TrollTab:CreateButton({
   Name = "Visual Ban All (Sumiço)",
   Callback = function()
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= Player then v:Destroy() end
      end
   end,
})

TrollTab:CreateButton({
   Name = "Ban Me (Fake Kick)",
   Callback = function()
      Player:Kick("Ghost Hub: Banimento Simulado.")
   end,
})

TrollTab:CreateButton({
   Name = "Bang (Animação)",
   Callback = function()
      local anim = Instance.new("Animation")
      anim.AnimationId = "rbxassetid://148840338"
      Character.Humanoid:LoadAnimation(anim):Play()
   end,
})

--- [ ABA STATUS ] ---
local StatusTab = Window:CreateTab("Status", 4483362458)

StatusTab:CreateToggle({
   Name = "Ficar Invisível (Local)",
   CurrentValue = false,
   Callback = function(v)
      local t = v and 1 or 0
      for _, p in pairs(Character:GetDescendants()) do
         if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = t end
      end
   end,
})

StatusTab:CreateButton({
   Name = "Ativar ESP",
   Callback = function()
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= Player and v.Character then
            local h = v.Character:FindFirstChild("Highlight") or Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromRGB(255, 255, 255)
         end
      end
   end,
})

--- [ ABA TELEPORTE ] ---
local TPTab = Window:CreateTab("Teleporte", 4483362458)
local TargetName = ""

TPTab:CreateInput({
   Name = "Nick do Jogador",
   PlaceholderText = "Nome...",
   Callback = function(t) TargetName = t end,
})

TPTab:CreateButton({
   Name = "Ir até Jogador",
   Callback = function()
      for _, v in pairs(game.Players:GetPlayers()) do
         if string.find(string.lower(v.Name), string.lower(TargetName)) then
            Character:MoveTo(v.Character.HumanoidRootPart.Position)
         end
      end
   end,
})

-- Notificação Final com bônus Delta
local msg = isDelta and "Sessão: 48h e 30min (Delta Bonus!)" or "Sessão: 48 horas"
Rayfield:Notify({Title = "GHOST HUB ATIVO", Content = msg})
