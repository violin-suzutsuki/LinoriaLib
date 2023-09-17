local SaveManager = {} do
	SaveManager.Folder 					= "Fondra/Games/Criminality"
	SaveManager.Ignore 					= {}
	SaveManager.Parser 					= {
		Toggle = {
			Save = function(Index, Object) 
				return { Type = "Toggle", Index = Index, Value = Object.Value } 
			end,
			
			Load = function(Index, Data)
				if Toggles[Index] then 
					Toggles[Index]:SetValue(Data.Value)
				end
			end
		},

		Slider = {
			Save = function(Index, Object)
				return { type = "Slider", Index = Index, Value = tostring(Object.Value) }
			end,

			Load = function(Index, Data)
				if Options[Index] then 
					Options[Index]:SetValue(Data.Value)
				end
			end
		},

		Dropdown = {
			Save = function(Index, Object)
				return { type = "Dropdown", Index = Index, Value = Object.Value, mutli = Object.Multi }
			end,

			Load = function(Index, Data)
				if Options[Index] then 
					Options[Index]:SetValue(Data.Value)
				end
			end
		},

		ColorPicker = {
			Save = function(Index, Object)
				return { type = "ColorPicker", Index = Index, Value = Object.Value:ToHex(), Transparency = Object.Transparency }
			end,

			Load = function(Index, Data)
				if Options[Index] then 
					Options[Index]:SetValueRGB(Color3.fromHex(Data.Value), Data.Transparency)
				end
			end
		},

		KeyPicker = {
			Save = function(Index, Object)
				return { type = "KeyPicker", Index = Index, mode = Object.Mode, key = Object.Value }
			end,

			Load = function(Index, Data)
				if Options[Index] then 
					Options[Index]:SetValue({ Data.key, Data.mode })
				end
			end
		},

		Input = {
			Save = function(Index, Object)
				return { type = "Input", Index = Index, text = Object.Value }
			end,

			Load = function(Index, Data)
				if Options[Index] and type(Data.text) == "string" then
					Options[Index]:SetValue(Data.text)
				end
			end,
		}
	}

	function SaveManager:SetIgnoreIndexes(List)
		for _, Key in next, List do
			self.Ignore[Key] 			= true
		end
	end

	function SaveManager:SetFolder(Folder)
		self.Folder 					= Folder
		self:BuildFolderTree()
	end

	function SaveManager:Save(Name)
		if (not Name) then return false, "No config file is selected." end

		local Path 						= string.format("%s/%s.json", self.Folder, Name)
		local Data 						= { Objects = {} }

		for Index, Toggle in next, Toggles do
			if self.Ignore[Index] then continue end

			table.insert(Data.Objects, self.Parser[Toggle.Type].Save(Index, Toggle))
		end

		for Index, Option in next, Options do
			if not self.Parser[Option.Type] then continue end
			if self.Ignore[Index] then continue end

			table.insert(Data.Objects, self.Parser[Option.Type].Save(Index, Option))
		end	

		local Success, Encoded 			= pcall(Fondra.Services.HttpService.JSONEncode, Fondra.Services.HttpService, Data)
		
		if not Success then return false, "Failed to encode Data." end
		writefile(Path, Encoded)

		return true
	end

	function SaveManager:Load(Name)
		if (not Name) then return false, "No config file is selected." end
		
		local File 						= string.format("%s/%s.json", self.Folder, Name)

		if not isfile(File) then return false, "Invalid file." end

		local Success, Decoded 			= pcall(Fondra.Services.HttpService.JSONDecode, Fondra.Services.HttpService, readfile(File))

		if not Success then return false, "Decode Error." end

		for _, Option in next, Decoded.Objects do
			if self.Parser[Option.Type] then
				task.spawn(function() self.Parser[Option.Type].Load(Option.Index, Option) end)
			end
		end

		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor",
			"ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName",
		})
	end

	function SaveManager:BuildFolderTree()
		local Directorys 				= {}

		self.Folder:gsub("([^/]+)", function(Directory)
			table.insert(Directorys, Directory)
		end)

		for _, Directory in next, Directorys do
			local Directory             = table.concat(Directorys, "/", 1, _)

			if isfolder(Directory) then continue end

			makefolder(Directory)
		end
	end

	function SaveManager:RefreshConfigList()
		local List 						= listfiles(self.Folder)
		local Output			 		= {}

		for i = 1, #List do
			local File  				= List[i]

			if File:sub(-5) == ".json" then
				local Position 			= File:find(".json", 1, true)
				local Start 			= Position
				local Character 		= File:sub(Position, Position)

				while Character ~= "/" and Character ~= "\\" and Character ~= "" do
					Position 			= Position - 1
					Character 			= File:sub(Position, Position)
				end

				if Character == "/" or Character == "\\" then
					table.insert(Output, File:sub(Position + 1, Start - 1))
				end
			end
		end
		
		return Output
	end

	function SaveManager:SetLibrary(Library)
		self.Library 					= Library
	end

	function SaveManager:LoadAutoloadConfig()
		if isfile(string.format("%s/AutoLoad.txt", self.Folder)) then
			local Name 					= readfile(string.format("%s/AutoLoad.txt", self.Folder))
			local Success, Error 		= self:Load(Name)

			if not Success then return self.Library:Notify(string.format("Failed to load autoload config: %s", Error)) end

			self.Library:Notify(string.format("Auto loaded config %q", Name))
		end
	end

	function SaveManager:BuildConfigSection(Tab)
		assert(self.Library, "Must set SaveManager.Library")

		local Section 					= Tab:AddRightGroupbox("Configuration")

		Section:AddInput("SaveManager_ConfigName", { Text = "Config name" })
		Section:AddDropdown("SaveManager_ConfigList", { Text = "Config list", Values = self:RefreshConfigList(), AllowNull = true })

		Section:AddDivider()

		Section:AddButton("Create config", function()
			local Name 					= Options.SaveManager_ConfigName.Value

			if Name:gsub(" ", "") == "" then  return self.Library:Notify("Invalid config name. [Empty]", 2) end

			local Success, Error 		= self:Save(Name)

			if not Success then return self.Library:Notify(string.format("Failed to save config: %s", Error)) end

			self.Library:Notify(string.format("Created config %q", Name))

			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end):AddButton("Load config", function()
			local Name 					= Options.SaveManager_ConfigList.Value
			local Success, Error 		= self:Load(Name)
			
			if not Success then return self.Library:Notify(string.format("Failed to load config: %s", Error)) end

			self.Library:Notify(string.format("Loaded config %q", Name))
		end)

		Section:AddButton("Overwrite config", function()
			local Name 					= Options.SaveManager_ConfigList.Value
			local Success, Error 		= self:Save(Name)

			if not Success then return self.Library:Notify(string.format("Failed to override config: %s", Error)) end

			self.Library:Notify(string.format("Overwrote config %q", Name))
		end)

		Section:AddButton("Refresh list", function()
			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end)

		Section:AddButton("Set as autoload", function()
			local Name 					= Options.SaveManager_ConfigList.Value

			writefile(string.format("%s/AutoLoad.txt", self.Folder), Name)
			SaveManager.AutoloadLabel:SetText(string.format("Current autoload config: %s", Name))
			self.Library:Notify(string.format("Set %q to auto load", Name))
		end)

		SaveManager.AutoloadLabel 		= Section:AddLabel("Current autoload config: none", true)

		if isfile(string.format("%s/AutoLoad.txt", self.Folder)) then
			local Name 					= readfile(string.format("%s/AutoLoad.txt", self.Folder))
			SaveManager.AutoloadLabel:SetText(string.format("Current autoload config: %s", Name))
		end

		SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
	end
end

return SaveManager
