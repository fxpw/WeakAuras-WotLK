--[[
	Queries some data retrieval API (specifically where the data may not be currently available) and when it becomes available
	calls a user-supplied function.  The callback can be canceled if necessary (e.g. the frame that would use the data becomes
	hidden before the data arrives).
	The API is managed so that arbitrary query functions cannot be executed.
--]]
C_Spell = C_Spell or {}
if not C_Spell.GetSpellIcon then
    function C_Spell.GetSpellIcon(sid)
        if not sid then return end
        return select(3,GetSpellInfo(sid))
    end
end


--~new async callback api
AsyncCallbackAPIType = {
	ASYNC_QUEST = 1,
	ASYNC_ITEM = 2,
	ASYNC_SPELL = 3,
}
local permittedAPI =
{
	[AsyncCallbackAPIType.ASYNC_QUEST] = { event = "QUEST_DATA_LOAD_RESULT", accessor =  function(...) end },
	[AsyncCallbackAPIType.ASYNC_ITEM] = { event = "ITEM_DATA_LOAD_RESULT", accessor =  function(...) end },
	[AsyncCallbackAPIType.ASYNC_SPELL] = { event = "SPELL_DATA_LOAD_RESULT", accessor =  function(...) end },
};
AsyncCallbackSystemMixin = {};
function AsyncCallbackSystemMixin:Init(apiType)
	self.callbacks = {};
	-- API Type should be set up from key value pairs before OnLoad.
	self.api = permittedAPI[apiType];
	self:SetScript("OnEvent",
		function(self, event, ...)
			if event == self.api.event then
				local id, success = ...;
				if success then
					self:FireCallbacks(id);
				else
					self:ClearCallbacks(id);
				end
			end
		end
	);
	self:RegisterEvent(self.api.event);
end
local CANCELED_SENTINEL = -1;
function AsyncCallbackSystemMixin:AddCallback(id, callbackFunction)
	local callbacks = self:GetOrCreateCallbacks(id);
	table.insert(callbacks, callbackFunction);
	local needsAccessorCall = #callbacks == 1;
	if needsAccessorCall then
		self.api.accessor(id);
	end
	return #callbacks, callbacks;
end
function AsyncCallbackSystemMixin:AddCancelableCallback(id, callbackFunction)
	-- NOTE: If the data is currently availble then the callback will be executed and callbacks cleared, so there will be nothing to cancel.
	local index, callbacks = self:AddCallback(id, callbackFunction);
	return function()
		if #callbacks > 0 and callbacks[index] ~= CANCELED_SENTINEL then
			callbacks[index] = CANCELED_SENTINEL;
			return true;
		end
		return false;
	end;
end
function AsyncCallbackSystemMixin:FireCallbacks(id)
	local callbacks = self:GetCallbacks(id);
	if callbacks then
		self:ClearCallbacks(id);
		for i, callback in ipairs(callbacks) do
			if callback ~= CANCELED_SENTINEL then
				xpcall(callback, CallErrorHandler);
			end
		end
		-- The cancel functions have a reference to this table, so ensure that it's cleared out.
		for i = #callbacks, 1, -1 do
			callbacks[i] = nil;
		end
	end
end
function AsyncCallbackSystemMixin:ClearCallbacks(id)
	self.callbacks[id] = nil;
end
function AsyncCallbackSystemMixin:GetCallbacks(id)
	return self.callbacks[id];
end
function AsyncCallbackSystemMixin:GetOrCreateCallbacks(id)
	local callbacks = self.callbacks[id];
	if not callbacks then
		callbacks = {};
		self.callbacks[id] = callbacks;
	end
	return callbacks;
end
local function CreateListener(apiType)
	local listener = Mixin(CreateFrame("Frame"), AsyncCallbackSystemMixin);
	listener:Init(apiType);
	return listener;
end
ItemEventListener = CreateListener(AsyncCallbackAPIType.ASYNC_ITEM);
SpellEventListener = CreateListener(AsyncCallbackAPIType.ASYNC_SPELL);
QuestEventListener = CreateListener(AsyncCallbackAPIType.ASYNC_QUEST);

--~new wow spell api
Spell = {};
SpellMixin = {};
--[[static]] function Spell:CreateFromSpellID(spellID)
	local spell = CreateFromMixins(SpellMixin);
	spell:SetSpellID(spellID);
	return spell;
end
function SpellMixin:SetSpellID(spellID)
	self:Clear();
	self.spellID = spellID;
end
function SpellMixin:GetSpellID()
	return self.spellID;
end
function SpellMixin:Clear()
	self.spellID = nil;
end
function SpellMixin:IsSpellEmpty()
	local spellID = self:GetSpellID();
	return not spellID or not GetSpellInfo(spellID);
end
-- Spell API
function SpellMixin:IsSpellDataCached()
	-- if not self:IsSpellEmpty() then
	-- 	return C_Spell.IsSpellDataCached(self:GetSpellID());
	-- end
	return SpellMixin:IsSpellEmpty();
end
function SpellMixin:IsDataEvictable()
	-- Spell data could be evicted from the cache
	return true;
end
function SpellMixin:GetSpellName()
	return (GetSpellInfo(self:GetSpellID()));
end
function SpellMixin:GetSpellTexture()
	return select(3,GetSpellInfo((self:GetSpellID())));
end
function SpellMixin:GetSpellSubtext()
	return "Subtext";
end
function SpellMixin:GetSpellDescription()
	return "Description";
end
-- Add a callback to be executed when spell data is loaded, if the spell data is already loaded then execute it immediately
function SpellMixin:ContinueOnSpellLoad(callbackFunction)
	if type(callbackFunction) ~= "function" or self:IsSpellEmpty() then
		error("Usage: NonEmptySpell:ContinueOnLoad(callbackFunction)", 2);
	end
	SpellEventListener:AddCallback(self:GetSpellID(), callbackFunction);
end
-- Same as ContinueOnSpellLoad, except it returns a function that when called will cancel the continue
function SpellMixin:ContinueWithCancelOnSpellLoad(callbackFunction)
	if type(callbackFunction) ~= "function" or self:IsSpellEmpty() then
		error("Usage: NonEmptySpell:ContinueWithCancelOnSpellLoad(callbackFunction)", 2);
	end
	return SpellEventListener:AddCancelableCallback(self:GetSpellID(), callbackFunction);
end
-- Generic aliases for use with ContinuableContainer
function SpellMixin:ContinueWithCancelOnRecordLoad(callbackFunction)
	return self:ContinueWithCancelOnSpellLoad(callbackFunction);
end
function SpellMixin:IsRecordDataCached()
	return self:IsSpellDataCached();
end