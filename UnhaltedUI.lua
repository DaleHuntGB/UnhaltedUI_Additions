local UnhaltedUI = LibStub("AceAddon-3.0"):NewAddon("UnhaltedUI")
local UnhaltedUIGUI = LibStub("AceGUI-3.0")
local AddOnName = C_AddOns.GetAddOnMetadata("UnhaltedUI", "Title")
local AddOnVersion = C_AddOns.GetAddOnMetadata("UnhaltedUI", "Version")
local AddOnAuthor = C_AddOns.GetAddOnMetadata("UnhaltedUI", "Author")
local Class = select(2, UnitClass("player"))
local ClassColor = RAID_CLASS_COLORS[Class]
local LSM = LibStub("LibSharedMedia-3.0")
local LSMBackdrops = {}
local LSMBorders = {}
local UH = {}
local GUIW = 750
local GUIH = 800
local GUIOpen = false
local AnchorPoints = {
    [1] = "TOPLEFT",
    [2] = "TOP",
    [3] = "TOPRIGHT",
    [4] = "LEFT",
    [5] = "CENTER",
    [6] = "RIGHT",
    [7] = "BOTTOMLEFT",
    [8] = "BOTTOM",
    [9] = "BOTTOMRIGHT",
}

-- Default Saved Variables
local DefaultSettings =
{
    global = {
        -- Toggles
        DrawDetailsBackdrops = true,
        DrawPratBackdrops = true,
        FasterAutoLoot = true,
        RemoveChatFontShadows = true,
        HideChatTabs = true,
        HideChatScrollBars = true,
        PositionEditBox = true,
        ReplaceUIFonts = true,
        -- Frame Width / Height
        DetailsDamageMeterW = 227,
        DetailsDamageMeterH = 201,
        DetailsHealingMeterW = 226,
        DetailsHealingMeterH = 201,
        PratW = 454,
        PratH = 201,
        -- Frame Anchors
        DetailsDamageMeterAnchor = "BOTTOMRIGHT",
        DetailsHealingMeterAnchor = "BOTTOMRIGHT",
        PratAnchor = "BOTTOMLEFT",
        -- Frame Positions
        DetailsDamageMeterX = -1,
        DetailsDamageMeterY = 1,
        DetailsHealingMeterX = -229,
        DetailsHealingMeterY = 1,
        PratX = 1,
        PratY = 1,
        -- Backdrop Colours
        DetailsDamageMeterColour = {r = 20/255, g = 20/255, b = 20/255, a = 1.0},
        DetailsHealingMeterColour = {r = 20/255, g = 20/255, b = 20/255, a = 1.0},
        PratColour = {r = 20/255, g = 20/255, b = 20/255, a = 1.0},
        -- Backdrop Textures
        DetailsDamageMeterBackdrop = 'Interface\\Buttons\\WHITE8X8',
        DetailsHealingMeterBackdrop = 'Interface\\Buttons\\WHITE8X8',
        PratBackdrop = 'Interface\\Buttons\\WHITE8X8',
        -- Border Textures
        DetailsDamageMeterBorder = 'Interface\\Buttons\\WHITE8X8',
        DetailsHealingMeterBorder = 'Interface\\Buttons\\WHITE8X8',
        PratBorder = 'Interface\\Buttons\\WHITE8X8',
        -- Edge Size
        DetailsDamageMeterEdgeSize = 1,
        DetailsHealingMeterEdgeSize = 1,
        PratEdgeSize = 1,
        -- UI Font
        UHNormal = 'Fonts\\FRIZQT__.ttf',
    }
}

function UnhaltedUI:OnInitialize()
    UH.db = LibStub("AceDB-3.0"):New("UnhaltedUIDB", DefaultSettings)
end

function UnhaltedUI:OnEnable()
    UH:FetchLSM()
    UH:CreateUI()
end

