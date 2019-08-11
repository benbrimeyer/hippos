local function CountTab(tab)
	local c = 0;
	local ordered = {};
	
	for i,v in pairs(tab) do
		c = c + 1
		ordered[c] = v
	end
	
	return c, ordered
end


return CountTab