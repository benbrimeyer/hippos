--returns a new cframe such that (new cframe)*(old cframe)^-1*a = b
--Q*u = v
--Q^2 = (d, c)
--Q = unit(Q^2 + 1)
local function MinimalRotation(cf, a, b)
	local u = a.unit
	local v = b.unit
	local c = u:Cross(v)
	local d = u:Dot(v)
	local q = CFrame.new(0, 0, 0, c.x, c.y, c.z, d + 1)
	local p = cf.p
	local r = cf - p
	return q*r + p
end

return MinimalRotation