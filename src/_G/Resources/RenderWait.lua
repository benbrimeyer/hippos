function RenderWait(Duration)
	local Start = tick();
	repeat game:GetService("RunService").RenderStepped:wait() until tick()-Start >= Duration
end

return RenderWait