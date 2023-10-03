trigger TimesheetInfoTrigger on Timesheet_Info__c (before insert, before update, After insert,before delete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TimesheetInfoTriggerHandler.Checkdate(Trigger.new ,Trigger.oldMap);
        }
        if(Trigger.isUpdate){
            TimesheetInfoTriggerHandler.Checkdateupd(Trigger.new ,Trigger.oldMap);
        }
        if(Trigger.isDelete){
            TimesheetInfoTriggerHandler.PreventDeletion(Trigger.old);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert)
        {
            TimesheetInfoTriggerHandler.EntryOnInsert(Trigger.new);
            System.debug('Trigger.new'+Trigger.new);
        }
    }
}