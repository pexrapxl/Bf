--// BF PRO UI - GitHub Version
local P=game:GetService("Players").LocalPlayer
local C=P.Character or P.CharacterAdded:Wait()
local H=C:WaitForChild("HumanoidRootPart")
local W=game:GetService("Workspace")
local T=game:GetService("TweenService")
local U=game:GetService("UserInputService")

--// Config
getgenv().BF=getgenv().BF or{AF=false,FR=50,SP=false,FL=false}

--// UI
local S=Instance.new("ScreenGui",game:GetService("CoreGui"))
local M=Instance.new("Frame",S)
M.Size=UDim2.new(0,280,0,350)
M.Position=UDim2.new(0,10,0.5,-175)
M.BackgroundColor3=Color3.fromRGB(15,15,20)
M.Active=true
M.Draggable=true

Instance.new("UICorner",M).CornerRadius=UDim.new(0,10)

--// Title
local Ti=Instance.new("TextLabel",M)
Ti.Size=UDim2.new(1,0,0,35)
Ti.Text="🍎 BF PRO FARM"
Ti.TextColor3=Color3.fromRGB(255,50,50)
Ti.TextSize=18
Ti.Font=Enum.Font.GothamBlack
Ti.BackgroundTransparency=1

--// Toggle Button (Top Right)
local Tb=Instance.new("TextButton",S)
Tb.Size=UDim2.new(0,45,0,45)
Tb.Position=UDim2.new(1,-55,0,10)
Tb.BackgroundColor3=Color3.fromRGB(255,50,50)
Tb.Text="🍎"
Tb.TextSize=20
Tb.Font=Enum.Font.GothamBold
Instance.new("UICorner",Tb).CornerRadius=UDim.new(1,0)

Tb.MouseButton1Click:Connect(function()
    M.Visible=not M.Visible
end)

--// Create Toggle
local function CT(y,t,k,c)
    c=c or Color3.fromRGB(0,255,100)
    local F=Instance.new("Frame",M)
    F.Size=UDim2.new(1,-20,0,35)
    F.Position=UDim2.new(0,10,0,y)
    F.BackgroundColor3=Color3.fromRGB(25,25,30)
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    
    local L=Instance.new("TextLabel",F)
    L.Size=UDim2.new(0.6,0,1,0)
    L.Position=UDim2.new(0,10,0,0)
    L.Text=t
    L.TextColor3=Color3.new(1,1,1)
    L.TextSize=13
    L.Font=Enum.Font.Gotham
    L.BackgroundTransparency=1
    L.TextXAlignment=Enum.TextXAlignment.Left
    
    local B=Instance.new("TextButton",F)
    B.Size=UDim2.new(0,50,0,25)
    B.Position=UDim2.new(1,-65,0.5,-12.5)
    B.BackgroundColor3=getgenv().BF[k]and c or Color3.fromRGB(60,60,70)
    B.Text=getgenv().BF[k]and"ON"or"OFF"
    B.TextColor3=Color3.new(1,1,1)
    B.TextSize=11
    B.Font=Enum.Font.GothamBold
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,5)
    
    B.MouseButton1Click:Connect(function()
        getgenv().BF[k]=not getgenv().BF[k]
        B.BackgroundColor3=getgenv().BF[k]and c or Color3.fromRGB(60,60,70)
        B.Text=getgenv().BF[k]and"ON"or"OFF"
    end)
end

--// Build UI
CT(45,"🎯 Auto Farm","AF",Color3.fromRGB(0,255,100))
CT(85,"⚡ Speed Hack","SP",Color3.fromRGB(0,150,255))
CT(125,"🚀 Fly Mode","FL",Color3.fromRGB(0,255,255))
CT(165,"💀 Kill Aura","KA",Color3.fromRGB(255,0,0))

--// Status
local St=Instance.new("TextLabel",M)
St.Size=UDim2.new(1,-20,0,20)
St.Position=UDim2.new(0,10,1,-25)
St.Text="Status: Ready"
St.TextColor3=Color3.fromRGB(0,255,100)
St.TextSize=12
St.Font=Enum.Font.Gotham
St.BackgroundTransparency=1
St.TextXAlignment=Enum.TextXAlignment.Left

--// Farm Function
local function FM()
    local m={}
    for _,v in ipairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart")then
            if v.Humanoid.Health>0 and v~=C then table.insert(m,v)end
        end
    end
    table.sort(m,function(a,b)return(H.Position-a.HumanoidRootPart.Position).Magnitude<(H.Position-b.HumanoidRootPart.Position).Magnitude end)
    return m
end

--// Speed
game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().BF.SP then
        C:FindFirstChildOfClass("Humanoid").WalkSpeed=100
    else
        C:FindFirstChildOfClass("Humanoid").WalkSpeed=16
    end
end)

--// Fly
local FG,FV,FC
game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().BF.FL then
        if not FG then
            FG=Instance.new("BodyGyro",H)
            FG.P=9e4;FG.MaxTorque=Vector3.new(9e9,9e9,9e9);FG.CFrame=H.CFrame
        end
        if not FV then
            FV=Instance.new("BodyVelocity",H)
            FV.Velocity=Vector3.new(0,0,0);FV.MaxForce=Vector3.new(9e9,9e9,9e9)
        end
        local cam=game:GetService("Workspace").CurrentCamera
        local md=Vector3.new(0,0,0)
        if U:IsKeyDown(Enum.KeyCode.W)then md=md+cam.CFrame.LookVector end
        if U:IsKeyDown(Enum.KeyCode.S)then md=md-cam.CFrame.LookVector end
        if U:IsKeyDown(Enum.KeyCode.A)then md=md-cam.CFrame.RightVector end
        if U:IsKeyDown(Enum.KeyCode.D)then md=md+cam.CFrame.RightVector end
        if U:IsKeyDown(Enum.KeyCode.Space)then md=md+Vector3.new(0,1,0) end
        if U:IsKeyDown(Enum.KeyCode.LeftShift)then md=md-Vector3.new(0,1,0) end
        if md.Magnitude>0 then md=md.Unit*50 end
        FV.Velocity=md;FG.CFrame=cam.CFrame
    else
        if FG then FG:Destroy()FG=nil end
        if FV then FV:Destroy()FV=nil end
    end
end)

--// Main Farm Loop
while wait()do
    if not getgenv().BF.AF then St.Text="Status: Idle" continue end
    St.Text="Status: Farming..."
    for _,v in ipairs(FM())do
        if not getgenv().BF.AF then break end
        local h=v:FindFirstChild("HumanoidRootPart")
        if h and v.Humanoid.Health>0 then
            local d=(H.Position-h.Position).Magnitude
            T:Create(H,TweenInfo.new(d/300,Enum.EasingStyle.Linear),{CFrame=h.CFrame*CFrame.new(0,0,5)}):Play()
            wait(d/300+0.1)
            while v and v:FindFirstChild("Humanoid")and v.Humanoid.Health>0 and getgenv().BF.AF do
                H.CFrame=CFrame.new(H.Position,Vector3.new(h.Position.X,H.Position.Y,h.Position.Z))
                local x=C:FindFirstChildOfClass("Tool")
                if x then for i=1,5 do x:Activate()wait(.05)end end
                wait(.1)
            end
        end
    end
end
