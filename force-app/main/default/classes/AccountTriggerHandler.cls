public class AccountTriggerHandler {
    public static void AccountInsert(List<Account> newAccountTrigger){
       if(Trigger.isInsert){
        	AccountTriggerHelper.CreateContact(newAccountTrigger);
    	} 
    }
    
}