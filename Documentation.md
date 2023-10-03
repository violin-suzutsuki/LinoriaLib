# Documentation for the LinoriaLib

## Importing the library
```lua
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua'))()
```

## Creating a new window
```lua
local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true, -- Set Center to true if you want the menu to appear in the center
    AutoShow = true, -- Set AutoShow to true if you want the menu to appear when it is created
    TabPadding = 8,
    MenuFadeTime = 0.2
    --Position = float (optional)
    --Size = float (optional)
})
```

## Creating tabs
```lua
local mainTab = Window:AddTab('Main')
```

## Creating GroupBoxes
```lua
local LeftGroupBox = Main:AddLeftGroupbox('Left Groupbox')
local RightGroupbox = Main:AddRightGroupbox('Right Groupbox');
```

## Creating TabBoxes
```lua
local RightTabBox = Main:AddRightTabbox()
local LeftTabBox = Main:AddLeftTabbox()
```

## Creating Labels
```lua
local Label = LeftGroupBox:AddLabel('This is a label')
--[[
Text = string
doesWrap = boolean (optional)
]]
```

## Creating Buttons
```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Button',
    Func = function()
        print('You clicked a button!')
    end,
    DoubleClick = false,
    Tooltip = 'This is the main button' -- When you hover over the button this appears
})

--[[
    NOTE: You can chain the button methods!
    EXAMPLE:

    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]
```
## Creating Toggles
```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})

MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)
```
## Creating Sliders

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[cb] MySlider was changed! New value:', Value)
    end
})

local Number = Options.MySlider.Value
MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)

MySlider:SetValue(3)
```
