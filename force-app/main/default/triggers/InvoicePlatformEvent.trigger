trigger InvoicePlatformEvent on Invoice_Event__e (after insert) {
	Set<Id> accId = new Set<Id>();
    for(Invoice_Event__e invevt : trigger.new){
        accId.add(invevt.Account_Id__c);
        
    }
    Map<Id,Account> mapIdAcc = new Map<Id, Account>([SELECT Id from Account Where Id IN : accId]);
    List<Account> listAcc = new List<Account>();
    for(Invoice_Event__e invevt : trigger.new){
        if(invevt.Status__c=='Paid'){
            Account acc = mapIdAcc.get(invevt.Account_Id__c);
            acc.Description = ' The Invoice with Amount ' +invevt.Amount__c +' has been Paid on '+ invevt.Date__c;
            listAcc.add(acc);
        }
    }
    if(listAcc != NULL && listAcc.size()> 0){
        update listAcc;
    }
}