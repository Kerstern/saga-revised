-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 366;
local ReqClv = 29;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1034;
local RewCxp = 6215;
local RewJxp = 2486;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 7;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 36601);
	Saga.AddStep(cid, QuestID, 36602);
	Saga.AddStep(cid, QuestID, 36603);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk with Alina
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1054);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1054 then
		Saga.GeneralDialog(cid, 3576);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Loot Gremlin Navy (5)
	-- Loot Heavy Gremlin (5)
	Saga.FindQuestItem(cid, QuestID, StepID, 10333, 4168, 10000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10334, 4168, 10000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10335, 4169, 10000, 5, 2);
	Saga.FindQuestItem(cid, QuestID, StepID, 10336, 4169, 10000, 5, 2);
	
	-- Check if all substeps are completed
	for i = 1, 2 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Deliver loot to Alina
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1054);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1054 then
		Saga.GeneralDialog(cid, 3579);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4168);
		local ItemCountB = Saga.CheckUserInventory(cid, 4169);
		if ItemCountA > 4 and ItemCountB > 4 then
			Saga.NpcTakeItem(cid, 4168, 5);
			Saga.NpcTakeItem(cid, 4169, 5);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local StepID = CurStepID;
	local ret = -1;

	if CurStepID == 36601 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 36602 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 36603 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
