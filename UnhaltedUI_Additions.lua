local UnhaltedUI_Additions = CreateFrame("Frame")
local UH = {}
UnhaltedUI_Additions:RegisterEvent("PLAYER_LOGIN")
UnhaltedUI_Additions:RegisterEvent("ADDON_LOADED")
UnhaltedUI_Additions:SetScript("OnEvent", function(self, event, ...) if event == "PLAYER_LOGIN" then UH:CreateUI() end end)
function UH:CreateBackdrops()
    if C_AddOns.IsAddOnLoaded("Details") then
        local DDMBackdrop = CreateFrame("Frame", "DDMBackdrop", UIParent, "BackdropTemplate")
        DDMBackdrop:SetFrameStrata("LOW")
        DDMBackdrop:SetWidth(227)
        DDMBackdrop:SetHeight(201)
        DDMBackdrop:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -1, 1)
        DDMBackdrop:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = true, tileSize = 1, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        DDMBackdrop:SetBackdropColor(20/255, 20/255, 20/255, 1.0)
        DDMBackdrop:SetBackdropBorderColor(0, 0, 0, 1.0)
        local DHMBackdrop = CreateFrame("Frame", "DHMBackdrop", UIParent, "BackdropTemplate")
        DHMBackdrop:SetFrameStrata("LOW")
        DHMBackdrop:SetWidth(226)
        DHMBackdrop:SetHeight(201)
        DHMBackdrop:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -229, 1)
        DHMBackdrop:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = true, tileSize = 1, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        DHMBackdrop:SetBackdropColor(20/255, 20/255, 20/255, 1.0)
        DHMBackdrop:SetBackdropBorderColor(0, 0, 0, 1.0)
    end
    if C_AddOns.IsAddOnLoaded("Prat-3.0") then
        local PratBackdrop = CreateFrame("Frame", "PratBackdrop", UIParent, "BackdropTemplate")
        PratBackdrop:SetFrameStrata("LOW")
        PratBackdrop:SetWidth(454)
        PratBackdrop:SetHeight(201)
        PratBackdrop:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 1, 1)
        PratBackdrop:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = true, tileSize = 1, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        PratBackdrop:SetBackdropColor(20/255, 20/255, 20/255, 1.0)
        PratBackdrop:SetBackdropBorderColor(0, 0, 0, 1.0)
        for i=1,NUM_CHAT_WINDOWS do 
            local ChatFrameScrollBar = _G["ChatFrame"..i].ScrollBar ChatFrameScrollBar:UnregisterAllEvents() ChatFrameScrollBar:SetScript("OnShow", ChatFrameScrollBar.Hide) ChatFrameScrollBar:Hide();
            local ChatTab = _G["ChatFrame"..i.."Tab"]
            local ChatFrame = ("ChatFrame%d"):format(i)
            local ChatFrames = _G[ChatFrame]
            ChatFrames:SetShadowColor(0, 0, 0, 0)
            ChatTab:Hide()
            ChatTab.Show = ChatTab.Hide
        end
        C_Timer.After(0.1, function() ChatFrame1EditBox:ClearAllPoints() ChatFrame1EditBox:SetPoint("TOPLEFT", PratBackdrop, "TOPLEFT", 2, -2) ChatFrame1EditBox:SetWidth(450) end)
    end
end
function UH:AutoLootPlus()
    local AutoLootPlus = CreateFrame("Frame")
    AutoLootPlus:RegisterEvent("LOOT_READY")
    AutoLootPlus:SetScript("OnEvent", function()
        if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            for i = GetNumLootItems(), 1, -1 do
                LootSlot(i)
            end
        end
    end)
end
function UH:ImproveBlizzardUI()
    CharacterLevelText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    CharacterLevelText:SetShadowOffset(0, 0)
    CharacterLevelText:SetShadowColor(0, 0, 0, 0)
    CharacterFrameTitleText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    CharacterFrameTitleText:SetShadowOffset(0, 0)
    CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0)
    ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetShadowOffset(0, 0)
    ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetShadowColor(0, 0, 0, 0)
    ErrorFont:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    ErrorFont:SetShadowOffset(0, 0)
    ErrorFont:SetShadowColor(0, 0, 0, 0)
    ZoneTextFont:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    ZoneTextFont:SetShadowOffset(0, 0)
    ZoneTextFont:SetShadowColor(0, 0, 0, 0)
    SubZoneTextFont:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    SubZoneTextFont:SetShadowOffset(0, 0)
    SubZoneTextFont:SetShadowColor(0, 0, 0, 0)
    PVPInfoTextFont:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    PVPInfoTextFont:SetShadowOffset(0, 0)
    PVPInfoTextFont:SetShadowColor(0, 0, 0, 0)
    PVPArenaTextString:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    PVPArenaTextString:SetShadowOffset(0, 0)
    PVPArenaTextString:SetShadowColor(0, 0, 0, 0)
    ChatBubbleFont:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    ChatBubbleFont:SetShadowOffset(0, 0)
    ChatBubbleFont:SetShadowColor(0, 0, 0, 0)
end
SLASH_SHOWBARS1 = "/bars"
SlashCmdList["SHOWBARS"] = function() if C_AddOns.IsAddOnLoaded("Bartender4") then local function t(n) Bartender4.Bar.barregistry[n]:SetVisibilityOption("always",not Bartender4.Bar.barregistry[n]:GetVisibilityOption("always")) end t("1") t("2") t("3") t("4") end end
function UH:CreateUI()
    UH:CreateBackdrops()
    UH:AutoLootPlus()
    UH:ImproveBlizzardUI()
end
