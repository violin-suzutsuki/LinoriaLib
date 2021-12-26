Library = loadstring(game:HttpGet('https://lindseyhost.com/UI/LinoriaLib.lua'))();

local Fonts = {};
for Font, _ in next, Drawing.Fonts do
	table.insert(Fonts, Font);
end;

local TestWindow = Library:CreateWindow('window title');
Library:SetWatermark('watermark!!! (hi)');
Library:Notify('Loading UI...');

local LegitTab = TestWindow:AddTab('Legit');
local LegitTabbox1 = LegitTab:AddLeftTabbox('Aimbot');
local lAimbot1 = LegitTabbox1:AddTab('Aimbot');
lAimbot1:AddToggle('Aimbot', { Text = 'Aimbot' }):AddKeyPicker('Test', { Text = 'Aimbot', Default = 'X' });
lAimbot1:AddToggle('CheckTeam', { Text = 'Team Check' });
lAimbot1:AddToggle('CheckVis', { Text = 'Visibility Check' });
lAimbot1:AddToggle('VisPriority', { Text = 'Prioritize Visibles' });
lAimbot1:AddToggle('IgnoreFOV', { Text = 'Ignore FOV' });
lAimbot1:AddSlider('FOV', { Text = 'Aimbot FOV', Default = 10, Min = 0, Max = 10, Rounding = 1 });
lAimbot1:AddSlider('SwitchDelay', { Text = 'Switch Delay', Default = 0, Min = 0, Max = 1000, Rounding = 0, Suffix = 'ms' });
lAimbot1:AddSlider('HeadshotPercent', { Text = 'Headshot %', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' });

local lAimbot2 = LegitTabbox1:AddTab('Silent Aim');
lAimbot2:AddLabel('Nothing here :)');

local lAimbotSettings = LegitTab:AddRightTabbox();

local LegitSettings = lAimbotSettings:AddTab('Aimbot Settings');
LegitSettings:AddSlider('AimTime', { Text = 'Smoothing', Default = 0, Min = 0, Max = 2000, Rounding = 0, Suffix = 'ms' });
LegitSettings:AddToggle('AimbotClosest', { Text = 'Aim at Closest Part' });

local VisualsTab = TestWindow:AddTab('Visuals');

local ESP = VisualsTab:AddLeftTabbox();
local EnemyESP = ESP:AddTab('Enemy ESP');
EnemyESP:AddToggle('Nametags', { Text = 'Nametags' }):AddColorPicker('nColor', { Default = Color3.new(1, 1, 1) });
EnemyESP:AddToggle('Distance', { Text = 'Display Distance' });
EnemyESP:AddToggle('Boxes', { Text = 'Boxes' }):AddColorPicker('vbColor', { Default = Color3.new(0, 1, 0) }):AddColorPicker('nvbColor', { Default = Color3.new(1, 0, 0) });
EnemyESP:AddToggle('Healthbar', { Text = 'Healthbars' }):AddColorPicker('hColor', { Default = Color3.new(0, 1, 0) });

local ESPSettings = ESP:AddTab('ESP Settings');
ESPSettings:AddSlider('FontSize', { Text = 'Font Size', Default = 14, Min = 8, Max = 24, Rounding = 0 });
ESPSettings:AddDropdown('SelectedFont', { Text = 'ESP Font', Default = 1, Values = Fonts });

local SettingsTab = TestWindow:AddTab('Settings');

local function UpdateTheme()
    Library.BackgroundColor = Options.BackgroundColor.Value;
    Library.MainColor = Options.MainColor.Value;
    Library.AccentColor = Options.AccentColor.Value;
    Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);
    Library.OutlineColor = Options.OutlineColor.Value;
    Library.FontColor = Options.FontColor.Value;

    Library:UpdateColorsUsingRegistry();
end;

local function SetDefault()
    Options.FontColor:SetValueRGB(Color3.fromRGB(255, 255, 255));
    Options.MainColor:SetValueRGB(Color3.fromRGB(28, 28, 28));
    Options.BackgroundColor:SetValueRGB(Color3.fromRGB(20, 20, 20));
    Options.AccentColor:SetValueRGB(Color3.fromRGB(0, 85, 255));
    Options.OutlineColor:SetValueRGB(Color3.fromRGB(50, 50, 50));
    Toggles.Rainbow:SetValue(false);

    UpdateTheme();
end;

local Theme = SettingsTab:AddLeftGroupbox('Theme');
Theme:AddLabel('Background Color'):AddColorPicker('BackgroundColor', { Default = Library.BackgroundColor });
Theme:AddLabel('Main Color'):AddColorPicker('MainColor', { Default = Library.MainColor });
Theme:AddLabel('Accent Color'):AddColorPicker('AccentColor', { Default = Library.AccentColor });
Theme:AddToggle('Rainbow', { Text = 'Rainbow Accent Color' });
Theme:AddLabel('Outline Color'):AddColorPicker('OutlineColor', { Default = Library.OutlineColor });
Theme:AddLabel('Font Color'):AddColorPicker('FontColor', { Default = Library.FontColor });
Theme:AddButton('Default Theme', SetDefault);
Theme:AddToggle('Keybinds', { Text = 'Show Keybinds Menu', Default = true }):OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.Keybinds.Value;
end);
Theme:AddToggle('Watermark', { Text = 'Show Watermark', Default = true }):OnChanged(function()
    Library:SetWatermarkVisibility(Toggles.Watermark.Value);
end);

task.spawn(function()
    while game:GetService('RunService').RenderStepped:Wait() do
        if Toggles.Rainbow.Value then
            local Registry = TestWindow.Holder.Visible and Library.Registry or Library.HudRegistry;

            for Idx, Object in next, Registry do
                for Property, ColorIdx in next, Object.Properties do
                    if ColorIdx == 'AccentColor' or ColorIdx == 'AccentColorDark' then
                        local Instance = Object.Instance;
                        local yPos = Instance.AbsolutePosition.Y;

                        local Mapped = Library:MapValue(yPos, 0, 1080, 0, 0.5) * 1.5;
                        local Color = Color3.fromHSV((Library.CurrentRainbowHue - Mapped) % 1, 0.8, 1);

                        if ColorIdx == 'AccentColorDark' then
                            Color = Library:GetDarkerColor(Color);
                        end;

                        Instance[Property] = Color;
                    end;
                end;
            end;
        end;
    end;
end);

Toggles.Rainbow:OnChanged(function()
    if not Toggles.Rainbow.Value then
        UpdateTheme();
    end;
end);

Options.BackgroundColor:OnChanged(UpdateTheme);
Options.MainColor:OnChanged(UpdateTheme);
Options.AccentColor:OnChanged(UpdateTheme);
Options.OutlineColor:OnChanged(UpdateTheme);
Options.FontColor:OnChanged(UpdateTheme);

Library:Notify('Loaded UI!');