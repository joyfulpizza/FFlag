--// Lag Reducer Hub (Client-Sided FE)
--// Uses Rayfield UI

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "FFLAG hub universal",
	LoadingTitle = "use if lag",
	LoadingSubtitle = "Made by joyful_pizza(@98wg7 on roblox)",
	ConfigurationSaving = {
		Enabled = false
	}
})

--// Toggle states
local Settings = {
	RemoveTextures = false,
	RemoveColors = false,
	RemoveParticles = false,
	ParticleLoop = false,
	RemoveAccessoryColors = false,
	RemoveAccessories = false,
	RemoveCollidingParts = false
}

--// ================= TAB 1 =================
local TexturesTab = Window:CreateTab("Textures", 4483362458)

TexturesTab:CreateToggle({
	Name = "Remove Textures",
	CurrentValue = false,
	Callback = function(v)
		Settings.RemoveTextures = v
	end
})

TexturesTab:CreateToggle({
	Name = "Remove Colors (!WARNING!)",
	CurrentValue = false,
	Callback = function(v)
		Settings.RemoveColors = v
	end
})

--// ================= TAB 2 =================
local ParticlesTab = Window:CreateTab("Particles", 4483362458)

ParticlesTab:CreateToggle({
	Name = "Remove Particles",
	CurrentValue = false,
	Callback = function(v)
		Settings.RemoveParticles = v
	end
})

ParticlesTab:CreateToggle({
	Name = "Remove Particles every 0.25s (may lag)",
	CurrentValue = false,
	Callback = function(v)
		Settings.ParticleLoop = v
	end
})

--// ================= TAB 3 =================
local AccessoriesTab = Window:CreateTab("Accessories", 4483362458)

AccessoriesTab:CreateToggle({
	Name = "Remove Accessory Color",
	CurrentValue = false,
	Callback = function(v)
		Settings.RemoveAccessoryColors = v
	end
})

AccessoriesTab:CreateToggle({
	Name = "Remove Accessories",
	CurrentValue = false,
	Callback = function(v)
		Settings.RemoveAccessories = v
	end
})

--// ================= TAB 4 =================
local PartsTab = Window:CreateTab("Parts", 4483362458)

PartsTab:CreateToggle({
	Name = "Remove Colliding Parts",
	CurrentValue = false,
	Callback = function(v)
		Settings.RemoveCollidingParts = v
	end
})

--// ================= FUNCTIONS =================

local function RemoveTextures()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then
			v:Destroy()
		end
	end
end

local function RemoveColors()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Color = Color3.new(0.5,0.5,0.5)
			v.Material = Enum.Material.Plastic
		end
	end
end

local function RemoveParticlesOnce()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter")
		or v:IsA("Trail")
		or v:IsA("Beam") then
			v.Enabled = false
			v:Destroy()
		end
	end
end

local function StartParticleLoop()
	task.spawn(function()
		while Settings.ParticleLoop do
			RemoveParticlesOnce()
			task.wait(0.25)
		end
	end)
end

local function HandleAccessories()
	for _,char in ipairs(workspace:GetChildren()) do
		if char:FindFirstChildOfClass("Humanoid") then
			for _,acc in ipairs(char:GetChildren()) do
				if acc:IsA("Accessory") then
					if Settings.RemoveAccessoryColors then
						for _,p in ipairs(acc:GetDescendants()) do
							if p:IsA("BasePart") then
								p.Color = Color3.new(0.5,0.5,0.5)
								p.Material = Enum.Material.Plastic
							end
						end
					end
					if Settings.RemoveAccessories then
						acc:Destroy()
					end
				end
			end
		end
	end
end

local function RemoveCollidingParts()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart")
		and v.CanCollide
		and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then
			if #v:GetTouchingParts() > 3 then
				v:Destroy()
			end
		end
	end
end

--// ================= TAB 5 =================
local DeliverTab = Window:CreateTab("Deliver", 4483362458)

DeliverTab:CreateButton({
	Name = "Do what you selected (1~4) and destroy GUI",
	Callback = function()
		if Settings.RemoveTextures then RemoveTextures() end
		if Settings.RemoveColors then RemoveColors() end
		if Settings.RemoveParticles then RemoveParticlesOnce() end
		if Settings.ParticleLoop then StartParticleLoop() end
		if Settings.RemoveAccessoryColors or Settings.RemoveAccessories then
			HandleAccessories()
		end
		if Settings.RemoveCollidingParts then
			RemoveCollidingParts()
		end

		task.wait(0.2)
		Rayfield:Destroy()
	end
})

DeliverTab:CreateButton({
	Name = "Ultra No Lag Selection (!WARNING!)",
	Callback = function()
		Settings.RemoveTextures = true
		Settings.RemoveColors = true
		Settings.RemoveParticles = true
		Settings.ParticleLoop = false
		Settings.RemoveAccessoryColors = true
		Settings.RemoveAccessories = true
		Settings.RemoveCollidingParts = true

		RemoveTextures()
		RemoveColors()
		RemoveParticlesOnce()
		HandleAccessories()
		RemoveCollidingParts()

		task.wait(0.2)
		Rayfield:Destroy()
	end
})
