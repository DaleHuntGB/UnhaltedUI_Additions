---@diagnostic disable: redundant-parameter, param-type-mismatch
-- [[ Hide Scroll Bars, Chat Tabs & Font Shadows ]] -- 
if IsAddOnLoaded("Prat-3.0") then
	for i=1,NUM_CHAT_WINDOWS do 
		local ChatFrameScrollBar = _G["ChatFrame"..i].ScrollBar ChatFrameScrollBar:UnregisterAllEvents() ChatFrameScrollBar:SetScript("OnShow", ChatFrameScrollBar.Hide) ChatFrameScrollBar:Hide();
		local ChatTab = _G["ChatFrame"..i.."Tab"]
		local ChatFrame = ("ChatFrame%d"):format(i)
		local ChatFrames = _G[ChatFrame]
		ChatFrames:SetShadowColor(0, 0, 0, 0)
		ChatTab:Hide()
		ChatTab.Show = ChatTab.Hide
	end
end

-- [[ Faster Auto Loot ]] --
local AutoLootPlus = CreateFrame("Frame")
AutoLootPlus:RegisterEvent("LOOT_READY")
AutoLootPlus:SetScript("OnEvent", function()
	if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
		for i = GetNumLootItems(), 1, -1 do
			LootSlot(i)
		end
	end
end)











