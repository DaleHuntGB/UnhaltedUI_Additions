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
-- [[ Auto Vendor Greys ]] -- 
if AutoVendorGreys then
	local AutoSellPlus = CreateFrame("Frame")
	AutoSellPlus:RegisterEvent("MERCHANT_SHOW")
	AutoSellPlus:SetScript("OnEvent", function()
		for BackpackContainer = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
			local BackpackSlots = C_Container.GetContainerNumSlots(BackpackContainer)
			for BackpackSlot = 1, BackpackSlots do
				local BackpackInfo = C_Container.GetContainerItemInfo(BackpackContainer, BackpackSlot)
				if BackpackInfo and BackpackInfo.quality == 0 and not BackpackInfo.hasNoValue then
					C_Container.UseContainerItem(BackpackContainer, BackpackSlot)
				end
			end
		end
	end)
end

-- [[ Auto Select Gossip Option ]] --
if AutoSelectGossip then
	local AutoGossipPlus = CreateFrame("Frame")
	AutoGossipPlus:RegisterEvent("GOSSIP_SHOW")
	AutoGossipPlus:SetScript("OnEvent", function()
		local GossipOptions = C_GossipInfo.GetOptions()
		if #GossipOptions <= 1 then
			if not IsShiftKeyDown() then
				local GossipOption = C_GossipInfo.GetOptions()
				C_GossipInfo.SelectOption(GossipOption[1].gossipOptionID)
			end
		end
	end)
end

-- [[ Auto Hand In & Accept Quests ]] --
if AutoQuests then
	local AutoQuestPlus = CreateFrame("Frame")
	AutoQuestPlus:RegisterEvent("QUEST_GREETING")
	AutoQuestPlus:RegisterEvent("QUEST_DETAIL")
	AutoQuestPlus:SetScript("OnEvent", function() 
		if not IsShiftKeyDown() then

			-- Complete Quests
			for QuestIndex = 1, GetNumActiveQuests() do
				local _, IsCompleted = GetActiveTitle(QuestIndex)
				if IsCompleted and not C_QuestLog.IsWorldQuest(GetActiveQuestID(QuestIndex)) then
					SelectActiveQuest(QuestIndex)
				end
			end

			-- Accept Quests
			for QuestIndex = 1, GetNumAvailableQuests() do
				local IsTrivial, _, IsDaily, _, _ = GetAvailableQuestInfo(QuestIndex)
				if not IsTrivial and not IsDaily then
					SelectAvailableQuest(QuestIndex)
				end
			end

			if QuestIsFromAreaTrigger() then
				AcceptQuest()
			elseif QuestGetAutoAccept() then
				AcknowledgeAutoAcceptQuest()
			elseif not C_QuestLog.IsQuestTrivial(GetQuestID()) then
				AcceptQuest()
			end
		end
	end)
end

-- [[ Print Options ]] --
if HideTalkingHeadFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Talking Head Frame: |cFF40FF40Enabled|r") else if HideTalkingHeadFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Talking Head Frame: |cFFFF4040Disabled|r") end end
if HideBossBannerFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Boss Banner Frame: |cFF40FF40Enabled|r") else if HideBossBannerFrame then print("|cFF8080FFUnhaltedUI Additions|r: Hide Boss Banner Frame: |cFFFF4040Disabled|r") end end
if AutoVendorGreys then print("|cFF8080FFUnhaltedUI Additions|r: Auto Vendor Greys: |cFF40FF40Enabled|r") else if AutoVendorGreys then print("|cFF8080FFUnhaltedUI Additions|r: Auto Vendor Greys: |cFFFF4040Disabled|r") end end
if AutoSelectGossip then print("|cFF8080FFUnhaltedUI Additions|r: Auto Select Gossip: |cFF40FF40Enabled|r") else if AutoSelectGossip then print("|cFF8080FFUnhaltedUI Additions|r: Auto Select Gossip: |cFFFF4040Disabled|r") end end
if AutoQuests then print("|cFF8080FFUnhaltedUI Additions|r: Auto Quests: |cFF40FF40Enabled|r") else if AutoQuests then print("|cFF8080FFUnhaltedUI Additions|r: Auto Quests: |cFFFF4040Disabled|r") end end
if SkipCinematics then print("|cFF8080FFUnhaltedUI Additions|r: Skip Cinematics: |cFF40FF40Enabled|r") else if SkipCinematics then print("|cFF8080FFUnhaltedUI Additions|r: Skip Cinematics: |cFFFF4040Disabled|r") end end











