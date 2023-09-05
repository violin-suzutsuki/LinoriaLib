# This Is A Documentation Of LinoriaUI For beginers On how To make Your Own GUI With This UserInterface.
### Made By mrkillinghunter_/MrKillingHunter. Let's get Started!

_______________________________________________________________________________________________________________

# Page 1: Setting Up

### Booting The Library:
##### Like Any Other UI, To Make A Script, u need To Put The Library Up! So Let's Do that!
```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```
##### This Will Get The Code Required For Your GUI To Work.

_______________________________________________________________________________________________________________

# Page 2: Creating The Essentials

### Creating A Window:
##### This Is The Most Common thign Ever, Starting Up A Window For Stuff To Go In.
```lua
local Window = Library:CreateWindow({
    Title = 'Your Script Name', 
    Center = true, -- Set Center to true if you want the menu to appear in the center
    AutoShow = true, -- Set AutoShow to true if you want the menu to appear when it is created
    TabPadding = 8,  -- Position and Size are also valid options here 
    MenuFadeTime = 0.2 -- but you do not need to define them unless you are changing them :)
})
