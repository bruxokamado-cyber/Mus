local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- JANELA DE KEY
local KeyWindow = Rayfield:CreateWindow({
   Name = "👻 Ghostzin Hub | Sistema de Chave",
   LoadingTitle = "Verificando Acesso...",
   ConfigurationSaving = {Enabled = false}
})

local KeyTab = KeyWindow:CreateTab("Acesso", 4483362458)
local KeyInserida = ""

KeyTab:CreateInput({
   Name = "Insira a Key",
   PlaceholderText = "A chave está no Discord!",
   Callback = function(Text) KeyInserida = Text end,
})

KeyTab:CreateButton({
   Name = "Verificar Chave",
   Callback = function()
      if KeyInserida == "ghostzin" then
         Rayfield:Notify({Title = "Sucesso!", Content = "Acesso liberado! Carregando menu..."})
         task.wait(1)
         KeyWindow:Destroy()

         -- MENU PRINCIPAL (Abre após a Key correta)
         local MainWin = Rayfield:CreateWindow({
            Name = "👻 Ghostzin Hub | Premium Edition",
            LoadingTitle = "Ghostzin Hub Iniciado",
            ConfigurationSaving = {Enabled = true, FolderName = "GhostzinConfig"}
         })

         local lp = game.Players.LocalPlayer
         local flyEnabled, noclip, flySpeed = false, false, 50

         -- ABAS
         local MainTab = MainWin:CreateTab("Movimento", 4483362458)
         local VisualTab = MainWin:CreateTab("Visuais", 4483362458)
         local ServerTab = MainWin:CreateTab("Morph/Skin", 4483362458)

         -- MOVIMENTAÇÃO (FLY, SPEED, NOCLIP, JUMP)
         MainTab:CreateToggle({
            Name = "Ativar Fly (Voo)",
            CurrentValue = false,
            Callback = function(v)
               flyEnabled = v
               if flyEnabled then
                  local hrp = lp.Character.HumanoidRootPart
                  local bv = Instance.new("BodyVelocity", hrp)
                  bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                  bv.Name = "GhostFly"
                  local bg = Instance.new("BodyGyro", hrp)
                  bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                  bg.Name = "GhostGyro"
                  spawn(function()
                     while flyEnabled do
                        bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                        bg.CFrame = workspace.CurrentCamera.CFrame
                        task.wait()
                     end
                     bv:Destroy() bg:Destroy()
                  end)
               end
            end,
         })

         MainTab:CreateSlider({
            Name = "Velocidade do Fly",
            Range = {10, 500},
            Increment = 1,
            CurrentValue = 50,
            Callback = function(v) flySpeed = v end,
         })

         MainTab:CreateToggle({
            Name = "Ativar Noclip",
            CurrentValue = false,
            Callback = function(v)
               noclip = v
               game:GetService("RunService").Stepped:Connect(function()
                  if noclip and lp.Character then
                     for _, part in pairs(lp.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                     end
                  end
               end)
            end,
         })

         MainTab:CreateSlider({
            Name = "Velocidade (Speed)",
            Range = {16, 500},
            Increment = 1,
            CurrentValue = 16,
            Callback = function(v) lp.Character.Humanoid.WalkSpeed = v end,
         })

         -- VISUAIS
         VisualTab:CreateToggle({
            Name = "ESP Players (Highlight)",
            CurrentValue = false,
            Callback = function(state)
               for _, v in pairs(game.Players:GetPlayers()) do
                  if v ~= lp and v.Character then
                     if state then
                        local hl = Instance.new("Highlight", v.Character)
                        hl.Name = "GhostESP"
                        hl.FillColor = Color3.fromRGB(170, 0, 255)
                     else
                        if v.Character:FindFirstChild("GhostESP") then v.Character.GhostESP:Destroy() end
                     end
                  end
               end
            end,
         })

         -- SERVER/MORPH
         ServerTab:CreateInput({
            Name = "Trocar Skin (ID)",
            PlaceholderText = "Digite o ID do catálogo",
            Callback = function(t)
               if game.ReplicatedStorage:FindFirstChild("MorphEvent") then
                  game.ReplicatedStorage.MorphEvent:FireServer(tonumber(t))
               end
            end,
         })

      else
         Rayfield:Notify({Title = "Erro!", Content = "Chave incorreta! Pegue a key no Discord."})
      end
   end,
})

-- BOTÃO DO DISCORD
KeyTab:CreateButton({
   Name = "Copiar Link do Discord",
   Callback = function()
      setclipboard("https://discord.gg/bNhsfUTQP")
      Rayfield:Notify({Title = "Copiado!", Content = "O link do Discord foi copiado para sua área de transferência."})
   end,
})
