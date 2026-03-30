local c=game:GetService("CoreGui")
local t=game:GetService("TweenService")
local s=Instance.new("Sound")
s.SoundId="rbxassetid://858508159"
s.Volume=2
s.Parent=c
s:Play()
game.Debris:AddItem(s,3)
task.spawn(function()
local g=c:WaitForChild("pixel_decompiler_gui",5)
if not g then return end
local m=g:WaitForChild("main_container",5)
if not m then return end
local f={}
if not decompile then table.insert(f,"decompile") end
if not getscripthash then table.insert(f,"getscripthash") end
if not getscripts then table.insert(f,"getscripts") end
if not getnilinstances then table.insert(f,"getnilinstances") end
if not getloadedmodules then table.insert(f,"getloadedmodules") end
if not getrunningscripts then table.insert(f,"getrunningscripts") end
if #f==0 then return end
local y=45
for i,v in ipairs(f) do
local w=Instance.new("Frame")
w.Parent=m
w.BackgroundColor3=Color3.fromRGB(0,0,0)
w.BorderColor3=Color3.fromRGB(255,255,255)
w.BorderSizePixel=2
w.Size=UDim2.new(0,0,0,36)
w.AutomaticSize=Enum.AutomaticSize.X
w.AnchorPoint=Vector2.new(1,0)
w.Position=UDim2.new(1,500,0,y)
w.ZIndex=100
local pad=Instance.new("UIPadding")
pad.Parent=w
pad.PaddingLeft=UDim.new(0,8)
pad.PaddingRight=UDim.new(0,12)
local ic=Instance.new("Frame")
ic.Parent=w
ic.BackgroundTransparency=1
ic.Size=UDim2.new(0,28,0,16)
ic.Position=UDim2.new(0,0,0.5,-8)
local map={"00000011000000","00000111100000","00001122110000","00011122111000","00111122111100","01111100111110","11111122111111","11111111111111"}
for my,row in ipairs(map) do
for mx=1,#row do
local char=row:sub(mx,mx)
if char~="0" then
local pf=Instance.new("Frame")
pf.Parent=ic
pf.BorderSizePixel=0
pf.Position=UDim2.new(0,(mx-1)*2,0,(my-1)*2)
pf.Size=UDim2.new(0,2,0,2)
if char=="1" then pf.BackgroundColor3=Color3.fromRGB(255,0,0) else pf.BackgroundColor3=Color3.fromRGB(255,255,255) end
end
end
end
local l=Instance.new("TextLabel")
l.Parent=w
l.BackgroundTransparency=1
l.Position=UDim2.new(0,34,0,0)
l.Size=UDim2.new(0,0,1,0)
l.AutomaticSize=Enum.AutomaticSize.X
l.Font=Enum.Font.Arcade
l.TextSize=16
l.RichText=true
l.Text='<font color="rgb(255,0,0)">Your executor does not support the </font><font color="rgb(255,255,0)">'..v..'</font><font color="rgb(255,0,0)"> feature.</font>'
l.TextXAlignment=Enum.TextXAlignment.Left
l.TextYAlignment=Enum.TextYAlignment.Center
local tw_in=t:Create(w,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-10,0,y)})
tw_in:Play()
y=y+44
task.delay(5+(i*0.2),function()
local tw_out=t:Create(w,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,w.AbsoluteSize.X+50,0,y-44)})
tw_out:Play()
tw_out.Completed:Connect(function() w:Destroy() end)
end)
end
end)
print("MEGGD Script Scanner WarningChecker - Loaded!")
