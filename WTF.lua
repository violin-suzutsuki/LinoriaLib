-- Ignore this is for fondra.

Fondra.DownloadAsset("Sounds/WTF.mp3", "https://github.com/lncoognito/Assets/raw/main/Sounds/WTF.wav")

local Sound 		= Instance.new("Sound")
Sound.Parent 		= workspace
Sound.Volume		= 2.5
Sound.SoundId   	= Fondra.GetAsset("Sounds/WTF.mp3")
Sound:Play()

Fondra.Services.Debris:AddItem(Sound, 5)
