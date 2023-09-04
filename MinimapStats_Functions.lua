local GetAddOnName = C_AddOns.GetAddOnMetadata("MinimapStats", "Title")
local AddOnName = "|cFF8080FF"..GetAddOnName.."|r"

local TimeFrame_LastUpdate = 0
local InformationFrame_LastUpdate = 0

function FetchTime()
    local CurrentHour = date("%H")
    local CurrentMins = date("%M")
    local TwoFourHourTime = CurrentHour .. ":" .. CurrentMins

    return TwoFourHourTime
end

--[[ function FetchDate()
    local CurrentDay = date("%d")
    local CurrentMonth = date("%b")
    local CurrentYear = date("%y")
    local CurrentDate = CurrentDay .. " " .. CurrentMonth .. " " .. CurrentYear

    return CurrentDate
end ]]


function FetchLocation()
    return "|c" .. SecondaryFontColor .. GetMinimapZoneText() .. "|r"
end

function FetchInformation()
    local FPS = ceil(GetFramerate())
    local _, _, HomeMS, WorldMS = GetNetStats()

    local FPSText = FPS .. "|c" .. SecondaryFontColor .. " FPS " .. "|r"
    local HomeMSText = HomeMS .. "|c" .. SecondaryFontColor .. " MS" .. "|r"
    local WorldMSText = WorldMS .. "|c" .. SecondaryFontColor .. " MS" .. "|r"

    local FPSHomeMS = FPSText .. "[" .. HomeMSText .. "]"
    local FPSWorldMS = FPSText .. "[" .. WorldMSText .. "]"
    local FPSOnly = FPSText
    local HomeMSOnly = HomeMSText
    local WorldMSOnly = WorldMSText
    local MSOnly = HomeMSText .. " [" .. WorldMSText .. "]"

    return FPSHomeMS
end

function FetchInstanceDifficulty()
    local _, _, InstanceDifficulty, _, _, _, _, InstanceID, InstanceSize = GetInstanceInfo()
    local KeystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()
    local InstanceDifficultyIndicator = MinimapCluster.InstanceDifficulty
    local InstanceIndicator = InstanceDifficultyIndicator and InstanceDifficultyIndicator.Instance or _G["MiniMapInstanceDifficulty"]
    local GuildIndicator = InstanceDifficultyIndicator and InstanceDifficultyIndicator.Guild or _G["GuildInstanceDifficulty"]
    local ChallengeIndicator = InstanceDifficultyIndicator and InstanceDifficultyIndicator.ChallengeMode or _G["MiniMapChallengeMode"]
    local InGarrison = InstanceID == 1152 or InstanceID == 1153 or InstanceID == 1154 or InstanceID == 1158 or InstanceID == 1159 or InstanceID == 1160
        if InstanceIndicator then 
            InstanceIndicator:ClearAllPoints() 
            InstanceIndicator:SetAlpha(0) 
        end
        if GuildIndicator then 
            GuildIndicator:ClearAllPoints()
            GuildIndicator:SetAlpha(0) 
        end
        if ChallengeIndicator then 
            ChallengeIndicator:ClearAllPoints()
            ChallengeIndicator:SetAlpha(0) 
        end			

        if InstanceDifficulty == 0 then -- No Instance
            return " "
        elseif InGarrison then -- Garrison
            return " "
        elseif InstanceDifficulty == 1 then -- Normal Dungeon
            return "5" .. "|c" .. SecondaryFontColor .. "N" .."|r"
        elseif InstanceDifficulty == 2 then -- Heroic Dungeon
            return "5" .. "|c" .. SecondaryFontColor .. "H" .."|r"
        elseif InstanceDifficulty == 23 then -- Mythic Dungeon
            return "5" .. "|c" .. SecondaryFontColor .. "M" .."|r"
        elseif InstanceDifficulty == 8 then -- Mythic+ Dungeon
            return "+" .. "|c" .. SecondaryFontColor .. KeystoneLevel .."|r"
        elseif InstanceDifficulty == 24 then -- Timewalking Dungeon
            return "|cFF" .. SecondaryFontColor .. "TW" .. "|r"			
        elseif InstanceDifficulty == 3 then -- 10M Normal Raid
            return "10" .. "|c" .. SecondaryFontColor .. "N" .."|r"
        elseif InstanceDifficulty == 5 then -- 10M Heroic Raid
            return "10" .. "|c" .. SecondaryFontColor .. "H" .."|r"
        elseif InstanceDifficulty == 4 then -- 25M Normal Raid
            return "25" .. "|c" .. SecondaryFontColor .. "N" .."|r"
        elseif InstanceDifficulty == 6 then -- 25M Heroic Raid
            return "25" .. "|c" .. SecondaryFontColor .. "H" .."|r"
        elseif InstanceDifficulty == 9 then -- 40M Raid
            return "40" .. "|c" .. SecondaryFontColor .. "N" .."|r"
        elseif InstanceDifficulty == 33 then -- Timewalking Raid
            return "|c" .. SecondaryFontColor .. InstanceSize .. "|r" .. "TW"
        elseif InstanceDifficulty == 17 then -- Timewalking Raid
            return "|c" .. SecondaryFontColor .. InstanceSize .. "|r" .. "LFR"					
        elseif InstanceDifficulty == 14 then -- Normal Flex Raid
            return "|c" .. SecondaryFontColor .. InstanceSize .. "|r" .. "N"
        elseif InstanceDifficulty == 15 then -- Heroic Flex Raid
            return "|c" .. SecondaryFontColor .. InstanceSize .. "|r" .. "H"
        elseif InstanceDifficulty == 16 then -- Mythic Raid
            return "|c" .. SecondaryFontColor .. InstanceSize .. "|r" .. "M"
        end
