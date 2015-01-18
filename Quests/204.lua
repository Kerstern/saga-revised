-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 204;
local ReqClv = 17;
local ReqJlv = 0;
local NextQuest = 205;
local RewZeny = 324;
local RewCxp = 1900;
local RewJxp = 770;
local RewWxp = 0; 
local RewItem1 = 0; 
local RewItem2 = 0; 
local RewItemCount1 = 0; 
local RewItemCount2 = 0; 
local StepID = 0;   

-- Modify steps below for gameplay

function QUEST_START(cid)    
    Saga.AddStep(cid, QuestID, 20401);
    Saga.AddStep(cid, QuestID, 20402);       
    Saga.AddStep(cid, QuestID, 20403);      
    Saga.InsertQuest(cid, QuestID, 1);  
    return 0;
end

function QUEST_FINISH(cid)
    -- Gives all rewards
    Saga.GiveZeny(cid, RewZeny);
    Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp); 
    Saga.InsertQuest(cid, NextQuest, 1);  
    return 0;
end

function QUEST_CANCEL(cid)
    return 0;
end

function QUEST_STEP_1(cid)    
    -- Talk with Arno Ling
    Saga.AddWaypoint(cid, QuestID, StepID, 1, 1097);      
    
    -- Check for completion
    local ret = Saga.GetNPCIndex(cid);    
    if ret == 1097 then
        Saga.GeneralDialog(cid, 3936);     
        Saga.SubstepComplete(cid, QuestID, StepID, 1);        
    end    
    
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
            return -1;
         end
    end        
    
    Saga.StepComplete(cid, QuestID, StepID);
    Saga.ClearWaypoints(cid, QuestID); 
    return 0;
end

function QUEST_STEP_2(cid)
    -- Find Beacon Firewood (7)
    Saga.FindQuestItem(cid, QuestID, StepID, 5, 3995, 10000, 7, 1);

    -- (De-)Activates the Action Objectd on request
    if Saga.IsSubStepCompleted(cid,QuestID,StepID, 1) == false then
        Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 5, 0 );        
    else
        Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 5, 1 );        
    end
    
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
            return -1;
         end
    end        
    
    Saga.StepComplete(cid, QuestID, StepID);
    Saga.ClearWaypoints(cid, QuestID); 
    return 0;
end

function QUEST_STEP_3(cid)
    -- Deliver Beacon Firewood Arno Ling
    Saga.AddWaypoint(cid, QuestID, StepID, 1, 1097);      
    
    -- Check for completion
    local ret = Saga.GetNPCIndex(cid);    
    if ret == 1097 then
        Saga.GeneralDialog(cid, 3936);     
        
        local ItemCountA = Saga.CheckUserInventory(cid,3995);    
        if ItemCountA > 6 then
            Saga.NpcTakeItem(cid, 3995,7);          
            Saga.SubstepComplete(cid, QuestID, StepID, 1); 
        end        
    end    
    
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
            return -1;
         end
    end        
    
    Saga.StepComplete(cid, QuestID, StepID);
    Saga.ClearWaypoints(cid, QuestID); 
    Saga.QuestComplete(cid, QuestID);    
    return -1;
end

function QUEST_CHECK(cid)
    local CurStepID = Saga.GetStepIndex(cid, QuestID );
    StepID = CurStepID;
    local ret = -1;

    if CurStepID == 20401 then
        ret = QUEST_STEP_1(cid);
    elseif CurStepID == 20402 then               
        ret = QUEST_STEP_2(cid);    
    elseif CurStepID == 20403 then               
        ret = QUEST_STEP_3(cid);            
    end
    
    if ret == 0 then
        QUEST_CHECK(cid)
    end
    
    return ret;    
end