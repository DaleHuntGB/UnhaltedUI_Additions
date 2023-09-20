-- [[ Hide Scroll Bars, Chat Tabs & Font Shadows ]] -- 
for i=1,NUM_CHAT_WINDOWS do 
    local ChatFrameScrollBar = _G["ChatFrame"..i].ScrollBar ChatFrameScrollBar:UnregisterAllEvents() ChatFrameScrollBar:SetScript("OnShow", ChatFrameScrollBar.Hide) ChatFrameScrollBar:Hide();
    local ChatTab = _G["ChatFrame"..i.."Tab"]
    local ChatFrame = ("ChatFrame%d"):format(i)
	local ChatFrames = _G[ChatFrame]
    ChatFrames:SetShadowColor(0, 0, 0, 0)
	ChatTab:Hide()
	ChatTab.Show = ChatTab.Hide
end

-- [[ Skip Cinematics ]] --
MovieFrame_PlayMovie = function(...) GameMovieFinished() print("|cFF8080FFCinematic Skipped|r") end
CinematicFrame:HookScript("OnShow", function(self, ...)	CinematicFrame_CancelCinematic() print("|cFF8080FFUnhaltedUI Additions|r: Cinematic Skipped") end)

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