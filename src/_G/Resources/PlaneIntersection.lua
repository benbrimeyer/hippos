local Vector3new = Vector3.new

function PlaneIntersection(Origin, Direction, Level)
	local planePosition 	= Vector3new(0,Level,0)-- some point ON the plane (X)
	local planeNormal 		= Vector3new(0,1,0)-- the direction normal (perpendicular) to the plane (N)
	
	local rayPosition 		= Origin-- the start of the ray (P)
	local rayDirection 		= Direction-- the direction of the ray (V)
	
	local t = (planePosition - rayPosition):Dot(planeNormal)
	    / rayDirection:Dot(planeNormal)
	
	local intersection 		= rayPosition + t * rayDirection
	
	return intersection
end

return PlaneIntersection