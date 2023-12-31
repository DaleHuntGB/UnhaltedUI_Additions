local MinimapStats = CreateFrame("Frame")
MinimapStats:RegisterEvent("PLAYER_LOGIN")

--[[ Time Frame ]]--
TimeFrame = CreateFrame("Frame", "UH_TimeFrame", Minimap)
TimeFrame:ClearAllPoints()
TimeFrame:SetPoint(TimeFrameAnchorFrom, Minimap, TimeFrameAnchorTo, TimeFrameXOffset, TimeFrameYOffset)
TimeFrameText = TimeFrame:CreateFontString("UH_TimeFrameText", "BACKGROUND")
TimeFrameText:ClearAllPoints()
TimeFrameText:SetPoint("CENTER", TimeFrame, "CENTER", 0, 0)
TimeFrameText:SetFont(Font, TimeFrameFontSize, FontOutline)
TimeFrameText:SetTextColor(PrimaryFontColor[1], PrimaryFontColor[2], PrimaryFontColor[3])
TimeFrameText:SetText(FetchTime())
TimeFrame:SetHeight(TimeFrameText:GetStringHeight() or 24)
TimeFrame:SetWidth(TimeFrameText:GetStringWidth() or 200)

--[[ Location Frame ]]--
LocationFrame = CreateFrame("Frame", "UH_LocationFrame", Minimap)
LocationFrame:ClearAllPoints()
LocationFrame:SetPoint(LocationFrameAnchorFrom, Minimap, LocationFrameAnchorTo, LocationFrameXOffset, LocationFrameYOffset)
LocationFrameText = LocationFrame:CreateFontString("UH_LocationFrameText", "BACKGROUND")
LocationFrameText:ClearAllPoints()
LocationFrameText:SetPoint("CENTER", LocationFrame, "CENTER", 0, 0)
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
InformationFrame:SetPoint(InformationFrameAnchorFrom, TimeFrame, InformationFrameAnchorTo, InformationFrameXOffset, InformationFrameYOffset)
InformationFrameText = InformationFrame:CreateFontString("UH_InformationFrameText", "BACKGROUND")
InformationFrameText:ClearAllPoints()
InformationFrameText:SetPoint("CENTER", InformationFrame, "CENTER", 0, 0)
InformationFrameText:SetFont(Font, InformationFrameFontSize, FontOutline)
InformationFrameText:SetTextColor(PrimaryFontColor[1], PrimaryFontColor[2], PrimaryFontColor[3])
InformationFrameText:SetText(FetchInformation())
InformationFrame:SetHeight(InformationFrameText:GetStringHeight() or 24)
InformationFrame:SetWidth(InformationFrameText:GetStringWidth() or 200)

--[[ Information Frame: Event Registeration ]]--
InformationFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
InformationFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
InformationFrame:RegisterEvent("ENCOUNTER_START")
InformationFrame:RegisterEvent("ENCOUNTER_END")
InformationFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

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
TimeFrame:SetScript("OnMouseDown", function(self, button) if button == "LeftButton" then ToggleCalendar() end end)
LocationFrame:SetScript("OnEvent", UpdateLocationFrame)
InformationFrame:SetScript("OnUpdate", UpdateInformationFrame)
--[[ InformationFrame:SetScript("OnEvent", UpdateInformationFrame) ]]
InformationFrame:SetScript("OnMouseDown", function(self, button) if button == "MiddleButton" then ReloadUI() end end)
InstanceDifficultyFrame:SetScript("OnEvent", UpdateInstanceDifficultyFrame)
