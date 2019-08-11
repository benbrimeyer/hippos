local mathtan = math.tan
local mathrad = math.rad
local Camera = workspace.CurrentCamera

--Scale
local function PixelsToDepth(Pixels)
	local Viewport 	= Camera.ViewportSize
	local Ratio 	= Viewport.X/Viewport.Y
	local h 		= mathtan(mathrad(Camera.FieldOfView)*0.5)
	
	return Viewport.X/(2*Pixels*h*Ratio)
end

return PixelsToDepth