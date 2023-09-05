# This Is A Documentation Of LinoriaUI For beginers On how To make Your Own GUI With This UserInterface.
### Made By mrkillinghunter_/MrKillingHunter. Let's get Started! I'll try to make this Beginner/user-friendly
#### I Also Won't be Putting Updating In This Documentation.md So Yea
_____________________________________________________________________________________________________________________________________________________

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

_______________________________________________________________________________________________________________________________________________________

# Page 2: Creating The Essentials

### Creating A Window:
##### This Is The Most Common thing Ever, Starting Up A Window For Stuff To Go In.
```lua
local Window = Library:CreateWindow({
    Title = 'Your Script Name', 
    Center = true, -- Set Center to true if you want the menu to appear in the center
    AutoShow = true, -- Set AutoShow to true if you want the menu to appear when it is created
    TabPadding = 8,  -- Position and Size are also valid options here 
    MenuFadeTime = 0.2 -- but you do not need to define them unless you are changing them :)
})
```
##### This Basically Creates A Window With Properties that You Set (Default Is The Reccomended)

### Creating Tabs:
##### Just like any Other UI, tabs Are A Essential In Both Convenience As Aesthethics As It Allows You to organize Your Script.
##### You Can Add More tabs As You Wish.
```lua
local Tabs = {
-- the front part is the 'nickname' of your tab, the name in code.
-- the name in parenthesis is the name in you window
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}
```

### Creating Groupboxes:
##### In Other UIs, there Are Things Called Sections That Seperate Stuff Into Subcategories In Your GUI. Here, They Are Called Groupboxes.
##### They Basically Are Actual Boxes That hold items In Them. When U Create One, The Order Starts From the Top. there Are Right And left Versions Of these
```lua
-- the word after local is the 'nickname' of ur groupbox
-- Just Like tabs, the words in the parenthesis is the name itll show on the GUI
-- the '.Main' part, the word main is your tab's nickname
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')
```
#### Other Options Are Below
```lua
-- you can add tabboxes which basically are groupboxes with tabs. you can do the same things. they are abit tricky for beginners tho
-- the word after local is the nickname
-- the '.Main' part, the 'Main' is your tabs (tab, not tabbox) nickname
local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side

-- words after local are the nicknames of each tab of the tabbox
-- the words in the parenthesis is the name of them in the GUI
local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')
```
#### Destroying Interface:
##### This Is Completely Optional, Its The Code/Function you can add to a button to close the interface completely
```lua
Library.Unload
```
____________________________________________________________________________________________________________________________________________________________

# Page 3: Adding Elements

### Adding Toggles:
##### Toggles Are A Element Of GUIs, Allowing You to toggle Features Instead Of Just Being On Permenantly Like A button.
##### They Look Like Checkboxes Without The Ticks.
```lua
-- the 'LeftGroupBox' part is the nickname of ur groupbox
-- Text is the name of the toggle on the UI
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})
```

### Adding Buttons:
##### Buttons Are Pretty Much The One Thing Every Single UI Will have, And They Are Simple. Just A Click And The Function Activates!
##### On Linoria, You Can Add Sub-buttons And Even Enable A Function That Makes The Button only Activate When it's Double-Clicked!
```lua
-- MyButton is basically the nickname of the button in the code.
-- LeftGroupBox Will be the nickname of your Groupbox/Tabbox
local MyButton = LeftGroupBox:AddButton({
    Text = 'Button', -- the name of your button on screen
    Func = function()
        print('You clicked a button!') -- the feature your button will do when its clicked
    end,
    DoubleClick = false, -- set to true if u want the button to only activate when it's Double clicked
    Tooltip = 'This is the main button' - Infomation When curosr hoveres over the button
})
```
#### Additional Options
###### Sub-Buttons



























