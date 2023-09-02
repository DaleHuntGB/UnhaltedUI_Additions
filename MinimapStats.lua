local UnhaltedUI_Additions = CreateFrame("Frame")
UnhaltedUI_Additions:RegisterEvent("PLAYER_LOGIN")

--[[ Time Frame ]]--
TimeFrame = CreateFrame("Frame", "UH_TimeFrame", Minimap)
TimeFrame:ClearAllPoints()
TimeFrame:SetPoint(TimeFrameAnchorFrom, Minimap, TimeFrameAnchorTo, TimeFrameXOffset, TimeFrameYOffset)
TimeFrameText = TimeFrame:CreateFontString("UH_TimeFrameText", "BACKGROUND")
TimeFrameText:ClearAllPoints()
TimeFrameText:SetPoint("BOTTOM", TimeFrame, "BOTTOM", 0, 0)
TimeFrameText:SetFont(Font, TimeFrameFontSize, FontOutline)
TimeFrameText:SetTextColor(PrimaryFontColor[1], PrimaryFontColor[2], PrimaryFontColor[3])
TimeFrameText:SetText(FetchTime())
TimeFrame:SetHeight(TimeFrameText:GetStringHeight() or 24)
TimeFrame:SetWidth(TimeFrameText:GetStringWidth() or 200)

-- [[ Date Frame ]] --
DateFrame = CreateFrame("Frame", "UH_DateFrame", Minimap)
DateFrame:ClearAllPoints()
DateFrame:SetPoint(DateFrameAnchorFrom, TimeFrame, DateFrameAnchorTo, DateFrameXOffset, DateFrameYOffset)
DateFrameText = DateFrame:CreateFontString("UH_DateFrameText", "BACKGROUND")
DateFrameText:ClearAllPoints()
DateFrameText:SetPoint("BOTTOM", DateFrame, "BOTTOM", 0, 0)
DateFrameText:SetFont(Font, DateFrameFontSize, FontOutline)
DateFrameText:SetTextColor(PrimaryFontColor[1], PrimaryFontColor[2], PrimaryFontColor[3])
DateFrameText:SetText(FetchDate())
DateFrame:SetHeight(DateFrameText:GetStringHeight() or 24)
DateFrame:SetWidth(DateFrameText:GetStringWidth() or 200)

--[[ Date Frame: Event Registeration ]]--
DateFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

--[[ Location Frame ]]--
LocationFrame = CreateFrame("Frame", "UH_LocationFrame", Minimap)
LocationFrame:ClearAllPoints()
LocationFrame:SetPoint(LocationFrameAnchorFrom, Minimap, LocationFrameAnchorTo, LocationFrameXOffset, LocationFrameYOffset)
LocationFrameText = LocationFrame:CreateFontString("UH_LocationFrameText", "BACKGROUND")
LocationFrameText:ClearAllPoints()
LocationFrameText:SetPoint("TOP", LocationFrame, "TOP", 0, 0)
LocationFrameText:SetFont(Font, LocationFrameFontSize, FontOutline)
LocationFrameText:SetText(FetchLocation())
LocationFrameText:SetWidth(Minimap:GetWidth() * 80/100)
LocationFrameText:CanWordWrap()
LocationFrame:SetHeight(LocationFrameText:GetStringHeight() or 24)
LocationFrame:SetWidth(LocationFrameText:GetStringWidth() or 200)

--[[ Location Frame: Event Registeration ]]--
LocationFrame:RegisterEvent("ZONE_CHANGED")
LocationFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
LocationFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
LocationFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

--[[ Information Frame ]]--
InformationFrame = CreateFrame("Frame", "UH_InformationFrame", Minimap)
InformationFrame:ClearAllPoints()
InformationFrame:SetPoint(InformationFrameAnchorFrom, Minimap, InformationFrameAnchorTo, InformationFrameXOffset, InformationFrameYOffset)
InformationFrameText = InformationFrame:CreateFontString("UH_InformationFrameText", "BACKGROUND")
InformationFrameText:ClearAllPoints()
InformationFrameText:SetPoint("BOTTOM", InformationFrame, "BOTTOM", 0, 0)
InformationFrameText:SetFont(Font, InformationFrameFontSize, FontOutline)
InformationFrameText:SetTextColor(PrimaryFontColor[1], PrimaryFontColor[2], PrimaryFontColor[3])
InformationFrameText:SetText(FetchInformation())
InformationFrame:SetHeight(InformationFrameText:GetStringHeight() or 24)
InformationFrame:SetWidth(InformationFrameText:GetStringWidth() or 200)

--[[ Instance Difficulty Frame ]]--
InstanceDifficultyFrame = CreateFrame("Frame", "UH_InstanceDifficultyFrame", Minimap)
InstanceDifficultyFrame:ClearAllPoints()
InstanceDifficultyFrame:SetPoint(InstanceDifficultyFrameAnchorFrom, Minimap, InstanceDifficultyFrameAnchorTo, InstanceDifficultyFrameXOffset, InstanceDifficultyFrameYOffset)
InstanceDifficultyFrameText = InstanceDifficultyFrame:CreateFontString("UH_InstanceDifficultyFrameText", "BACKGROUND")
InstanceDifficultyFrameText:ClearAllPoints()
InstanceDifficultyFrameText:SetPoint("TOPLEFT", InstanceDifficultyFrame, "TOPLEFT", 0, 0)
InstanceDifficultyFrameText:SetFont(Font, InstanceDifficultyFrameFontSize, FontOutline)
InstanceDifficultyFrameText:SetText(FetchInstanceDifficulty())
InstanceDifficultyFrame:SetHeight(InstanceDifficultyFrameText:GetStringHeight() or 24)
InstanceDifficultyFrame:SetWidth(InstanceDifficultyFrameText:GetStringWidth() or 200)

--[[ Instance Difficulty Frame: Event Registeration ]]--
InstanceDifficultyFrame:RegisterEvent("ZONE_CHANGED")
InstanceDifficultyFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
InstanceDifficultyFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
InstanceDifficultyFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
InstanceDifficultyFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
InstanceDifficultyFrame:RegisterEvent("WORLD_STATE_TIMER_START")

--[[ Scripts ]]--
TimeFrame:SetScript("OnUpdate", UpdateTimeFrame)
DateFrame:SetScript("OnEvent", UpdateDateFrame)
DateFrame:SetScript("OnMouseDown", function(self, button) if button == "LeftButton" then ToggleCalendar() end end)
LocationFrame:SetScript("OnEvent", UpdateLocationFrame)
InformationFrame:SetScript("OnUpdate", UpdateInformationFrame)
InformationFrame:SetScript("OnMouseDown", function(self, button) if button == "MiddleButton" then ReloadUI() end end)
InstanceDifficultyFrame:SetScript("OnEvent", UpdateInstanceDifficultyFrame)

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
CinematicFrame:HookScript("OnShow", function(self, ...)	CinematicFrame_CancelCinematic() print("|cFF8080FFCinematic Skipped|r") end)