function UH:CreateUI()
    -- Update Details Damage Meter Backdrop
    if UH.db.global.DrawDetailsBackdrops then
        if not DetailsDamageMeterBackdrop then DetailsDamageMeterBackdrop = CreateFrame("Frame", "DetailsDamageMeterBackdrop", UIParent, "BackdropTemplate") end
        DetailsDamageMeterBackdrop:SetFrameStrata("LOW")
        DetailsDamageMeterBackdrop:SetWidth(UH.db.global.DetailsDamageMeterW)
        DetailsDamageMeterBackdrop:SetHeight(UH.db.global.DetailsDamageMeterH)
        DetailsDamageMeterBackdrop:ClearAllPoints()
        DetailsDamageMeterBackdrop:SetPoint(UH.db.global.DetailsDamageMeterAnchor, UIParent, UH.db.global.DetailsDamageMeterAnchor, UH.db.global.DetailsDamageMeterX, UH.db.global.DetailsDamageMeterY)
        DetailsDamageMeterBackdrop:SetBackdrop({bgFile = UH.db.global.DetailsDamageMeterBackdrop, edgeFile = UH.db.global.DetailsDamageMeterBorder, tile = false, tileSize = 0, edgeSize = UH.db.global.DetailsDamageMeterEdgeSize, insets = {left = 0, right = 0, top = 0, bottom = 0}})
        DetailsDamageMeterBackdrop:SetBackdropColor(UH.db.global.DetailsDamageMeterColour.r, UH.db.global.DetailsDamageMeterColour.g, UH.db.global.DetailsDamageMeterColour.b, UH.db.global.DetailsDamageMeterColour.a)
        DetailsDamageMeterBackdrop:SetBackdropBorderColor(0, 0, 0, 1)
        DetailsDamageMeterBackdrop:Show()
    else
        DetailsDamageMeterBackdrop:Hide()
    end
    -- Update Details Healing Meter Backdrop
    if UH.db.global.DrawDetailsBackdrops then
        if not DetailsHealingMeterBackdrop then DetailsHealingMeterBackdrop = CreateFrame("Frame", "DetailsHealingMeterBackdrop", UIParent, "BackdropTemplate") end
        DetailsHealingMeterBackdrop:SetFrameStrata("LOW")
        DetailsHealingMeterBackdrop:SetWidth(UH.db.global.DetailsHealingMeterW)
        DetailsHealingMeterBackdrop:SetHeight(UH.db.global.DetailsHealingMeterH)
        DetailsHealingMeterBackdrop:ClearAllPoints()
        DetailsHealingMeterBackdrop:SetPoint(UH.db.global.DetailsHealingMeterAnchor, UIParent, UH.db.global.DetailsHealingMeterAnchor, UH.db.global.DetailsHealingMeterX, UH.db.global.DetailsHealingMeterY)
        DetailsHealingMeterBackdrop:SetBackdrop({bgFile = UH.db.global.DetailsHealingMeterBackdrop, edgeFile = UH.db.global.DetailsHealingMeterBorder, tile = false, tileSize = 0, edgeSize = UH.db.global.DetailsHealingMeterEdgeSize, insets = {left = 0, right = 0, top = 0, bottom = 0}})
        DetailsHealingMeterBackdrop:SetBackdropColor(UH.db.global.DetailsHealingMeterColour.r, UH.db.global.DetailsHealingMeterColour.g, UH.db.global.DetailsHealingMeterColour.b, UH.db.global.DetailsHealingMeterColour.a)
        DetailsHealingMeterBackdrop:SetBackdropBorderColor(0, 0, 0, 1)
        DetailsHealingMeterBackdrop:Show()
    else
        DetailsHealingMeterBackdrop:Hide()
    end
    -- Update Prat Backdrop
    if UH.db.global.DrawPratBackdrops then
        if not PratBackdrop then PratBackdrop = CreateFrame("Frame", "PratBackdrop", UIParent, "BackdropTemplate") end
        PratBackdrop:SetFrameStrata("LOW")
        PratBackdrop:SetWidth(UH.db.global.PratW)
        PratBackdrop:SetHeight(UH.db.global.PratH)
        PratBackdrop:ClearAllPoints()
        PratBackdrop:SetPoint(UH.db.global.PratAnchor, UIParent, UH.db.global.PratAnchor, UH.db.global.PratX, UH.db.global.PratY)
        PratBackdrop:SetBackdrop({bgFile = UH.db.global.PratBackdrop, edgeFile = UH.db.global.PratBorder, tile = false, tileSize = 0, edgeSize = UH.db.global.PratEdgeSize, insets = {left = 0, right = 0, top = 0, bottom = 0}})
        PratBackdrop:SetBackdropColor(UH.db.global.PratColour.r, UH.db.global.PratColour.g, UH.db.global.PratColour.b, UH.db.global.PratColour.a)
        PratBackdrop:SetBackdropBorderColor(0, 0, 0, 1)
        PratBackdrop:Show()
    else
        PratBackdrop:Hide()
    end
    -- Chat Options
    for i=1,NUM_CHAT_WINDOWS do
        if UH.db.global.HideScrollBars then
            local ChatFrameScrollBar = _G["ChatFrame"..i].ScrollBar ChatFrameScrollBar:UnregisterAllEvents() ChatFrameScrollBar:SetScript("OnShow", ChatFrameScrollBar.Hide) ChatFrameScrollBar:Hide();
        end
        if UH.db.global.HideChatTabs then
            local ChatTab = _G["ChatFrame"..i.."Tab"]
            ChatTab:Hide()
            ChatTab.Show = ChatTab.Hide
        end
        if UH.db.global.RemoveChatFontShadows then
            local ChatFrame = ("ChatFrame%d"):format(i)
            local ChatFrames = _G[ChatFrame]
            ChatFrames:SetShadowColor(0, 0, 0, 0)
        end
    end
    if UH.db.global.PositionEditBox then
        C_Timer.After(0.1, function() ChatFrame1EditBox:ClearAllPoints() ChatFrame1EditBox:SetPoint("TOPLEFT", PratBackdrop, "TOPLEFT", 2, -2) ChatFrame1EditBox:SetWidth(ChatFrame1:GetWidth() - 2) end)
    end

    -- General Options
    if UH.db.global.FasterAutoLoot then
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

    if UH.db.global.ReplaceUIFonts then
        UH:SetUIFonts()
    end
