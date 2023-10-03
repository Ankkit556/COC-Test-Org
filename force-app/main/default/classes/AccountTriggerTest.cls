@isTest
public class AccountTriggerTest {
@testSetup
    static void Setup(){
        Account ac = new Account();
        ac.Name = 'Test Account';
        insert ac;
    }
    @isTest
    static void TestAccountCreation(){
        test.startTest();
        List<Account> ac = [SELECT Id, Name 
                     FROM Account 
                     WHERE Name='Test Account'];
                Set<Id> acId = new Set<Id>();
        for(Account acc:ac){
            acId.add(acc.Id);
        }
        AccountTriggerHelper.CreateContact(ac);
        
        Contact con = [SELECT Id, Name , AccountId 
                      FROM Contact 
                      WHERE AccountId IN:acId LIMIT 1];
        test.stopTest();
        System.assertEquals('Test Contact 1 Test Account', con.Name);
    }
}