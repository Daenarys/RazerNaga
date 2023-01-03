--[[
	BindSync
		This frame
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:GetModule('Anansi')
local BindSync = {}; Anansi.BindSync = BindSync
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')


function BindSync:StartSyncBindings()
	self.tKeyBindings = {}
	self.tKey = 1

	self:ShowPromptFrame():UpdatePrompt()
	return self
end

function BindSync:ShowPromptFrame()
	local frame = self.frame
	if not frame then
		frame = self:CreatePromptFrame()
		self.frame = frame
	end

	frame.save:Hide()
	frame.tryAgain:Hide()
	frame.summaryText:Hide()
	frame:RegisterForClicks('anyUp')
	frame:Show()

	return self
end

function BindSync:CancelChanges()
	local frame = self.frame
	if frame then
		frame:Hide()
	end

	return self
end

function BindSync:RestartSync()
	self:StartSyncBindings()

	return self
end

function BindSync:UpdatePrompt()
	local frame = self.frame
	frame.promptText:SetFormattedText(L.BindTKeyPrompt, Anansi.Config:GetTKeyName(self.tKey))
	frame.promptText:Show()

	return self
end

function BindSync:ShowSummary()
	self.frame:RegisterForClicks(nil)
	self.frame.promptText:Hide()

	local summaryText = L.ChangeSummary .. '\n'
	for tKey = 1, Anansi.Config:NumTKeys() do
		summaryText = summaryText .. string.format('\n    %s - %s', Anansi.Config:GetTKeyName(tKey), self.tKeyBindings[tKey])
	end

	self.frame.summaryText:SetText(summaryText)
	self.frame.summaryText:Show()
	self.frame.save:Show()
	self.frame.tryAgain:Show()

	return self
end

function BindSync:SetTKeyBinding(tKey, binding)
	self.tKeyBindings[tKey] = binding

	return self
end

function BindSync:SaveChanges()
	local tKeyFrames = {}
	
	--pull in all current tKey frames
	for tKey = 1, Anansi.Config:NumTKeys() do
		for id, frame in RazerNaga.Frame:GetAll() do
			if RazerNaga.BindingsLoader:GetFrameModifier(frame) == Anansi.Config:GetTKeyBinding(tKey) then
				tKeyFrames[tKey] = frame
			end
		end
	end
	
	--update tKey bindings
	--update tKey frame bindings
	for tKey = 1, Anansi.Config:NumTKeys() do
		local newBinding = self.tKeyBindings[tKey]
		Anansi.Config:SetTKeyBinding(tKey, newBinding)
		
		local tKeyFrame = tKeyFrames[tKey]
		if tKeyFrame then
			RazerNaga.BindingsLoader:SetFrameModifier(tKeyFrame, newBinding)
		end
	end

	self.frame:Hide()
	return self
end

function BindSync:CreatePromptFrame()
	local f = CreateFrame('Button', 'AnansiBindSyncFrame', UIParent); f:Hide()

	f:SetPoint('CENTER', UIParent)

	f:SetBackdrop{
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
		edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
		insets = {left = 11, right = 11, top = 12, bottom = 11},
		tile = true,
		tileSize = 32,
		edgeSize = 32,
	}

	f:SetSize(320, 240)
	f:EnableMouse(true)
	f:SetToplevel(true)
	f:SetMovable(true)
	f:SetClampedToScreen(true)
	f:SetFrameStrata('DIALOG')

	f.headerText = f:CreateFontString('$parentHeaderText', 'OVERLAY', 'GameFontHighlightLarge')
	f.headerText:SetPoint('TOP', 0, -15)
	f.headerText:SetText('Sync Bindings')

	f.promptText = f:CreateFontString('$parentPromptText', 'OVERLAY', 'GameFontNormalLarge')
	f.promptText:SetPoint('TOPLEFT', 16, -36)
	f.promptText:SetPoint('BOTTOMRIGHT', -16, 36)

	f.promptText = f:CreateFontString('$parentPromptText', 'OVERLAY', 'GameFontNormalLarge')
	f.promptText:SetPoint('TOPLEFT', 16, -36)
	f.promptText:SetPoint('BOTTOMRIGHT', -16, 36)

	f.summaryText = f:CreateFontString('$parentSummaryText', 'OVERLAY', 'GameFontNormalLarge')
	f.summaryText:Hide()
	f.summaryText:SetPoint('TOPLEFT', 16, -36)
	f.summaryText:SetPoint('BOTTOMRIGHT', -16, 36)
	f.summaryText:SetJustifyH('LEFT')
	f.summaryText:SetJustifyV('TOP')

	--close button
	f.close = CreateFrame('Button', '$parentClose', f, 'UIPanelCloseButton')
	f.close:SetScript('OnClick', function() self:CancelChanges() end)
	f.close:SetPoint('TOPRIGHT', -5, -5)

	local cancel = CreateFrame('Button', '$parentCancel', f, 'UIPanelButtonTemplate')
	cancel:SetSize(64, 20)
	cancel:SetText(CANCEL)
	cancel:SetPoint('BOTTOMRIGHT', -16, 12)
	cancel:SetScript('OnClick', function() self:CancelChanges() end)

	local save = CreateFrame('Button', '$parentSave', f, 'UIPanelButtonTemplate'); save:Hide()
	save:SetSize(64, 20)
	save:SetText(SAVE)
	save:SetPoint('RIGHT', cancel, 'LEFT', -4, 0)
	save:SetScript('OnClick', function() self:SaveChanges() end)
	f.save = save

	local tryAgain = CreateFrame('Button', '$parentTryAgain', f, 'UIPanelButtonTemplate'); tryAgain:Hide()
	tryAgain:SetSize(84, 20)
	tryAgain:SetText(L.TryAgain)
	tryAgain:SetPoint('RIGHT', save, 'LEFT', -4, 0)
	tryAgain:SetScript('OnClick', function() self:RestartSync() end)
	f.tryAgain = tryAgain

	f:SetScript('OnClick', function()
		local modifier = RazerNaga.ModHighlighter:GetCurrentModifierCombo()
		if not modifier then
			return
		end

		self:SetTKeyBinding(self.tKey, modifier)
		if self.tKey < Anansi.Config:NumTKeys() then
			self.tKey = self.tKey + 1
			self:UpdatePrompt()
		else
			self:ShowSummary()
		end
	end)

	return f
end