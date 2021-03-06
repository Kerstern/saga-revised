-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 423;
local ReqClv = 30;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1421;
local RewCxp = 5219;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 4255;
local RewItemCount1 = 11;
local RewItemCount2 = 1;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 42301);
	Saga.AddStep(cid, QuestID, 42302);
	Saga.AddStep(cid, QuestID, 42303);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk with Chayenne
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1022);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1022 then
		Saga.GeneralDialog(cid, 4684);

		local freeslots = Saga.FreeInventoryCount(cid, 0);
		if freeslots > 0 then
			Saga.NpcGiveItem(cid, 4232, 3);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.EmptyInventory(cid);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Deliver to Gretchel Ortrud;
	-- Deliver to Moritz Blauvelt;
	-- Deliver to Pretan;
	
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1025);
	Saga.AddWaypoint(cid, QuestID, StepID, 2, 1026);
	Saga.AddWaypoint(cid, QuestID, StepID, 3, 1024);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1025 then
		Saga.GeneralDialog(cid, 4687);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4232);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4232, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.ItemNotFound(cid);
		end
	elseif ret == 1026 then
		Saga.GeneralDialog(cid, 4690);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4232);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4232, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.ItemNotFound(cid);
		end
	elseif ret == 1024 then
		Saga.GeneralDialog(cid, 4693);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4232);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4232, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.ItemNotFound(cid);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Report to Chayenne
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1022);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1022 then
		Saga.GeneralDialog(cid, 4696);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	local StepID = CurStepID;
	
	if CurStepID == 42301 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 42302 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 42303 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
