trigger InvoiceEvent on Invoice__c (after update) {
    if(trigger.isAfter && trigger.isUpdate ){
        List<Invoice_Event__e> lstInvoiceEvents = new List<Invoice_Event__e>();
        for(Invoice__c inv : Trigger.new){
            Invoice_Event__e evt = new Invoice_Event__e();
            evt.Account_ID__c = inv.Account__c;
            evt.Amount__c    = inv.Amount__c;
            evt.Date__c     = inv.Date__c;
            evt.Status__c = inv.Status__c;
            lstInvoiceEvents.add(evt);
        }
        if(lstInvoiceEvents.size()>0){
            EventBus.publish(lstInvoiceEvents);
        }
    }	
}