# LinoriaLib
 
Library:CreateWindow(<string> Title)
returns <Window>

<Window> class:
	Window:SetWindowTitle(<string> Title)
	sets window title to Title

	Window:AddTab(<string> TabName)
	returns <Tab>

<Tab> class:
	Tab:AddLeftTabbox(<string> TabboxName)
	returns <Tabbox>

	Tab:AddRightTabbox(<string> TabboxName)
	returns <Tabbox>

	Tab:AddLeftGroupbox(<string> GroupboxName)
	returns <Container>

	Tab:AddRightGroupbox(<string> GroupboxName)
	returns <Container>

<Tabbox> class:
	function Tabbox:AddTab(<string> TabName)
	returns <Container>

<Container> class:
	function Container:AddLabel(<string> LabelText)
	returns <Label, extends BaseAddons>

	function Container:AddToggle(<string> Idx, <dictionary> Info)
	Info -> {
		<bool> Default
		<string> Text
	}
	returns <Toggle, extends BaseAddons>

	function Container:AddButton(<string> ButtonText, <function> Callback)
	returns <Button>

	function Container:AddInput(<string> Idx, <dictionary> Info)
	Info -> {
		<string> Default
		<string> Text
	}
	returns <Input>

	function Container:AddSlider(<string> Idx, <dictionary> Info)
	Info -> {
		<int> Default
		<int> Min
		<int> Max
		<int> Rounding (0 = 0 decimal place, 1 = 1 decimal place, etc)
		<string> Suffix
		<string> Text
	}
	returns <Slider>

	function Container:AddDropdown(<string> Idx, <dictionary> Info)
	Info -> {
		<string> Text
		<int> Default (default idx within Values table, can be left null)
		<table> Values
		<bool> AllowNull
		<bool> Multi
	}
	returns <Dropdown>

<BaseAddons> class:
	BaseAddons:AddKeyPicker(<string> Idx, <dictionary> Info)
	Info -> {
		<string> Default
		<string> Mode: Always, Toggle, Held (defaults to Toggle)
		<bool> NoUI (true = hide from Keybinds menu)
	}
	returns <KeyPicker>

	BaseAddons:AddColorPicker(Idx, <dictionary> Info)
	Info -> {
		<Color3> Default
	}
	returns <ColorPicker>
