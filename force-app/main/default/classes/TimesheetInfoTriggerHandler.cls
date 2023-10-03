public class TimesheetInfoTriggerHandler {
    public static void Checkdate(List<Timesheet_Info__c> TimeSheetTrList,Map<Id,Timesheet_Info__c> TimesheetOldMap)
    {
        TimesheetInfoTriggerHelper.SetWeekDateOnInsert(TimesheetTrList);
    }
    public static void CheckdateUpd(List<Timesheet_Info__c> TimeSheetTrList,Map<Id,Timesheet_Info__c> TimesheetOldMap)
    {
        TimesheetInfoTriggerHelper.SetWeekDateOnUpdate(TimeSheetTrList, TimesheetOldMap);
    }
 //10
    public static void EntryOnInsert(List<Timesheet_Info__c> TimeSheetList)
    {
        TimesheetInfoTriggerHelper.CreateTimesheetEntryOnInsert(TimesheetList);
    }
    public static void PreventDeletion(List<Timesheet_Info__c> TimeSheetTrOldList)
    {
        TimesheetInfoTriggerHelper.StatusNotApproved(TimeSheetTrOldList);
    }
}