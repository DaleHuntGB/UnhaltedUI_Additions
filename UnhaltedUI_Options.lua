-- [[ MinimapStats Options ]] --
Font = "Fonts\\FRIZQT__.ttf"
FontOutline = "THINOUTLINE"
PrimaryFontColor = {1.0, 1.0, 1.0, 1}
SecondaryFontColor = (RAID_CLASS_COLORS)[select(2, UnitClass("player"))]:GenerateHexColor()
DebugMode = false
AddOnName = C_AddOns.GetAddOnMetadata("UnhaltedUI_Additions", "Title")

-- [[ Font Sizes ]] --
TimeFrameFontSize = 21
DateFrameFontSize = 12
LocationFrameFontSize = 12
InformationFrameFontSize = 12
InstanceDifficultyFrameFontSize = 12

-- [[ Position ]] --
TimeFrameAnchorFrom = "BOTTOM"
TimeFrameAnchorTo = "BOTTOM"
TimeFrameXOffset = 0
TimeFrameYOffset = 17

DateFrameAnchorFrom = "BOTTOM"
DateFrameAnchorTo = "TOP"
DateFrameXOffset = 0
DateFrameYOffset = 3

LocationFrameAnchorFrom = "TOP"
LocationFrameAnchorTo = "TOP"
LocationFrameXOffset = 0
LocationFrameYOffset = -3

InformationFrameAnchorFrom = "BOTTOM"
InformationFrameAnchorTo = "BOTTOM"
InformationFrameXOffset = 0
InformationFrameYOffset = 3

InstanceDifficultyFrameAnchorFrom = "TOPLEFT"
InstanceDifficultyFrameAnchorTo = "TOPLEFT"
InstanceDifficultyFrameXOffset = 3
InstanceDifficultyFrameYOffset = -3

-- [[ Update Frequency ]] --
TimeFrame_UpdateFrequency = 3 
InformationFrame_UpdateFrequency = 5

