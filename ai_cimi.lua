local ArkInvCimi = ArkInventoryRules:NewModule("ArkInventoryRules_CanIMogIt")

ArkInvCimi.debugPrint = false

local CanIMogIt = LibStub("AceAddon-3.0"):GetAddon("CanIMogIt")

local iCanMogTexts = {
    [CanIMogIt.UNKNOWN] = true,	
}

local altCanMogTexts = {
	[CanIMogIt.UNKNOWABLE_BY_CHARACTER] = true,
}

local cannotMogTexts = {
	[CanIMogIt.UNKNOWABLE_SOULBOUND] = true,
	[CanIMogIt.NOT_TRANSMOGABLE] = true,
}

function ArkInvCimi:OnEnable()
	if not CanIMogIt then
		error("CanIMogIt not loaded")
	else
		ArkInventoryRules.Register(self, "mogged", ArkInvCimi.Mogged)
		ArkInventoryRules.Register(self, "icanmog", ArkInvCimi.ICanMog)
		ArkInventoryRules.Register(self, "altcanmog", ArkInvCimi.AltCanMog)
		ArkInventoryRules.Register(self, "cannotmog", ArkInvCimi.CannotMog)
	end
end

local function GetCanIMogItTexts()
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return nil
	end

	local itemLink, bagId, slotId = ArkInventoryRules.Object.h, nil, nil
	local text, unmodifiedText = CanIMogIt:GetTooltipText(itemLink, bagId, slotId)

	if ArkInvCimi.debugPrint or false then
		print(itemLink, "text=[", text, "] unmodifiedText=[", unmodifiedText, "]")
	end

	return text, unmodifiedText
end

local function IsMogTextIn(allowedTexts)
	local text, unmodifiedText = GetCanIMogItTexts()

	return allowedTexts[unmodifiedText] or false
end

function ArkInvCimi.Mogged(...)
	local text, unmodifiedText = GetCanIMogItTexts()

	return CanIMogIt:TextIsKnown(unmodifiedText)
end

function ArkInvCimi.ICanMog(...)
	return IsMogTextIn(iCanMogTexts)
end

function ArkInvCimi.AltCanMog(...)
	return IsMogTextIn(altCanMogTexts)
end

function ArkInvCimi.CannotMog(...)
	return IsMogTextIn(cannotMogTexts)
end
