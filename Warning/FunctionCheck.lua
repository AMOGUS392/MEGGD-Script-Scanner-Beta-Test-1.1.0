local tween_service = game:GetService("TweenService")
local gui_parent = gethui and gethui() or game:GetService("CoreGui")

local required_features = {
    {name = "gethui",            fn = function() return gethui ~= nil end},
    {name = "decompile",         fn = function() return decompile ~= nil end},
    {name = "getrunningscripts", fn = function() return getrunningscripts ~= nil end},
    {name = "getloadedmodules",  fn = function() return getloadedmodules ~= nil end},
    {name = "getnilinstances",   fn = function() return getnilinstances ~= nil end},
    {name = "setclipboard",      fn = function() return setclipboard ~= nil end},
    {name = "getscriptbytecode", fn = function() return getscriptbytecode ~= nil end},
    {name = "getscripthash",     fn = function() return getscripthash ~= nil end},
}

local missing = {}
for _, entry in ipairs(required_features) do
    local ok, result = pcall(entry.fn)
    if not ok or not result then
        table.insert(missing, entry.name)
    end
end

if #missing == 0 then return end

local screen_gui = Instance.new("ScreenGui")
screen_gui.Name = "warn_checker_gui"
screen_gui.ResetOnSpawn = false
screen_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen_gui.DisplayOrder = 9999
screen_gui.Parent = gui_parent

local notif_w = 300
local notif_h = 70 + (#missing * 18)

local notif = Instance.new("Frame")
notif.Size = UDim2.new(0, notif_w, 0, notif_h)
notif.Position = UDim2.new(1, 10, 0, 60)
notif.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
notif.BorderSizePixel = 2
notif.BorderColor3 = Color3.fromRGB(200, 60, 40)
notif.ZIndex = 100
notif.ClipsDescendants = true
notif.Parent = screen_gui

local top_strip = Instance.new("Frame")
top_strip.Size = UDim2.new(1, 0, 0, 4)
top_strip.BackgroundColor3 = Color3.fromRGB(220, 60, 40)
top_strip.BorderSizePixel = 0
top_strip.ZIndex = 101
top_strip.Parent = notif

local icon_lbl = Instance.new("TextLabel")
icon_lbl.Size = UDim2.new(0, 22, 0, 22)
icon_lbl.Position = UDim2.new(0, 10, 0, 12)
icon_lbl.BackgroundColor3 = Color3.fromRGB(220, 120, 30)
icon_lbl.BorderSizePixel = 0
icon_lbl.Text = "!"
icon_lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
icon_lbl.Font = Enum.Font.Arcade
icon_lbl.TextSize = 16
icon_lbl.ZIndex = 102
icon_lbl.Parent = notif

local title_lbl = Instance.new("TextLabel")
title_lbl.Size = UDim2.new(1, -44, 0, 18)
title_lbl.Position = UDim2.new(0, 40, 0, 8)
title_lbl.BackgroundTransparency = 1
title_lbl.Text = "UNSUPPORTED EXECUTOR"
title_lbl.TextColor3 = Color3.fromRGB(220, 60, 40)
title_lbl.Font = Enum.Font.Arcade
title_lbl.TextSize = 13
title_lbl.TextXAlignment = Enum.TextXAlignment.Left
title_lbl.ZIndex = 102
title_lbl.Parent = notif

local sub_lbl = Instance.new("TextLabel")
sub_lbl.Size = UDim2.new(1, -14, 0, 16)
sub_lbl.Position = UDim2.new(0, 8, 0, 28)
sub_lbl.BackgroundTransparency = 1
sub_lbl.RichText = true
sub_lbl.Text = "Your executor does not support the <font color=\"#FFD700\">missing feature</font>."
sub_lbl.TextColor3 = Color3.fromRGB(180, 180, 200)
sub_lbl.Font = Enum.Font.Arcade
sub_lbl.TextSize = 11
sub_lbl.TextXAlignment = Enum.TextXAlignment.Left
sub_lbl.ZIndex = 102
sub_lbl.Parent = notif

for i, feat_name in ipairs(missing) do
    local row = Instance.new("TextLabel")
    row.Size = UDim2.new(1, -20, 0, 16)
    row.Position = UDim2.new(0, 10, 0, 44 + (i - 1) * 18)
    row.BackgroundTransparency = 1
    row.RichText = true
    row.Text = "▸ Your executor does not support the <font color=\"#FFD700\">`" .. feat_name .. "`</font>."
    row.TextColor3 = Color3.fromRGB(200, 200, 220)
    row.Font = Enum.Font.Arcade
    row.TextSize = 10
    row.TextXAlignment = Enum.TextXAlignment.Left
    row.ZIndex = 102
    row.Parent = notif
end

local target_x = 1 - (notif_w / 1) 
local slide_in_pos = UDim2.new(1, -(notif_w + 10), 0, 60)
local slide_out_pos = UDim2.new(1, 10, 0, 60)

tween_service:Create(notif, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Position = slide_in_pos
}):Play()

task.delay(5, function()
    if notif and notif.Parent then
        tween_service:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = slide_out_pos
        }):Play()
        task.delay(0.42, function()
            if screen_gui and screen_gui.Parent then
                screen_gui:Destroy()
            end
        end)
    end
end)
