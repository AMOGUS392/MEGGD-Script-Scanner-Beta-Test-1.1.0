local core_gui = game:GetService("CoreGui")
local tween_service = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "MEGGD_WarningChecker"
gui.Parent = gethui and gethui() or core_gui

local missing_funcs = {}
if not decompile then table.insert(missing_funcs, "decompile") end
if not getscripthash then table.insert(missing_funcs, "getscripthash") end
if not getscript then table.insert(missing_funcs, "getscripts") end
if not getnilinstances then table.insert(missing_funcs, "getnilinstances") end
if not getloadedmodules then table.insert(missing_funcs, "getloadedmodules") end
if not getrunningscripts then table.insert(missing_funcs, "getrunningscripts") end

local y_offset = 20

for i, func_name in ipairs(missing_funcs) do
    local frame = Instance.new("Frame")
    frame.Parent = gui
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    frame.BorderSizePixel = 1
    frame.Position = UDim2.new(1, 20, 0, y_offset)
    frame.AnchorPoint = Vector2.new(1, 0)
    frame.AutomaticSize = Enum.AutomaticSize.X
    frame.Size = UDim2.new(0, 0, 0, 30)

    local ui_padding = Instance.new("UIPadding")
    ui_padding.Parent = frame
    ui_padding.PaddingLeft = UDim.new(0, 5)
    ui_padding.PaddingRight = UDim.new(0, 10)

    local icon_container = Instance.new("Frame")
    icon_container.Parent = frame
    icon_container.BackgroundTransparency = 1
    icon_container.Size = UDim2.new(0, 16, 0, 16)
    icon_container.Position = UDim2.new(0, 0, 0.5, -8)

    local map = {
        "00000011000000",
        "00000111100000",
        "00001122110000",
        "00011122111000",
        "00111122111100",
        "01111100111110",
        "11111122111111",
        "11111111111111"
    }

    for y, row in ipairs(map) do
        for x = 1, #row do
            local char = row:sub(x, x)
            if char ~= "0" then
                local p = Instance.new("Frame")
                p.Parent = icon_container
                p.BorderSizePixel = 0
                p.Position = UDim2.new(0, (x-1)*2, 0, (y-1)*2)
                p.Size = UDim2.new(0, 2, 0, 2)
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
    text_label.Position = UDim2.new(0, 34, 0, 0)
    text_label.Size = UDim2.new(0, 0, 1, 0)
    text_label.AutomaticSize = Enum.AutomaticSize.X
    text_label.Font = Enum.Font.Arcade
    text_label.TextSize = 16
    text_label.RichText = true
    text_label.Text = string.format('<font color="rgb(255,0,0)">Your executor does not support the </font><font color="rgb(255,255,0)">%s</font><font color="rgb(255,0,0)"> feature.</font>', func_name)
    text_label.TextXAlignment = Enum.TextXAlignment.Left

    y_offset = y_offset + 40

    tween_service:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -10, 0, frame.Position.Y.Offset)}):Play()

    task.delay(5 + (i * 0.2), function()
        local tw = tween_service:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, frame.AbsoluteSize.X + 20, 0, frame.Position.Y.Offset)})
        tw:Play()
        tw.Completed:Connect(function()
            frame:Destroy()
        end)
    end)
end
