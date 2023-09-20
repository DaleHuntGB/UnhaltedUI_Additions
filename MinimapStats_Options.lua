-- [[ MinimapStats Options ]] --
Font = "Fonts\\FRIZQT__.ttf"
FontOutline = "THINOUTLINE"
PrimaryFontColor = {1.0, 1.0, 1.0, 1}
SecondaryFontColor = (RAID_CLASS_COLORS)[select(2, UnitClass("player"))]:GenerateHexColor()
DebugMode = false

-- [[ Font Sizes ]] --
TimeFrameFontSize = 16
LocationFrameFontSize = 12
InformationFrameFontSize = 12
InstanceDifficultyFrameFontSize = 12

-- [[ Position ]] --
TimeFrameAnchorFrom = "BOTTOM"
TimeFrameAnchorTo = "BOTTOM"
TimeFrameXOffset = 0
TimeFrameYOffset = 17

LocationFrameAnchorFrom = "TOP"
LocationFrameAnchorTo = "TOP"
LocationFrameXOffset = 0
LocationFrameYOffset = -3

InformationFrameAnchorFrom = "TOP"
InformationFrameAnchorTo = "BOTTOM"
InformationFrameXOffset = 0
InformationFrameYOffset = -3

InstanceDifficultyFrameAnchorFrom = "TOPLEFT"
InstanceDifficultyFrameAnchorTo = "TOPLEFT"
InstanceDifficultyFrameXOffset = 3
InstanceDifficultyFrameYOffset = -3

-- [[ Update Frequency ]] --
TimeFrame_UpdateFrequency = 3 
InformationFrame_UpdateFrequency = 5
--[[ InformationFrame_UpdateFrequency_OutOfCombat = 5
InformationFrame_UpdateFrequency_InCombat = 15 ]]

-- [[ UnhaltedUI Options ]] --
HideTalkingHeadFrame = true 
HideBossBannerFrame = true
AutoVendorGreys = true
AutoSelectGossip = true
AutoQuests = true
SkipCinematics = true


