local core_gui = game:GetService("CoreGui")
local tween_service = game:GetService("TweenService")
local run_service = game:GetService("RunService")

local gui_parent = gethui and gethui() or core_gui
local target_gui = gui_parent:FindFirstChild("pixel_decompiler_gui")
local main_gui = target_gui and target_gui:FindFirstChild("main_container")

local gui = Instance.new("ScreenGui")
gui.Name = "MEGGD_WarningChecker"
gui.Parent = gui_parent

local missing_funcs = {}
if not decompile then table.insert(missing_funcs, "decompile") end
if not getscripthash then table.insert(missing_funcs, "getscripthash") end
if not getscripts then table.insert(missing_funcs, "getscripts") end
if not getnilinstances then table.insert(missing_funcs, "getnilinstances") end
if not getloadedmodules then table.insert(missing_funcs, "getloadedmodules") end
if not getrunningscripts then table.insert(missing_funcs, "getrunningscripts") end

if #missing_funcs > 0 then
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://2865227271"
    sound.Volume = 2
    sound.Parent = gui_parent
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
end

local y_offset = 0

for i, func_name in ipairs(missing_funcs) do
    local frame = Instance.new("Frame")
    frame.Parent = gui
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.BorderSizePixel = 2
    frame.AnchorPoint = Vector2.new(0, 0)
    frame.AutomaticSize = Enum.AutomaticSize.X
    frame.Size = UDim2.new(0, 0, 0, 34)
    frame.ZIndex = 100

    local start_x = 0
    local start_y = 0
    if main_gui then
        start_x = main_gui.AbsolutePosition.X + main_gui.AbsoluteSize.X - 20
        start_y = main_gui.AbsolutePosition.Y + 10 + y_offset
    else
        start_x = core_gui.AbsoluteSize.X - 50
        start_y = 50 + y_offset
    end

    frame.Position = UDim2.new(0, start_x, 0, start_y)

    local ui_padding = Instance.new("UIPadding")
    ui_padding.Parent = frame
    ui_padding.PaddingLeft = UDim.new(0, 8)
    ui_padding.PaddingRight = UDim.new(0, 12)

    local icon_container = Instance.new("Frame")
    icon_container.Parent = frame
    icon_container.BackgroundTransparency = 1
    icon_container.Size = UDim2.new(0, 18, 0, 18)
    icon_container.Position = UDim2.new(0, 0, 0.5, -9)
    icon_container.ZIndex = 101

    local map = {
        "0000000110000000",
        "0000001111000000",
        "0000011111100000",
        "0000112222110000",
        "0001112222111000",
        "0011112222111100",
        "0111112222111110",
        "1111110000111111",
        "1111112222111111",
        "1111111111111111"
    }

    for y, row in ipairs(map) do
        for x = 1, #row do
            local char = row:sub(x, x)
            if char ~= "0" then
                local p = Instance.new("Frame")
                p.Parent = icon_container
                p.BorderSizePixel = 0
                p.Position = UDim2.new(0, (x-1)*1.2, 0, (y-1)*1.8)
                p.Size = UDim2.new(0, 2, 0, 2)
                p.ZIndex = 101
                if char == "1" then
                    p.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                else
                    p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end

    local text_label = Instance.new("TextLabel")
    text_label.Parent = frame
    text_label.BackgroundTransparency = 1
    text_label.Position = UDim2.new(0, 26, 0, 0)
    text_label.Size = UDim2.new(0, 0, 1, 0)
    text_label.AutomaticSize = Enum.AutomaticSize.X
    text_label.Font = Enum.Font.Arcade
    text_label.TextSize = 16
    text_label.RichText = true
    text_label.Text = string.format('<font color="rgb(255,50,50)">Your executor does not support the </font><font color="rgb(255,255,0)">%s</font><font color="rgb(255,50,50)"> feature.</font>', func_name)
    text_label.TextXAlignment = Enum.TextXAlignment.Left
    text_label.TextStrokeTransparency = 0
    text_label.TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
    text_label.ZIndex = 101

    y_offset = y_offset + 45

    local target_x = start_x + 40
    tween_service:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, target_x, 0, start_y)}):Play()

    task.delay(5 + (i * 0.2), function()
        local tw = tween_service:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0, start_x - 50, 0, start_y), BackgroundTransparency = 1})
        tween_service:Create(text_label, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
        for _, c in ipairs(icon_container:GetChildren()) do
            tween_service:Create(c, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        end
        tw:Play()
        tw.Completed:Connect(function()
            frame:Destroy()
        end)
    end)
end
print("MEGGD Script Scanner WarningChecker - Loaded!")
