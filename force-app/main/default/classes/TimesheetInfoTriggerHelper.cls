//10
public class TimesheetInfoTriggerHelper {
    public static void SetWeekDateOnInsert(List<Timesheet_Info__c> TimesheetList){
        List<Timesheet_Info__c> NewTimeList = TimesheetList;
        for(Timesheet_Info__c te: NewTimeList){
            if(te.Week_Start_Date__c != null && te.Week_End_Date__c != null)
            {
                te.Week_Start_Date__c = te.Week_Start_Date__c.toStartOfWeek();
                te.Week_Start_Date__c = te.Week_Start_Date__c.addDays(1);
            	te.Week_End_Date__c = te.Week_Start_Date__c.addDays(7);
            	System.debug('te.WeekEnd==>'+te.Week_End_Date__c);
        	}
        }    
    }
///////////////////////////////////////Set Week Date Whenever It is Updated////////////////////////////////////////////////    
     public static void SetWeekDateOnUpdate(List<Timesheet_Info__c> TimesheetList,Map<Id, Timesheet_Info__c> TimesheetOldMap){
         for(Timesheet_Info__c tim:TimesheetList){
             if(tim.Week_Start_Date__c != TimesheetOldMap.get(tim.Id).Week_Start_Date__c){
                 	Set<Id> tsId = new Set<Id>();
                     List<Timesheet_Data__c> listToUpd = new List<Timesheet_Data__c>();
                     for(Timesheet_Info__c ts:TimesheetList){
                         tsId.add(ts.Id);
                         system.debug('Id===>'+ts.Id);
                     }
                     List<Timesheet_Data__c> NewTimesheetEntryList = [SELECT Id,Name,Timesheet_Employee__c,Logged_Date__c,Logged_Day__c
                                                                    FROM Timesheet_Data__c
                                                                    WHERE Timesheet_Employee__c IN:tsId];
                     System.debug('ListEntry==>'+NewTimesheetEntryList);
                     Map<Id,List<Timesheet_Data__c>> timesheetToListOfEntryMap = new Map<Id,List<Timesheet_Data__c>>();
                     List<Timesheet_Data__c> tempList = new List<Timesheet_Data__c>();
                     for(Timesheet_Data__c tse:NewTimesheetEntryList){
                         if(timesheetToListOfEntryMap.get(tse.Timesheet_Employee__c) != null){
                             tempList = timesheetToListOfEntryMap.get(tse.Timesheet_Employee__c);
                         }
                         else
                         {
                             tempList = new list<Timesheet_Data__c>();
                         }
                         tempList.add(tse);
                         timesheetToListOfEntryMap.put(tse.Timesheet_Employee__c,tempList);
                     }
                     System.debug('Map==>'+timesheetToListOfEntryMap);
                     for(Timesheet_Info__c te: TimesheetList){
                        System.debug('te.WeekEnd==>'+te.Week_End_Date__c);
                        if(te.Week_Start_Date__c != TimesheetOldMap.get(te.Id).Week_Start_Date__c){
                            if(te.Week_Start_Date__c != null){
                                te.Week_End_Date__c = te.Week_Start_Date__c.addDays(6);
                                for(Timesheet_Data__c tent:timesheetToListOfEntryMap.get(te.Id)){
                                    System.debug('Week Start date==>'+te.Week_Start_Date__c);
                                    tent.Logged_Date__c = te.Week_Start_Date__c;
                                    listToUpd.add(tent);
                                }
                            }
                        }
                    }
                     if(!listToUpd.isEmpty())
                     {
                         Database.update(listToUpd);
                     }
                         }
                     }
         
    }
//10///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    public static void CreateTimesheetEntryOnInsert(List<Timesheet_Info__c> TimesheetList){
        List<Timesheet_Data__c> DtaList = new List<Timesheet_Data__c>();
        integer i=1;
        for(Timesheet_Info__c tl:TimesheetList)
        {
            Timesheet_Data__c ent = new Timesheet_Data__c();
            ent.Name = tl.Name+' '+i;
            if(tl.Week_Start_Date__c != null)
            {
                ent.Logged_Date__c = tl.Week_Start_Date__c;
            	ent.Logged_Day__c = 'Monday';
            }
            else if(tl.Week_Start_Date__c == null)
            {
                ent.Logged_Date__c = System.today();
                ent.Logged_Day__c = 'Monday';
            }
            ent.Timesheet_Employee__c = tl.Id;
            DtaList.add(ent);
            i++;
        }
        if(!DtaList.isEmpty())
        {
            Database.insert(DtaList);
        }
    }
    ///////////////////////////////******************************////////////////////////////////////////////////////
    public static void StatusNotApproved(List<Timesheet_Info__c> TimesheetList){
        List<Contact> conList = new List<Contact>();
        Map<Id,Contact> timesheetInfoIdToContactMap = new Map<Id,Contact>();
        List<Id>  conId = new List<Id>();      
        for(Timesheet_Info__c ts:TimesheetList)
        {
            conId.add(ts.Employee__c);
            if(ts.Status__c != 'Approved')
            {
                ts.addError('Status is not APPROVED');        
            }
        }
        conList = [SELECT Id,FirstName,LastName,Email
                  FROM Contact 
                  WHERE Id IN:conId];
        for(Contact cn:conlist)
        {
            if(cn.Email!=null){
                String[] sendTo = new String[]{cn.Email};
            	System.debug('Contact==>'+cn.Email);
            	//sendTo.add(cn.Email);
            	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        		mail.setReplyTo('vankit831@gmail.com');
      			mail.setSenderDisplayName('Timesheet Info');
      	    	mail.setSubject('ALERT REGARDING DELETION');
         		String body = 'Dear ' + cn.FirstName +' '+ cn.LastName+ ', ';
            	body += 'You Cannot Delete Timesheet Info as Your Status is not Approved';
            	body += 'Kindly Change Status to Approved , then TRY AGAIN!!!';
            	mail.setPlainTextBody(body);
            	mail.setToAddresses(sendTo);
            	Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            }    
        }
    }
}