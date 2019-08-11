function AnalyzeBins()
	local GlobalSpace = _G.GetSystem("GlobalSpace")
	
	for BinId, Bin in pairs(GlobalSpace.Bins) do
		local Contents = 0;
		
		for _,_ in pairs(Bin) do
			Contents = Contents + 1
		end
		
		print("Bin: ", BinId, " | Entries: ", Contents)
	end
end

return AnalyzeBins