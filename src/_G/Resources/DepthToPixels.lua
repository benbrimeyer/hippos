local mathtan = math.tan
local mathrad = math.rad
local Camera = workspace.CurrentCamera

--Scale factor. Ratio of studs to pixels at given depth
local function DepthToPixels(Depth)
	local Viewport 	= Camera.ViewportSize
	local Ratio 	= Viewport.X/Viewport.Y
	local h 		= mathtan(mathrad(Camera.FieldOfView)*0.5)
	
	return Viewport.X/(2*Depth*h*Ratio)
end

return DepthToPixels