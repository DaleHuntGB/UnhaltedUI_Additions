local UnhaltedUI_Additions = CreateFrame("Frame")
local UH = {}
local _, class = UnitClass("player")
local classColor = RAID_CLASS_COLORS[class]
local UHNormal = "Fonts\\FRIZQT__.TTF"
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
function UH:SetFont(obj, font, size, style, sR, sG, sB, sA, sX, sY, r, g, b, a)
	if not obj then return end
	if style == 'NONE' or not style then style = '' end
	local shadow = strsub(style, 0, 6) == 'SHADOW'
	if shadow then style = strsub(style, 7) end -- shadow isnt a real style
	obj:SetFont(font, size, style)
	obj:SetShadowColor(sR or 0, sG or 0, sB or 0, sA or (shadow and (style == '' and 1 or 0.6)) or 0)
	obj:SetShadowOffset(sX or (shadow and 1) or 0, sY or (shadow and -1) or 0)
	if r and g and b then
		obj:SetTextColor(r, g, b)
	end
	if a then
		obj:SetAlpha(a)
	end
end
function UH:ImproveBlizzardUI()
-- Set font and properties for CharacterLevelText
UH:SetFont(CharacterLevelText, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for CharacterFrameTitleText
UH:SetFont(CharacterFrameTitleText, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for ErrorFont
UH:SetFont(ErrorFont, UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for ZoneTextFont
UH:SetFont(ZoneTextFont, UHNormal, 24, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for SubZoneTextFont
UH:SetFont(SubZoneTextFont, UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for PVPInfoTextFont
UH:SetFont(PVPInfoTextFont, UHNormal, 24, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for PVPArenaTextString
UH:SetFont(PVPArenaTextString, UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for ChatBubbleFont
UH:SetFont(ChatBubbleFont, UHNormal, 10, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for ActionStatus Text
UH:SetFont(ActionStatus.Text, UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

-- Set font and properties for CharacterStatsPane ItemLevelCategory Title
UH:SetFont(CharacterStatsPane.ItemLevelCategory.Title, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, classColor.r, classColor.g, classColor.b, 1.0)

-- Set alpha transparency for CharacterStatsPane ItemLevelFrame Value and Background
CharacterStatsPane.ItemLevelFrame.Value:SetAlpha(0)
CharacterStatsPane.ItemLevelFrame.Background:SetAlpha(0)

-- Set font and properties for CharacterStatsPane AttributesCategory Title
UH:SetFont(CharacterStatsPane.AttributesCategory.Title, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, classColor.r, classColor.g, classColor.b, 1.0)

-- Set font and properties for CharacterStatsPane EnhancementsCategory Title
UH:SetFont(CharacterStatsPane.EnhancementsCategory.Title, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, classColor.r, classColor.g, classColor.b, 1.0)

-- ElvUI Font Control
UH:SetFont(GameFontNormal, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalSmall, UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalLarge, UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalHuge, UHNormal, 20, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(QuestFontNormalSmall, UHNormal, 12, "NONE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(QuestFont, UHNormal, 14, "NONE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(QuestTitleFont, UHNormal, 16, "NONE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalMed2, UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(SystemFont_Huge2, UHNormal, 20, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalMed3, UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(BossEmoteNormalHuge, UHNormal, 20, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(SystemFont16_Shadow_ThickOutline, UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)

end
SLASH_SHOWBARS1 = "/bars"
SlashCmdList["SHOWBARS"] = function() if C_AddOns.IsAddOnLoaded("Bartender4") then local function t(n) Bartender4.Bar.barregistry[n]:SetVisibilityOption("always",not Bartender4.Bar.barregistry[n]:GetVisibilityOption("always")) end t("1") t("2") t("3") t("4") end end

-- Define a function for the custom slash command
local function MyPrintCommand(msg)
    -- Execute the provided Lua code
    local result = assert(loadstring("return " .. msg))()
    
    -- Check if there's any result to print
    if result then
        DEFAULT_CHAT_FRAME:AddMessage(tostring(result))
    end
end

-- Register the slash command with its function
SLASH_MYPRINT1 = "/print"
SlashCmdList["MYPRINT"] = MyPrintCommand



function UH:CreateUI()
    UH:CreateBackdrops()
    UH:AutoLootPlus()
    UH:ImproveBlizzardUI()
end
