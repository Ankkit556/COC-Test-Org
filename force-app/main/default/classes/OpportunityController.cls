public with sharing class OpportunityController {
   @AuraEnabled(cacheable = true)
   public static List<Opportunity> getOpportunities(){
    return [SELECT StageName From Opportunity WITH SECURITY_ENFORCED];
   }
   
   @AuraEnabled(cacheable=true)
   public static List<Contact>  getContacts(){
       return [SELECT Account.Name FROM Contact  WHERE Account.Name != NULL WITH SECURITY_ENFORCED];
   }
}