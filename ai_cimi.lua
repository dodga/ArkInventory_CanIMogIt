local ArkInvCimi = ArkInventoryRules:NewModule("ArkInventoryRules_CanIMogIt")

ArkInvCimi.debugPrint = false

local CanIMogIt = LibStub("AceAddon-3.0"):GetAddon("CanIMogIt")

local alreadyMoggedTexts = {
	[CanIMogIt.KNOWN] = true,
	[CanIMogIt.KNOWN_BOE] = true,
}

local altMoggedTexts = {
	[CanIMogIt.KNOWN_FROM_ANOTHER_ITEM] = true,
	[CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE] = true,
	[CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = true,
	[CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = true,
	[CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL] = true,
	[CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE] = true,
	[CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL] = true,
	[CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE] = true,
	[CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = true,
	[CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = true,
}

local iCanMogTexts = {
    [CanIMogIt.UNKNOWN] = true,
}

local altCanMogTexts = {
	[CanIMogIt.UNKNOWABLE_BY_CHARACTER] = true,
}

local cannotMogTexts = {
	[CanIMogIt.UNKNOWABLE_SOULBOUND] = true,
	[CanIMogIt.NOT_TRANSMOGABLE] = true,
	[CanIMogIt.NOT_TRANSMOGABLE_BOE] = true,
}

function ArkInvCimi:OnEnable()
	if not CanIMogIt then
		error("CanIMogIt not loaded")
	else
		ArkInventoryRules.Register(self, "mogged", ArkInvCimi.Mogged)
		ArkInventoryRules.Register(self, "altmogged", ArkInvCimi.AltMogged)
		ArkInventoryRules.Register(self, "icanmog", ArkInvCimi.ICanMog)
		ArkInventoryRules.Register(self, "altcanmog", ArkInvCimi.AltCanMog)
		ArkInventoryRules.Register(self, "cannotmog", ArkInvCimi.CannotMog)
	end
end

local function GetCanIMogItUnmodifiedText()
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return nil
	end

	local itemLink, bagId, slotId = ArkInventoryRules.Object.h, nil, nil
	local _, unmodifiedText = CanIMogIt:GetTooltipText(itemLink, bagId, slotId)

	if ArkInvCimi.debugPrint or false then
		-- per overlay.lua from CanIMogIt: empty string means "do not show"
		if (unmodifiedText and unmodifiedText ~= "") then
			print(itemLink, "unmodifiedText=[", unmodifiedText, "]")
		end
	end

	return unmodifiedText
end

local function IsMogTextIn(allowedTexts)
	local unmodifiedText = GetCanIMogItUnmodifiedText()

	return unmodifiedText
		and unmodifiedText ~= ""
		and allowedTexts[unmodifiedText]
		or false
end

function ArkInvCimi.Mogged(...)
	return IsMogTextIn(alreadyMoggedTexts)
end

function ArkInvCimi.AltMogged(...)
	return IsMogTextIn(altMoggedTexts)
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
