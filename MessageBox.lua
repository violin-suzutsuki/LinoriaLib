-- xheptc message box just edited with press debounce

local MessageBoxT = {
    BoxIcons = {
        ["Question"] = "http://www.roblox.com/asset/?id=8800441559",
        ["Error"] = "http://www.roblox.com/asset/?id=8800303348",
        ["Warning"] = "http://www.roblox.com/asset/?id=8800428538"
    }
}

local ID = 8801438982

local CurrentCamera;
local plrs = game:GetService("Players")
local plr = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local inpService = game:GetService("UserInputService")
local Mouse = plr:GetMouse()

while (not CurrentCamera) do
	CurrentCamera = workspace.CurrentCamera
	wait()
end

local minimized = false

local function ToBounds(X,Y, MW)
	if (X - MW.Size.X.Offset / 2 < 0) then
		X = MW.Size.X.Offset / 2
	end

	if ((MW.AbsoluteSize.Y - Y) - MW.Size.Y.Offset / 2 >= MW.AbsoluteSize.Y) then
		Y = MW.Size.Y.Offset / 2
	end

	if ((X + MW.AbsoluteSize.X) >= (CurrentCamera.ViewportSize.X) + MW.Size.X.Offset / 2) then
		X = CurrentCamera.ViewportSize.X - MW.AbsoluteSize.X + MW.Size.X.Offset / 2
	end

	if (((Y + MW.AbsoluteSize.Y) + 35) >= (CurrentCamera.ViewportSize.Y) + MW.Size.Y.Offset / 2) then
		Y = (CurrentCamera.ViewportSize.Y - MW.AbsoluteSize.Y) - 35 + MW.Size.Y.Offset / 2
	end


	return UDim2.new(0, X, 0, Y)
end

local function Tween(object, time, properties)
    local info = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    TweenService:Create(object, info, properties):Play()
end


-- thank you kesh for drag :) <3
local function ApplyDrag(Component, MainWindow)
	local MouseDown = false
	local MB1 = Enum.UserInputType.MouseButton1 -- no way in hell am i indexing that 24/7
	local MM = Enum.UserInputType.MouseMovement -- no way in hell am i indexing that 24/7

	local Position = Vector2.new()

	local InputBegan = Component.InputBegan:Connect(function(input)
		if (input.UserInputType == MB1) then
            Component.BackgroundTransparency = 0
            Component["Box-Title"].TextColor3 = Color3.fromRGB(255,255,255)
            Component["Close"]["btn"].TextColor3 = Color3.fromRGB(255,255,255)
			MouseDown = true
			Position = Vector2.new(input.Position.X-MainWindow.AbsolutePosition.X-MainWindow.Size.X.Offset / 2, input.Position.Y-MainWindow.AbsolutePosition.Y-MainWindow.Size.Y.Offset / 2)
		end
	end)

	local InputEnded = Component.InputEnded:Connect(function(input)
		if (input.UserInputType == MB1) then
			MouseDown = false
            Component.BackgroundTransparency = 1
            Component["Box-Title"].TextColor3 = Color3.fromRGB(0,0,0)
            Component["Close"]["btn"].TextColor3 = Color3.fromRGB(0,0,0)
		end
	end)

	local InputChanged;

	InputChanged = game:GetService("UserInputService").InputChanged:Connect(function(input)
		if (MouseDown and input.UserInputType == MM) then
            Tween(MainWindow, 0.1, {Position = ToBounds((Mouse.X-Position.X), (Mouse.Y-Position.Y), MainWindow)})
			--MainWindow.Position = ToBounds((Mouse.X-Position.X), (Mouse.Y-Position.Y), MainWindow)
		end
	end)
end

function MessageBoxT.Show(option)
    option = typeof(option) == "table" and option or {}
    local MessageDescription = tostring(option.Description) and option.Description or "This is an Notification"
    local Options = tostring(option.MessageBoxButtons) and option.MessageBoxButtons or "OK"
    local MessageIcon = tostring(option.MessageBoxIcon) and option.MessageBoxIcon or "Warning"
    local ResultCallback = typeof(option.Result) == "function" and option.Result or function() end
    local MessageTitle = tostring(option.Text) and option.Text or ""
    local CustomPos = option.Position or UDim2.new(0.5,0,0.5,0)

    local GUI

    local Addup = 0
	local Cooldown = false

    if (game.CoreGui:FindFirstChild("Notifications")) then 
	GUI = game.CoreGui:FindFirstChild("Notifications")
    else 
        GUI = Instance.new("ScreenGui", game.CoreGui)
        GUI.Name = "Notifications"
    end

    local MessageBox = game:GetObjects("rbxassetid://"..ID)[1]
    MessageBox["UIScale"].Scale = 1
    MessageBox:Clone()
    MessageBox.Parent = GUI
    MessageBox.Position = CustomPos
    MessageBox.Position = UDim2.new(0, MessageBox.AbsolutePosition.X, 0, MessageBox.AbsolutePosition.Y)

    --// Applying Options
    MessageBox["Message-Header"]["Box-Title"].Text = MessageTitle
    MessageBox["MessageDescription"].Text = MessageDescription
    MessageBox["Message-Icons"]["Error"].Image = MessageBoxT.BoxIcons["Error"]
    MessageBox["Message-Icons"]["Warning"].Image = MessageBoxT.BoxIcons["Warning"]
    MessageBox["Message-Icons"]["Question"].Image = MessageBoxT.BoxIcons["Question"]

    ApplyDrag(MessageBox["Message-Header"], MessageBox)

    local Icon = MessageBox["Message-Icons"]:FindFirstChild(MessageIcon)
    Icon.Parent = MessageBox
    Icon.Visible = true
    local Buttons = nil
    
    if Options ~= "None" then
        Buttons = MessageBox["MessageBoxButtons"][Options]:Clone()
        Buttons.Visible = true
        Buttons.Parent = MessageBox
        Addup = 36
    else
        Addup = 6
    end

    if MessageBox["MessageDescription"].TextBounds.Y >= 16 then
        MessageBox["MessageDescription"].Position = UDim2.new(0, 48,0, 42)
        Addup -= 14
    end

    MessageBox.Size = UDim2.new(0, MessageBox["MessageDescription"].TextBounds.X + 100,0, MessageBox["MessageDescription"].TextBounds.Y + 70 + Addup)
    
    if Buttons ~= nil then
        for i,v in pairs(Buttons:GetChildren()) do
            if v:IsA("TextButton") then
                v.MouseButton1Click:Connect(function()
					if Cooldown then return end
					Cooldown = true
                    ResultCallback(v.Text)
                    game.TweenService:Create(MessageBox["UIScale"], TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 0
                    }):Play()
                    wait(0.1)
                    MessageBox:Destroy()
                end)
            end
        end
    end

    MessageBox["UIScale"].Scale = 0

    game.TweenService:Create(MessageBox["UIScale"], TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = 1
    }):Play()
end

return MessageBoxT
