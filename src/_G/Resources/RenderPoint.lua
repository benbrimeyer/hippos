function RenderPoint(CF, Color)
	local P = Instance.new("Part")
	P.Anchored = true;
	P.CanCollide = false;
	P.Size = Vector3.new(0.5,0.5,0.5);
	P.Color = Color or Color3.new(math.random(),math.random(),math.random());
	P.CFrame = CF;
	P.Parent = workspace;
	P.Material = "Neon"
	P.Transparency = 0.5
	P.TopSurface = 0
	P.BottomSurface = 0
	P.Name = "DEBUG_POINT";
	
	return P
end

return RenderPoint