--[[  
    Tuber93-Style UI Library
    by ChatGPT
]]--

local TuberLib = {}

-- Criar Janela
function TuberLib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabButtons = Instance.new("Frame")
    local UIList = Instance.new("UIListLayout")

    ScreenGui.Parent = game:GetService("CoreGui")

    -- Frame principal
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- Título
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Text = title or "Tuber93 UI"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    -- Botões de Tabs
    TabButtons.Parent = MainFrame
    TabButtons.Size = UDim2.new(0, 120, 1, -40)
    TabButtons.Position = UDim2.new(0, 0, 0, 40)
    TabButtons.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    UIList.Parent = TabButtons
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    -- Pasta das Tabs
    local TabFolder = Instance.new("Folder")
    TabFolder.Name = "Tabs"
    TabFolder.Parent = MainFrame

    local window = {}
    window.MainFrame = MainFrame
    window.Tabs = TabFolder
    window.CurrentTab = nil

    -- Criar Tab
    function window:CreateTab(tabName)
        local Tab = Instance.new("Frame")
        Tab.Name = tabName
        Tab.Size = UDim2.new(1, -120, 1, -40)
        Tab.Position = UDim2.new(0, 120, 0, 40)
        Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Tab.Visible = false
        Tab.Parent = TabFolder

        -- Botão da Tab
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.Text = tabName
        TabButton.Parent = TabButtons

        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(TabFolder:GetChildren()) do
                t.Visible = false
            end
            Tab.Visible = true
            window.CurrentTab = Tab
        end)

        local tabAPI = {}

        -- Criar Botão
        function tabAPI:CreateButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 200, 0, 35)
            Button.Position = UDim2.new(0, 10, 0, #Tab:GetChildren() * 40)
            Button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 16
            Button.Text = text
            Button.Parent = Tab

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        return tabAPI
    end

    return window
end

return TuberLib
