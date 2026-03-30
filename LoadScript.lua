local uis = game:GetService("UserInputService")

local is_mobile = uis.TouchEnabled and not uis.KeyboardEnabled

if is_mobile then
    loadstring(game:HttpGet("ССЫЛКА_ДЛЯ_МОБИЛЬНЫХ", true))()
else
    loadstring(game:HttpGet("ССЫЛКА_ДЛЯ_ПК", true))()
end