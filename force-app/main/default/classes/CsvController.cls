public with sharing class CsvController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccounts(){
        //return [SELECT Id, Name, Phone, AnnualRevenue, Industry from Account];
        return [SELECT Id, FirstName ,AccountId, Phone , MobilePhone FROM Contact];
    }
}