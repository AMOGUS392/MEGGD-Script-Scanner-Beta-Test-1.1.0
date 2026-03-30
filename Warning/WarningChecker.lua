local c=game:GetService("CoreGui")
local t=game:GetService("TweenService")
local s=Instance.new("Sound")
s.SoundId="rbxassetid://858508159"
s.Volume=2
s.Parent=c
s:Play()
game.Debris:AddItem(s,3)
local g=c:FindFirstChild("pixel_decompiler_gui")
if not g then return end
local m=g:FindFirstChild("main_container")
if not m then return end
local f={}
if not decompile then table.insert(f,"decompile") end
if not getscripthash then table.insert(f,"getscripthash") end
if not getscript then table.insert(f,"getscripts") end
if not getnilinstances then table.insert(f,"getnilinstances") end
local y=20
for i,v in ipairs(f) do
local w=Instance.new("Frame")
w.Parent=g
w.BackgroundColor3=Color3.fromRGB(0,0,0)
w.BorderColor3=Color3.fromRGB(255,255,255)
w.BorderSizePixel=2
w.Size=UDim2.new(0,0,0,30)
w.AutomaticSize=Enum.AutomaticSize.X
w.AnchorPoint=Vector2.new(0,0)
w.Position=UDim2.new(0,m.AbsolutePosition.X+m.AbsoluteSize.X+50,0,m.AbsolutePosition.Y+y)
w.ZIndex=100
local pad=Instance.new("UIPadding")
pad.Parent=w
pad.PaddingLeft=UDim.new(0,5)
pad.PaddingRight=UDim.new(0,10)
local ic=Instance.new("Frame")
ic.Parent=w
ic.BackgroundTransparency=1
ic.Size=UDim2.new(0,16,0,16)
ic.Position=UDim2.new(0,0,0.5,-8)
local map={"000001100000","000011110000","000112211000","001112211100","011112211110","011110011110","111112211111","111111111111"}
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
l.Position=UDim2.new(0,24,0,0)
l.Size=UDim2.new(0,0,1,0)
l.AutomaticSize=Enum.AutomaticSize.X
l.Font=Enum.Font.Arcade
l.TextSize=16
l.RichText=true
l.Text='<font color="rgb(255,0,0)">Your executor does not support the </font><font color="rgb(255,255,0)">'..v..'</font><font color="rgb(255,0,0)"> feature.</font>'
l.TextXAlignment=Enum.TextXAlignment.Left
local tw_in=t:Create(w,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0,m.AbsolutePosition.X+m.AbsoluteSize.X-w.AbsoluteSize.X-20,0,m.AbsolutePosition.Y+y)})
tw_in:Play()
y=y+40
task.delay(5+(i*0.2),function()
local tw_out=t:Create(w,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(0,m.AbsolutePosition.X+m.AbsoluteSize.X+50,0,m.AbsolutePosition.Y+y-40)})
tw_out:Play()
tw_out.Completed:Connect(function() w:Destroy() end)
end)
end
print("MEGGD Script Scanner WarningChecker - Loaded!")
