--------------------------------------------------------------------------------
-- PHẦN 1: ANIMATION (Thanh tiến trình, rung, mờ dần)
--------------------------------------------------------------------------------

-- Lấy các service cần thiết
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui cho animation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnyaAnimationGUI"
screenGui.Parent = playerGui

-- Tạo bảng (Frame) để chứa thanh tiến trình và tiêu đề
local animationFrame = Instance.new("Frame")
animationFrame.Parent = screenGui
animationFrame.Size = UDim2.new(0, 400, 0, 150)
animationFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
animationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
animationFrame.BorderSizePixel = 0

-- Tiêu đề
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = animationFrame
titleLabel.Size = UDim2.new(0, 200, 0, 30)
titleLabel.Position = UDim2.new(0.5, -100, 0.2, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "anya blox trái cây"
titleLabel.TextColor3 = Color3.new(0, 1, 1)
titleLabel.TextScaled = true

-- Thanh tiến trình
local progressBar = Instance.new("Frame")
progressBar.Parent = animationFrame
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBar.BorderSizePixel = 0
-- Bắt đầu ở 10% chiều rộng của khung, cao 25px
progressBar.Position = UDim2.new(0.1, 0, 0.6, 0)
-- Ban đầu width = 0
progressBar.Size = UDim2.new(0, 0, 0, 25)

-- Thêm hiệu ứng gradient cho thanh tiến trình
local progressUIGradient = Instance.new("UIGradient")
progressUIGradient.Parent = progressBar
progressUIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
})

-- Hiệu ứng thanh tiến trình chạy từ 0% đến 100% trong 5 giây
local totalDuration = 5  -- thời gian chạy (giây)
local steps = 100        -- số bước cập nhật

for i = 0, steps do
    local p = i / steps
    -- Thanh sẽ chiếm tối đa 80% chiều rộng khung (từ 10% đến 90%)
    progressBar.Size = UDim2.new(0.8 * p, 0, 0, 25)
    wait(totalDuration / steps)
end

-- Hiệu ứng rung nhẹ (shake) khi đạt 100%
local originalPos = animationFrame.Position
for i = 1, 10 do
    animationFrame.Position = originalPos + UDim2.new(0, math.random(-5, 5), 0, math.random(-5, 5))
    wait(0.05)
end
-- Trả lại vị trí cũ
animationFrame.Position = originalPos

-- Hiệu ứng mờ dần (fade out) rồi biến mất
for alpha = 0, 1, 0.1 do
    animationFrame.BackgroundTransparency = alpha
    titleLabel.TextTransparency = alpha
    progressBar.BackgroundTransparency = alpha
    wait(0.1)
end
animationFrame:Destroy()
screenGui:Destroy()

--------------------------------------------------------------------------------
-- PHẦN 2: TẠO GIAO DIỆN (FLUENT, SAVEMANAGER, TAB, ...)
--------------------------------------------------------------------------------

local successFluent, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Tubo-lite/refs/heads/main/Haidepzai"))()
end)

local successSaveManager, SaveManager = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()
end)

if not successFluent or not successSaveManager then
    warn("Failed to load Fluent or SaveManager. Check URLs or network connection.")
    return
end

local successWindow, Window = pcall(MakeWindow, {
    Hub = {
        Title = "Anya Blox Trái Cây",
        Animation = "anya blox trai cay"
    },
    Key = {
        KeySystem = false,
        Title = "Key System",
        Keys = {"Teddy"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            Incorrectkey = "The key is incorrect",
            CopyKeyLink = "Copied to Clipboard"
        }
    }
})

if not successWindow then
    warn("Failed to create window.")
    return
end

local successMinimize = pcall(MinimizeButton, {
    Image = "http://www.roblox.com/asset/?id=134876629801813",
    Size = {40, 40},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true
})

if not successMinimize then
    warn("Failed to create minimize button.")
    return
end

local Tab1o = MakeTab({Name = "Script Farm"})

local scripts = {
    {Name = "Xero Hub", URL = "https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"},
    {Name = "Redz Hub", URL = "https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua", Settings = {JoinTeam = "Pirates", Translator = true}},
    {Name = "Blue X", URL = "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"},
    {Name = "Min Gaming", URL = "https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinBV"},
    {Name = "Trau Roblox", URL = "https://raw.githubusercontent.com/LuaCrack/TrauHub/refs/heads/main/TrauAp1"},
    {Name = "Teddy Depazai", URL = "https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/TeddyHubv2"},
    {Name = "Zis Roblox", URL = "https://raw.githubusercontent.com/LuaCrack/Zis/refs/heads/main/ZisRb8"}
}

for _, scriptData in ipairs(scripts) do
    local success = pcall(AddButton, Tab1o, {
        Name = scriptData.Name,
        Callback = function()
            local scriptSuccess, err = pcall(function()
                if scriptData.Settings then
                    loadstring(game:HttpGet(scriptData.URL))(scriptData.Settings)
                else
                    loadstring(game:HttpGet(scriptData.URL))()
                end
            end)
            if not scriptSuccess then
                warn("Failed to load script: " .. scriptData.Name .. " - " .. err)
            end
        end
    })
    if not success then
        warn("Failed to add button for " .. scriptData.Name)
    end
end
