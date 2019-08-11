function DeriveAngle(a, b) -- in degrees, vectors a and b
	return math.deg(math.acos((a.unit:Dot(b.unit))/(a.magnitude * b.magnitude)))
end

return DeriveAngle