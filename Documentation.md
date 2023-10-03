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