end

function UH:FetchLSM()
    -- Backdrop Textures
    for k, v in pairs(LSM:HashTable("statusbar")) do
        table.insert(LSMBackdrops, k)
    end
    -- Border Textures
    for k, v in pairs(LSM:HashTable("border")) do
        table.insert(LSMBorders, k)
    end
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

function UH:SetUIFonts()
UH:SetFont(CharacterLevelText, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(CharacterFrameTitleText, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(ErrorFont, UH.db.global.UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(ZoneTextFont, UH.db.global.UHNormal, 24, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(SubZoneTextFont, UH.db.global.UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(PVPInfoTextFont, UH.db.global.UHNormal, 24, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(PVPArenaTextString, UH.db.global.UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(ChatBubbleFont, UH.db.global.UHNormal, 10, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(ActionStatus.Text, UH.db.global.UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(CharacterStatsPane.ItemLevelCategory.Title, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, ClassColor.r, ClassColor.g, ClassColor.b, 1.0)
CharacterStatsPane.ItemLevelFrame.Value:SetAlpha(0)
CharacterStatsPane.ItemLevelFrame.Background:SetAlpha(0)
UH:SetFont(CharacterStatsPane.AttributesCategory.Title, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, ClassColor.r, ClassColor.g, ClassColor.b, 1.0)
UH:SetFont(CharacterStatsPane.EnhancementsCategory.Title, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, ClassColor.r, ClassColor.g, ClassColor.b, 1.0)
UH:SetFont(GameFontNormal, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalSmall, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalLarge, UH.db.global.UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalHuge, UH.db.global.UHNormal, 20, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(QuestFontNormalSmall, UH.db.global.UHNormal, 12, "NONE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(QuestFont, UH.db.global.UHNormal, 14, "NONE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(QuestTitleFont, UH.db.global.UHNormal, 16, "NONE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalMed2, UH.db.global.UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(SystemFont_Huge2, UH.db.global.UHNormal, 20, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontNormalMed3, UH.db.global.UHNormal, 14, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(BossEmoteNormalHuge, UH.db.global.UHNormal, 20, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(SystemFont16_Shadow_ThickOutline, UH.db.global.UHNormal, 16, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(FriendsFont_11, UH.db.global.UHNormal, 11, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(FriendsFont_UserText, UH.db.global.UHNormal, 11, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
UH:SetFont(GameFontHighlightSmall2, UH.db.global.UHNormal, 12, "OUTLINE", 0, 0, 0, 0, 0, 0, nil, nil, nil, nil)
end

function UH:UnhaltedGUI()
    local GUIContainer = UnhaltedUIGUI:Create("Frame")
    GUIContainer:SetTitle("UnhaltedUI")
    GUIContainer:SetCallback("OnClose", function(widget) UnhaltedUIGUI:Release(widget) GUIOpen = false end)
    GUIContainer:SetLayout("Fill")
    GUIContainer:SetWidth(GUIW)
    GUIContainer:SetHeight(GUIH)
    GUIContainer:EnableResize(false)

    local function DetailsOptions(GUIContainer)
        local DetailsBackdropToggle = UnhaltedUIGUI:Create("CheckBox")
        DetailsBackdropToggle:SetLabel("Draw Details Backdrops")
        DetailsBackdropToggle:SetValue(UH.db.global.DrawDetailsBackdrops)
        DetailsBackdropToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DrawDetailsBackdrops = value UH:CreateUI() end)
        -- Colour Picker for Details Damage Meter
        local DetailsDamageMeterBackdropColour = UnhaltedUIGUI:Create("ColorPicker")
        DetailsDamageMeterBackdropColour:SetLabel("Damage Meter Backdrop Colour")
        DetailsDamageMeterBackdropColour:SetColor(UH.db.global.DetailsDamageMeterColour.r, UH.db.global.DetailsDamageMeterColour.g, UH.db.global.DetailsDamageMeterColour.b, UH.db.global.DetailsDamageMeterColour.a)
        DetailsDamageMeterBackdropColour:SetCallback("OnValueChanged", function(widget, event, r, g, b, a) UH.db.global.DetailsDamageMeterColour = {r = r, g = g, b = b, a = a} UH:CreateUI() end)
        -- Colour Picker for Details Healing Meter
        local DetailsHealingMeterBackdropColour = UnhaltedUIGUI:Create("ColorPicker")
        DetailsHealingMeterBackdropColour:SetLabel("Healing Meter Backdrop Colour")
        DetailsHealingMeterBackdropColour:SetColor(UH.db.global.DetailsHealingMeterColour.r, UH.db.global.DetailsHealingMeterColour.g, UH.db.global.DetailsHealingMeterColour.b, UH.db.global.DetailsHealingMeterColour.a)
        DetailsHealingMeterBackdropColour:SetCallback("OnValueChanged", function(widget, event, r, g, b, a) UH.db.global.DetailsHealingMeterColour = {r = r, g = g, b = b, a = a} UH:CreateUI() end)
        -- Details Damage Meter Width / Height Inline Group
        local DetailsDamageMeterWH = UnhaltedUIGUI:Create("InlineGroup")
        DetailsDamageMeterWH:SetTitle("Damage Meter Width / Height")
        DetailsDamageMeterWH:SetLayout("Flow")
        DetailsDamageMeterWH:SetFullWidth(true)
        -- Details Damage Meter Width
        local DetailsDamageMeterW = UnhaltedUIGUI:Create("Slider")
        DetailsDamageMeterW:SetLabel("Width")
        DetailsDamageMeterW:SetSliderValues(0, 1000, 1)
        DetailsDamageMeterW:SetFullWidth(true)
        DetailsDamageMeterW:SetValue(UH.db.global.DetailsDamageMeterW)
        DetailsDamageMeterW:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsDamageMeterW = value UH:CreateUI() end)
        -- Details Damage Meter Height
        local DetailsDamageMeterH = UnhaltedUIGUI:Create("Slider")
        DetailsDamageMeterH:SetLabel("Height")
        DetailsDamageMeterH:SetSliderValues(0, 1000, 1)
        DetailsDamageMeterH:SetFullWidth(true)
        DetailsDamageMeterH:SetValue(UH.db.global.DetailsDamageMeterH)
        DetailsDamageMeterH:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsDamageMeterH = value UH:CreateUI() end)
        -- Add Details Damage Meter Width / Height to the Inline Group
        DetailsDamageMeterWH:AddChild(DetailsDamageMeterW)
        DetailsDamageMeterWH:AddChild(DetailsDamageMeterH)
        -- Details Healing Meter Width / Height Inline Group
        local DetailsHealingMeterWH = UnhaltedUIGUI:Create("InlineGroup")
        DetailsHealingMeterWH:SetTitle("Healing Meter Width / Height")
        DetailsHealingMeterWH:SetLayout("Flow")
        DetailsHealingMeterWH:SetFullWidth(true)
        -- Details Healing Meter Width
        local DetailsHealingMeterW = UnhaltedUIGUI:Create("Slider")
        DetailsHealingMeterW:SetLabel("Width")
        DetailsHealingMeterW:SetSliderValues(0, 1000, 1)
        DetailsHealingMeterW:SetFullWidth(true)
        DetailsHealingMeterW:SetValue(UH.db.global.DetailsHealingMeterW)
        DetailsHealingMeterW:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsHealingMeterW = value UH:CreateUI() end)
        -- Details Healing Meter Height
        local DetailsHealingMeterH = UnhaltedUIGUI:Create("Slider")
        DetailsHealingMeterH:SetLabel("Height")
        DetailsHealingMeterH:SetSliderValues(0, 1000, 1)
        DetailsHealingMeterH:SetFullWidth(true)
        DetailsHealingMeterH:SetValue(UH.db.global.DetailsHealingMeterH)
        DetailsHealingMeterH:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsHealingMeterH = value UH:CreateUI() end)
        -- Add Details Healing Meter Width / Height to the Inline Group
        DetailsHealingMeterWH:AddChild(DetailsHealingMeterW)
        DetailsHealingMeterWH:AddChild(DetailsHealingMeterH)
        -- Details Damage Meter Position / Anchor Inline Group
        local DetailsDamageMeterPos = UnhaltedUIGUI:Create("InlineGroup")
        DetailsDamageMeterPos:SetTitle("Damage Meter Position")
        DetailsDamageMeterPos:SetLayout("Flow")
        DetailsDamageMeterPos:SetFullWidth(true)
        -- Details Damage Meter Anchor
        local DetailsDamageMeterAnchor = UnhaltedUIGUI:Create("Dropdown")
        DetailsDamageMeterAnchor:SetLabel("Anchor")
        DetailsDamageMeterAnchor:SetList(AnchorPoints)
        DetailsDamageMeterAnchor:SetFullWidth(true)
        DetailsDamageMeterAnchor:SetValue(UH.db.global.DetailsDamageMeterAnchor)
        DetailsDamageMeterAnchor:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsDamageMeterAnchor = AnchorPoints[value] UH:CreateUI() end)
        -- Details Damage Meter X
        local DetailsDamageMeterX = UnhaltedUIGUI:Create("Slider")
        DetailsDamageMeterX:SetLabel("X")
        DetailsDamageMeterX:SetSliderValues(-1000, 1000, 1)
        DetailsDamageMeterX:SetFullWidth(true)
        DetailsDamageMeterX:SetValue(UH.db.global.DetailsDamageMeterX)
        DetailsDamageMeterX:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsDamageMeterX = AnchorPoints[value] UH:CreateUI() end)
        -- Details Damage Meter Y
        local DetailsDamageMeterY = UnhaltedUIGUI:Create("Slider")
        DetailsDamageMeterY:SetLabel("Y")
        DetailsDamageMeterY:SetSliderValues(-1000, 1000, 1)
        DetailsDamageMeterY:SetFullWidth(true)
        DetailsDamageMeterY:SetValue(UH.db.global.DetailsDamageMeterY)
        DetailsDamageMeterY:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsDamageMeterY = value UH:CreateUI() end)
        -- Add Details Damage Meter Position / Anchor to the Inline Group
        DetailsDamageMeterPos:AddChild(DetailsDamageMeterAnchor)
        DetailsDamageMeterPos:AddChild(DetailsDamageMeterX)
        DetailsDamageMeterPos:AddChild(DetailsDamageMeterY)
        -- Details Healing Meter Position / Anchor Inline Group
        local DetailsHealingMeterPos = UnhaltedUIGUI:Create("InlineGroup")
        DetailsHealingMeterPos:SetTitle("Healing Meter Position")
        DetailsHealingMeterPos:SetLayout("Flow")
        DetailsHealingMeterPos:SetFullWidth(true)
        -- Details Healing Meter Anchor
        local DetailsHealingMeterAnchor = UnhaltedUIGUI:Create("Dropdown")
        DetailsHealingMeterAnchor:SetLabel("Anchor")
        DetailsHealingMeterAnchor:SetList(AnchorPoints)
        DetailsHealingMeterAnchor:SetFullWidth(true)
        DetailsHealingMeterAnchor:SetValue(UH.db.global.DetailsHealingMeterAnchor)
        DetailsHealingMeterAnchor:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsHealingMeterAnchor = AnchorPoints[value] UH:CreateUI() end)
        -- Details Healing Meter X
        local DetailsHealingMeterX = UnhaltedUIGUI:Create("Slider")
        DetailsHealingMeterX:SetLabel("X")
        DetailsHealingMeterX:SetSliderValues(-1000, 1000, 1)
        DetailsHealingMeterX:SetFullWidth(true)
        DetailsHealingMeterX:SetValue(UH.db.global.DetailsHealingMeterX)
        DetailsHealingMeterX:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsHealingMeterX = value UH:CreateUI() end)
        -- Details Healing Meter Y
        local DetailsHealingMeterY = UnhaltedUIGUI:Create("Slider")
        DetailsHealingMeterY:SetLabel("Y")
        DetailsHealingMeterY:SetSliderValues(-1000, 1000, 1)
        DetailsHealingMeterY:SetFullWidth(true)
        DetailsHealingMeterY:SetValue(UH.db.global.DetailsHealingMeterY)
        DetailsHealingMeterY:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DetailsHealingMeterY = value UH:CreateUI() end)
        -- Add Details Healing Meter Position / Anchor to the Inline Group
        DetailsHealingMeterPos:AddChild(DetailsHealingMeterAnchor)
        DetailsHealingMeterPos:AddChild(DetailsHealingMeterX)
        DetailsHealingMeterPos:AddChild(DetailsHealingMeterY)
        -- Add Options to the GUI
        GUIContainer:AddChild(DetailsBackdropToggle)
        GUIContainer:AddChild(DetailsDamageMeterBackdropColour)
        GUIContainer:AddChild(DetailsHealingMeterBackdropColour)
        GUIContainer:AddChild(DetailsDamageMeterWH)
        GUIContainer:AddChild(DetailsHealingMeterWH)
        GUIContainer:AddChild(DetailsDamageMeterPos)
        GUIContainer:AddChild(DetailsHealingMeterPos)
    end

    local function PratOptions(GUIContainer)
        local PratBackdropToggle = UnhaltedUIGUI:Create("CheckBox")
        PratBackdropToggle:SetLabel("Draw Prat Backdrops")
        PratBackdropToggle:SetValue(UH.db.global.DrawPratBackdrops)
        PratBackdropToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.DrawPratBackdrops = value UH:CreateUI() end)
        -- Hide Chat Tabs
        local HideChatTabsToggle = UnhaltedUIGUI:Create("CheckBox")
        HideChatTabsToggle:SetLabel("Hide Chat Tabs [|cFFFF4040Reload Required|r]")
        HideChatTabsToggle:SetFullWidth(true)
        HideChatTabsToggle:SetValue(UH.db.global.HideChatTabs)
        HideChatTabsToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.HideChatTabs = value UH:CreateUI() end)
        -- Hide Scroll Bars
        local HideScrollBarsToggle = UnhaltedUIGUI:Create("CheckBox")
        HideScrollBarsToggle:SetLabel("Hide Scroll Bars [|cFFFF4040Reload Required|r]")
        HideScrollBarsToggle:SetFullWidth(true)
        HideScrollBarsToggle:SetValue(UH.db.global.HideScrollBars)
        HideScrollBarsToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.HideScrollBars = value UH:CreateUI() end)
        -- Hide Chat Font Shadows
        local RemoveChatFontShadowsToggle = UnhaltedUIGUI:Create("CheckBox")
        RemoveChatFontShadowsToggle:SetLabel("Remove Chat Font Shadows [|cFFFF4040Reload Required|r]")
        RemoveChatFontShadowsToggle:SetFullWidth(true)
        RemoveChatFontShadowsToggle:SetValue(UH.db.global.RemoveChatFontShadows)
        RemoveChatFontShadowsToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.RemoveChatFontShadows = value UH:CreateUI() end)
        -- Position Edit Box
        local PositionEditBoxToggle = UnhaltedUIGUI:Create("CheckBox")
        PositionEditBoxToggle:SetLabel("Position Edit Box [|cFFFF4040Reload Required|r]")
        PositionEditBoxToggle:SetFullWidth(true)
        PositionEditBoxToggle:SetValue(UH.db.global.PositionEditBox)
        PositionEditBoxToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.PositionEditBox = value UH:CreateUI() end)
        -- Colour Picker for Prat
        local PratColour = UnhaltedUIGUI:Create("ColorPicker")
        PratColour:SetLabel("Prat Backdrop Colour")
        PratColour:SetColor(UH.db.global.PratColour.r, UH.db.global.PratColour.g, UH.db.global.PratColour.b, UH.db.global.PratColour.a)
        PratColour:SetCallback("OnValueChanged", function(widget, event, r, g, b, a) UH.db.global.PratColour = {r = r, g = g, b = b, a = a} UH:CreateUI() end)
        -- Prat Width / Height Inline Group
        local PratWH = UnhaltedUIGUI:Create("InlineGroup")
        PratWH:SetTitle("Prat Width / Height")
        PratWH:SetLayout("Flow")
        PratWH:SetFullWidth(true)
        -- Prat Width
        local PratW = UnhaltedUIGUI:Create("Slider")
        PratW:SetLabel("Width")
        PratW:SetSliderValues(0, 1000, 1)
        PratW:SetFullWidth(true)
        PratW:SetValue(UH.db.global.PratW)
        PratW:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.PratW = value UH:CreateUI() end)
        -- Prat Height
        local PratH = UnhaltedUIGUI:Create("Slider")
        PratH:SetLabel("Height")
        PratH:SetSliderValues(0, 1000, 1)
        PratH:SetFullWidth(true)
        PratH:SetValue(UH.db.global.PratH)
        PratH:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.PratH = value UH:CreateUI() end)
        -- Add Prat Width / Height to the Inline Group
        PratWH:AddChild(PratW)
        PratWH:AddChild(PratH)
        -- Prat Position / Anchor Inline Group
        local PratPos = UnhaltedUIGUI:Create("InlineGroup")
        PratPos:SetTitle("Prat Position")
        PratPos:SetLayout("Flow")
        PratPos:SetFullWidth(true)
        -- Prat Anchor
        local PratAnchor = UnhaltedUIGUI:Create("Dropdown")
        PratAnchor:SetLabel("Anchor")
        PratAnchor:SetList(AnchorPoints)
        PratAnchor:SetFullWidth(true)
        PratAnchor:SetValue(UH.db.global.PratAnchor)
        PratAnchor:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.PratAnchor = AnchorPoints[value] UH:CreateUI() end)
        -- Prat X
        local PratX = UnhaltedUIGUI:Create("Slider")
        PratX:SetLabel("X")
        PratX:SetSliderValues(-1000, 1000, 1)
        PratX:SetFullWidth(true)
        PratX:SetValue(UH.db.global.PratX)
        PratX:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.PratX = value UH:CreateUI() end)
        -- Prat Y
        local PratY = UnhaltedUIGUI:Create("Slider")
        PratY:SetLabel("Y")
        PratY:SetSliderValues(-1000, 1000, 1)
        PratY:SetFullWidth(true)
        PratY:SetValue(UH.db.global.PratY)
        PratY:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.PratY = value UH:CreateUI() end)
        -- Add Prat Position / Anchor to the Inline Group
        PratPos:AddChild(PratAnchor)
        PratPos:AddChild(PratX)
        PratPos:AddChild(PratY)
        -- Add Options to the GUI
        GUIContainer:AddChild(PratBackdropToggle)
        GUIContainer:AddChild(PratColour)
        GUIContainer:AddChild(HideChatTabsToggle)
        GUIContainer:AddChild(RemoveChatFontShadowsToggle)
        GUIContainer:AddChild(HideScrollBarsToggle)
        GUIContainer:AddChild(PositionEditBoxToggle)
        GUIContainer:AddChild(PratWH)
        GUIContainer:AddChild(PratPos)
    end

    local function GeneralOptions(GUIContainer)
        -- Faster Auto Loot
        local FasterAutoLootToggle = UnhaltedUIGUI:Create("CheckBox")
        FasterAutoLootToggle:SetLabel("Faster Auto Loot")
        FasterAutoLootToggle:SetFullWidth(true)
        FasterAutoLootToggle:SetValue(UH.db.global.FasterAutoLoot)
        FasterAutoLootToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.FasterAutoLoot = value UH:CreateUI() end)
        GUIContainer:AddChild(FasterAutoLootToggle)
        -- Replace UI Fonts
        local ReplaceUIFontsToggle = UnhaltedUIGUI:Create("CheckBox")
        ReplaceUIFontsToggle:SetLabel("Replace UI Fonts [|cFFFF4040Reload Required|r]")
        ReplaceUIFontsToggle:SetFullWidth(true)
        ReplaceUIFontsToggle:SetValue(UH.db.global.ReplaceUIFonts)
        ReplaceUIFontsToggle:SetCallback("OnValueChanged", function(widget, event, value) UH.db.global.ReplaceUIFonts = value UH:CreateUI() end)
        GUIContainer:AddChild(ReplaceUIFontsToggle)
    end

    local function GroupSelect(GUIContainer, Event, SelectedGroup)
        GUIContainer:ReleaseChildren()
        if SelectedGroup == "General" then
            GeneralOptions(GUIContainer)
        elseif SelectedGroup == "Details" then
            DetailsOptions(GUIContainer)
        elseif SelectedGroup == "Prat" then
            PratOptions(GUIContainer)
        end
    end

    local SelectedTab = UnhaltedUIGUI:Create("TabGroup")
    SelectedTab:SetLayout("Flow")
    SelectedTab:SetTabs({{text = "General", value = "General"}, {text = "Details", value = "Details"}, {text = "Prat", value = "Prat"}})
    SelectedTab:SetCallback("OnGroupSelected", GroupSelect)
    SelectedTab:SelectTab("General")
    GUIContainer:AddChild(SelectedTab)

    GUIOpen = true

end

-- Create a Slash Command to open the GUI
SLASH_UnhaltedUI1 = "/uh"
SLASH_UnhaltedUI2 = "/uhui"
SlashCmdList["UnhaltedUI"] = function() if not GUIOpen then UH:UnhaltedGUI() end end
