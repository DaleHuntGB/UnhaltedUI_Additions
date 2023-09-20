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

-- [[ Skip Cinematics ]] --
if SkipCinematics then
	MovieFrame_PlayMovie = function(...) GameMovieFinished() print("|cFF8080FFCinematic Skipped|r") end
	CinematicFrame:HookScript("OnShow", function(self, ...)	CinematicFrame_CancelCinematic() print("|cFF8080FFUnhaltedUI Additions|r: Cinematic Skipped") end)
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

-- [[ Hide Talking Head Frame ]] -- 
if HideTalkingHeadFrame then
	TalkingHeadFrame:SetScript("OnShow", function() TalkingHeadFrame:Hide() end)
end

-- [[ Hide Boss Banner Frame ]] --
if HideBossBannerFrame then
	BossBanner:SetScript("OnShow", function() BossBanner:Hide() end)
end 

local AutoLootPlus = CreateFrame("Frame")
AutoLootPlus:RegisterEvent("LOOT_READY")
AutoLootPlus:SetScript("OnEvent", function()
	if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
		for i = GetNumLootItems(), 1, -1 do
			LootSlot(i)
		end
	end
end)

-- [[ Print Options ]] --
if HideTalkingHeadFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Talking Head Frame: |cFF40FF40Enabled|r") else if HideTalkingHeadFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Talking Head Frame: |cFFFF4040Disabled|r") end end
if HideBossBannerFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Boss Banner Frame: |cFF40FF40Enabled|r") else if HideBossBannerFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Boss Banner Frame: |cFFFF4040Disabled|r") end end
if SkipCinematics then print("|cFF8080FFUnhaltedUI Additions|r: Skip Cinematics: |cFF40FF40Enabled|r") else if SkipCinematics then print("|cFF8080FFUnhaltedUI Additions|r: Skip Cinematics: |cFFFF4040Disabled|r") end end











