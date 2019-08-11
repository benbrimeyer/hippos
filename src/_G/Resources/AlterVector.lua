local XAXIS=Vector3.new(1,0,0)
local ZAXIS=Vector3.new(0,0,1)

local function perp(v)
	v=v.unit
	if v==XAXIS then
		return v:Cross(ZAXIS)
	else
		return v:Cross(XAXIS)
	end
end

local function misdirectvec(unitvec,deflection)	--Thanks to Stravant
	if deflection<=0 then
		return unitvec
	end
	local basex=perp(unitvec).unit
	local basey=basex:Cross(unitvec).unit
	local rot=2*math.pi*math.random()
	local turnedAxis=basex*math.cos(rot)+basey*math.sin(rot)
	return unitvec*math.cos(deflection)+turnedAxis*math.sin(deflection)
end

return misdirectvec