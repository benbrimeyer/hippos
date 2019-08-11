function PointOfIntersection (s1, e1, s2, e2)
  local d = (s1.x - e1.x) * (s2.y - e2.y) - (s1.y - e1.y) * (s2.x - e2.x)
  local a = s1.x * e1.y - s1.y * e1.x
  local b = s2.x * e2.y - s2.y * e2.x
  local x = (a * (s2.x - e2.x) - (s1.x - e1.x) * b) / d
  local y = (a * (s2.y - e2.y) - (s1.y - e1.y) * b) / d
  return Vector2.new(x, y)
end


local function IsIntersecting( a, b, c, d )
    local denominator 	= ((b.X - a.X) * (d.Y - c.Y)) - ((b.Y - a.Y) * (d.X - c.X));
    local numerator1 	= ((a.Y - c.Y) * (d.X - c.X)) - ((a.X - c.X) * (d.Y - c.Y));
    local numerator2 	= ((a.Y - c.Y) * (b.X - a.X)) - ((a.X - c.X) * (b.Y - a.Y));

    -- Detect coincident lines (has a problem, read below)
    if (denominator == 0) then return numerator1 == 0 and numerator2 == 0 end

    local r = numerator1 / denominator;
    local s = numerator2 / denominator;
	
	local Intersected = (r >= 0 and r <= 1) and (s >= 0 and s <= 1);
	
	if Intersected then
		return true, PointOfIntersection(a,b,c,d)
	else
		return false
	end
end

return IsIntersecting