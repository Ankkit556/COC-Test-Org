public with sharing class MapControllerLwc {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT BillingAddress,BillingCity,BillingCountry,BillingLatitude,BillingLongitude,BillingPostalCode,BillingState,BillingStreet,Id,Name 
                FROM Account WITH SECURITY_ENFORCED 
                ORDER BY Name ASC NULLS LAST 
                LIMIT 10 ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return [SELECT Id,Name,Email,Title/*,Description,FirstName,Id,LastName,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet*/ 
                FROM Contact WITH SECURITY_ENFORCED 
                ORDER BY Name 
                ASC NULLS LAST 
                LIMIT 100 ];
    }
}