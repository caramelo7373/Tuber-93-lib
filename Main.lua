--[[  
    Tuber93-Style UI Library v2
    by ChatGPT
]]--

local TuberLib = {}

-- Tema padrão
local Theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Topbar = Color3.fromRGB(15, 15, 15),
    Sidebar = Color3.fromRGB(20, 20, 20),
    Tab = Color3.fromRGB(35, 35, 35),
    Button = Color3.fromRGB(55, 55, 55),
    Text = Color3.fromRGB(255, 255, 255),
}

-- Criar Janela
function TuberLib:CreateWindow(title, theme)
    if theme then
        for k, v in pairs(theme) do
            Theme[k] = v
        end
    end

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
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- Título
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Theme.Topbar
    Title.TextColor3 = Theme.Text
    Title.Text = title or "Tuber93 UI"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextStrokeTransparency = 0.8
    Title.Padding = Enum.AutomaticSize.X

    -- Botão minimizar
    local Minimize = Instance.new("TextButton")
    Minimize.Parent = Title
    Minimize.Size = UDim2.new(0, 40, 1, 0)
    Minimize.Position = UDim2.new(1, -80, 0, 0)
    Minimize.BackgroundColor3 = Theme.Button
    Minimize.Text = "▭"
    Minimize.TextColor3 = Theme.Text
    Minimize.Font = Enum.Font.GothamBold
    Minimize.TextSize = 20

    -- Botão fechar
    local Close = Instance.new("TextButton")
    Close.Parent = Title
    Close.Size = UDim2.new(0, 40, 1, 0)
    Close.Position = UDim2.new(1, -40, 0, 0)
    Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Close.Text = "●"
    Close.TextColor3 = Theme.Text
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 20

    -- Ações botões
    local minimized = false
    Minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        for _, child in ipairs(MainFrame:GetChildren()) do
            if child.Name ~= "Title" then
                child.Visible = not minimized
            end
        end
    end)

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Botões de Tabs
    TabButtons.Parent = MainFrame
    TabButtons.Size = UDim2.new(0, 120, 1, -40)
    TabButtons.Position = UDim2.new(0, 0, 0, 40)
    TabButtons.BackgroundColor3 = Theme.Sidebar
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
        Tab.BackgroundColor3 = Theme.Tab
        Tab.Visible = false
        Tab.Parent = TabFolder

        -- Botão da Tab
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Theme.Button
        TabButton.TextColor3 = Theme.Text
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
            Button.BackgroundColor3 = Theme.Button
            Button.TextColor3 = Theme.Text
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
