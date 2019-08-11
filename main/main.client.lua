print("Hello world (client)")

-- import global space
local Hippo = game:GetService("ReplicatedStorage").Packages.Hippo
require(Hippo._G.GlobalSpace)
_G.RegisterResource("World", require(Hippo.World))

local World = _G.GetResource("World")
local core = World.core

core:registerComponentsInInstance(Hippo.Components)
core:registerSystemsInInstance(Hippo.Systems)

core:registerStepper(World.event(game:GetService("RunService").Stepped, {
	require(Hippo.Systems.Collision),
	require(Hippo.Systems.Solver),
	require(Hippo.Systems.Render),
}))

core:start()