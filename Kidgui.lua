-- ====================================================================
-- KIDGUI SYSTEM & ONIX HUB (VERSIÓN DE PRODUCCIÓN)
-- Desarrollado por: Kid00s Hacker 💻
-- Compatibility: Delta Executor (Mobile & PC)
-- ====================================================================

-- 1. CARGA DE LA LIBRERÍA VISUAL (Espejo optimizado para evitar cargas en blanco)
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- 2. VARIABLES DE CONFIGURACIÓN Y JUGADOR
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ClaveAcceso = "kid00s_onix" -- Tu llave secreta

local function GetCharacter() return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() end
local function GetHumanoid() return GetCharacter():WaitForChild("Humanoid") end
local function GetRootPart() return GetCharacter():WaitForChild("HumanoidRootPart") end

-- Variables de control para evitar bugs de bucles infinitos
_G.NoVisualer = false
_G.ChatSpam = false
_G.RepulsiveShield = false
_G.GlitchSound = false

-- ====================================================================
-- FASE 1: VENTANA DEL SISTEMA DE LLAVES (KEY GUI)
-- ====================================================================
local KeyWindow = OrionLib:MakeWindow({
    Name = "KidGUI | By Kid00s Hacker 💻",
    HidePremium = true,
    SaveConfig = false,
    ConfigFolder = "Kid00sKeySystem"
})

local TabKey = KeyWindow:MakeTab({
    Name = "Hacker Access",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TabKey:AddLabel("🔒 SISTEMA DE SEGURIDAD ACTIVADO")
TabKey:AddLabel("Desarrollado por: Kid00s Hacker")

-- Función del menú principal (declarada antes para que la Textbox la reconozca)
local function CargarMenuPrincipal()
    local Window = OrionLib:MakeWindow({
        Name = "Onix Hub | By Kid00s Hacker 💻",
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "Kid00sOnixHub"
    })

    -- 📑 PESTAÑA: HACKS JUGADOR
    local TabJugador = Window:MakeTab({ 
        Name = "Hacks Jugador",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false 
    })

    TabJugador:AddSlider({
        Name = "Velocidad Hack (WalkSpeed)",
        Min = 16,
        Max = 500,
        Default = 16,
        Color = Color3.fromRGB(255,255,255),
        Increment = 1,
        ValueName = "Speed",
        Callback = function(Value) pcall(function() GetHumanoid().WalkSpeed = Value end) end
    })

    TabJugador:AddSlider({
        Name = "Súper Salto (JumpPower)",
        Min = 50,
        Max = 500,
        Default = 50,
        Color = Color3.fromRGB(255,255,255),
        Increment = 1,
        ValueName = "Power",
        Callback = function(Value) pcall(function() local hum = GetHumanoid() hum.UseJumpPower = true hum.JumpPower = Value end) end
    })

    -- 📑 PESTAÑA: HACKER TOOLS 💀
    local TabExclusiva = Window:MakeTab({ 
        Name = "Hacker Tools 💀",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false 
    })

    -- 1. No Visualer (Potato Graphics)
    TabExclusiva:AddToggle({
        Name = "No Visualer (Lag & Potato Graphics)",
        Default = false,
        Callback = function(Value)
            _G.NoVisualer = Value
            if _G.NoVisualer then
                task.spawn(function()
                    while _G.NoVisualer do
                        pcall(function()
                            local terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
                            if terrain then 
                                terrain.WaterWaveSize = 0 
                                terrain.WaterWaveSpeed = 0 
                                terrain.WaterReflectance = 0 
                                terrain.WaterTransparency = 0 
                            end
                            game:GetService("Lighting").GlobalShadows = false
                            game:GetService("Lighting").FogEnd = 9e9
                            
                            for _, obj in pairs(game:GetDescendants()) do
                                if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                                    obj.Material = Enum.Material.SmoothPlastic
                                    obj.Color = Color3.fromRGB(100, 100, 100)
                                elseif obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("Sky") or obj:IsA("PostEffect") or obj:IsA("Atmosphere") or obj:IsA("Clouds") then
                                    obj:Destroy()
                                end
                            end
                        end)
                        task.wait(5)
                    end
                end)
            end
        end
    })

    -- 2. Chat Spammer
    TabExclusiva:AddToggle({
        Name = "Spam: Kid00s System Error",
        Default = false,
        Callback = function(Value)
            _G.ChatSpam = Value
            while _G.ChatSpam do
                local TextChatService = game:GetService("TextChatService")
                if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                    pcall(function() TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage("[SYSTEM ERROR]: Server corrupted by Kid00s Hacker.") end)
                else
                    pcall(function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⚠️ [KidGUI ALERT]: System Bypass by Kid00s.", "All") end)
                end
                task.wait(4)
            end
        end
    })

    -- 3. Escudo Repulsivo (Anti-Touch)
    TabExclusiva:AddToggle({
        Name = "Escudo Repulsivo (Anti-Touch)",
        Default = false,
        Callback = function(Value)
            _G.RepulsiveShield = Value
            while _G.RepulsiveShield do
                pcall(function()
                    local MyRoot = GetRootPart()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local TheirRoot = player.Character.HumanoidRootPart
                            if (MyRoot.Position - TheirRoot.Position).Magnitude < 10 then
                                TheirRoot.AssemblyLinearVelocity = (TheirRoot.Position - MyRoot.Position).Unit * 150
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end
    end)

    -- 4. Modificar Gravedad
    TabExclusiva:AddSlider({
        Name = "Gravedad del Mundo (Gravity Hack)",
        Min = 0,
        Max = 196.2,
        Default = 196.2,
        Color = Color3.fromRGB(255,255,255),
        Increment = 1,
        ValueName = "Gravity",
        Callback = function(Value) game:GetService("Workspace").Gravity = Value end
    })

    -- 5. Controlador de Tiempo Visual
    TabExclusiva:AddSlider({
        Name = "Modificar Hora del Día (Client Time)",
        Min = 0,
        Max = 24,
        Default = 12,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.5,
        ValueName = "Hora",
        Callback = function(Value) game:GetService("Lighting").ClockTime = Value end
    })

    -- 6. Sonido Alerta Glitch
    local ActiveSound = nil
    TabExclusiva:AddToggle({
        Name = "Sonido de Alerta Glitch (Troll)",
        Default = false,
        Callback = function(Value)
            _G.GlitchSound = Value
            if _G.GlitchSound then
                ActiveSound = Instance.new("Sound", game:GetService("Workspace"))
                ActiveSound.SoundId = "rbxassetid://138090414"
                ActiveSound.Volume = 2
                ActiveSound.Looped = true
                ActiveSound:Play()
            else
                if ActiveSound then ActiveSound:Destroy() end
                for _, obj in pairs(game:GetService("Workspace"):GetChildren()) do
                    if obj:IsA("Sound") and obj.SoundId == "rbxassetid://138090414" then obj:Destroy() end
                end
            end
        end
    end)

    OrionLib:Init()
end

-- Caja de Texto de Seguridad
TabKey:AddTextbox({
    Name = "Introduce la clave de acceso:",
    Default = "",
    TextDisappear = true,
    Callback = function(TextoIntroducido)
        if TextoIntroducido == ClaveAcceso then
            OrionLib:MakeNotification({
                Name = "SISTEMA CONCEDIDO",
                Content = "Bienvenido",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            task.wait(1)
            OrionLib:Destroy()
            task.wait(0.5)
            CargarMenuPrincipal()
        else
            OrionLib:MakeNotification({
                Name = "ACCESO DENEGADO",
                Content = "Clave incorrecta.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end
})

OrionLib:Init()