end

function UpdateTimeFrame(TimeFrame, ElapsedTime)
    TimeFrame_LastUpdate = TimeFrame_LastUpdate + ElapsedTime
    if TimeFrame_LastUpdate > TimeFrame_UpdateFrequency then
        TimeFrame_LastUpdate = 0
        TimeFrameText:SetText(FetchTime())
        if DebugMode then 
            print(AddOnName..": Time Updated")
        end
    end
end

--[[ function UpdateDateFrame(DateFrame, FrameEvent)
    if FrameEvent == "PLAYER_ENTERING_WORLD" then
        DateFrameText:SetText(FetchDate())
        if DebugMode then 
            print(AddOnName..": Date Updated")
        end
    end
end ]]

function UpdateLocationFrame(LocationFrame, FrameEvent)
    if FrameEvent == "ZONE_CHANGED" or FrameEvent == "ZONE_CHANGED_INDOORS" or FrameEvent == "ZONE_CHANGED_NEW_AREA" or FrameEvent == "PLAYER_ENTERING_WORLD" then
        LocationFrameText:SetText(FetchLocation())
        if DebugMode then 
            print(AddOnName..": Location Updated")
        end
    end
end

function UpdateInformationFrame(InformationFrame, ElapsedTime)
    InformationFrame_LastUpdate = InformationFrame_LastUpdate + ElapsedTime
    if InformationFrame_LastUpdate > InformationFrame_UpdateFrequency then
        InformationFrame_LastUpdate = 0
        InformationFrameText:SetText(FetchInformation())
        if DebugMode then 
            print(AddOnName..": Information Updated")
        end
    end
end

function UpdateInstanceDifficultyFrame(InstanceDifficultyFrame, FrameEvent)
    if FrameEvent == "ZONE_CHANGED" or FrameEvent == "ZONE_CHANGED_INDOORS" or FrameEvent == "ZONE_CHANGED_NEW_AREA" or FrameEvent == "PLAYER_ENTERING_WORLD" or FrameEvent == "GROUP_ROSTER_UPDATE" or FrameEvent == "WORLD_STATE_TIME_START" then
        InstanceDifficultyFrameText:SetText(FetchInstanceDifficulty())
        if DebugMode then 
            print(AddOnName..": Instance Difficulty Updated")
        end
    end
end