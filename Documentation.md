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
##### Sub-Buttons:
##### Sub Buttons Are Basically Secondary Butttons You Can Add (ive never found a use for these)
```lua
-- MyButton2 is the nickname
-- MyButton is the nickname of ur main button
local MyButton2 = MyButton:AddButton({
    Text = 'Sub button',
    Func = function()
        print('You clicked a sub button!')
    end,
    DoubleClick = true, 
    Tooltip = 'This is the sub button (double click me!)'
})
```

### Adding labels:
##### Another Essential Element, Adding text To your GUI. I wont be putting instructions since its EXTREMELY simple (call me lazy iyw)
```lua
LeftGroupBox:AddLabel('This is a label')
```
##### You Can Add Labels That Wrap the text Too!
```lua
LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)
```

### Adding Dividers:
##### Sometimes, Stuff In A groupbox need To be Categorized More By Being Seperated.
##### And that's Where Dividers come in!
```lua
-- LeftGroupBox will be the nickname of your groupbox/tabbox
LeftGroupBox:AddDivider()
```

### Adding Sliders:
##### A Simple Slider That Can be Used For Walkspeeed Changers! Or Even More!
```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
    Default = 0, -- the default value when u load in the GUI
    Min = 0, -- the Minimum Value the Slider Can go/reach
    Max = 5, -- The maximum value the slider can go/reach
    Rounding = 1, -- The Rounding of The Value
    Compact = false, -- Hides the Max value (visiblilty)

    Callback = function(Value)
        print('[cb] MySlider was changed! New value:', Value)
    end
})
```

### Adding Interactive Textboxes:
##### Sometimes You Want To Add textboxes for the user to use? (idk why ) well using the Textbox is simple!
```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'My textbox!',
    Numeric = false, -- true / false, only allows numbers
    Finished = true, -- true / false, only calls callback when you press enter

    Text = 'This is a textbox', - default text
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox

    Placeholder = 'Placeholder text', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print('[cb] Text updated. New text:', Value)
    end
})
```

### Adding Dropdowns:
##### Have You Seen Those Cool ESPs That Uses Dropdowns to allow u to select the ESPs you want enabled? Here's How To Make One!
```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})
```
#### Other options
##### Want To Make One that allows you to select multiple values? say no more
```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    -- Default is the numeric index (e.g. "This" would be 1 since it if first in the values list)
    -- Default also accepts a string as well

    -- Currently you can not set multiple values with a dropdown

    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1,
    Multi = true, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Multi dropdown got changed:', Value)
    end
})
```
##### there are also Player Dropwdowns Which Value Changes Everytime A player Joins (the values are players' users)
```lua
LeftGroupBox:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'A player dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Player dropdown got changed:', Value)
    end
})
```

### Adding Color Pickers:
##### Color Pickers Are A Staple of Customisable Scripts. The Color Pickers Can be Used For almost Anything~
```lua
LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})

Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)
```

### Adding Keybinds:
##### Keybinds Are Extremely Cool Parts of Awesome GUIs, They Are Used For Fly (eg.) Or UI Toggles And More!
```lua
LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Auto lockpick safes', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New)
    end
})
```
#### How To Make A keybind Toggle The UI (this will be shown later as well)
##### use this for eg. Your Configs Tab.
```lua
LeftGroupBox:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
```

# Not All Components Are here, These Are Just What I Feel Nessecary And Cool.

___________________________________________________________________________________________________________________________________________________________________________

# Page 4: Coding The UI Settings And Finishing Your Code

### Creating A Groupbox For The Settings tab:
##### It's Reccomended To Call This Box Different (eg. MenuGroup)
```lua
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
--[[ You can add a credits tab too eg.
local CreditsBox = Tabs['UI Settings']:AddRightGroupbox('Credits')
take note i wont be putting how to make credits here, u can use labels or buttons.]]
```

### Adding A Close GUI Button As Well As A UI Toggling Keybind
```lua
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
```

## And That's It Basically For The essentials! The next page Will Show The Addons And How You Can Apply them ()

____________________________________________________________________________________________________________________________________________________________________________

# Page 5: Addons

### What Addons? The Addons For LinoriaUI are the Thememanager And The SaveManager. Apply the Code To The bottom of your Code
```lua
-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
```

























