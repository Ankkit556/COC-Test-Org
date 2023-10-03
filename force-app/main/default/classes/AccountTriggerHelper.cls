public class AccountTriggerHelper {
    public Static void CreateContact(List<Account> newAccountTrigger){
        Set<Id> accIds = new Set<Id>();
        for(Account acc:newAccountTrigger){
            accIds.add(acc.Id);
            System.debug('account Id-->'+acc.Id);
        }
        CreateContactByFuture(accIds);
    }
    @future
    public static void CreateContactByFuture(Set<Id> accIds){
        List<Account> accList = [SELECT Id, Name 
                                FROM Account
                                WHERE Id IN:accIds];
        List<Contact> conToInsert = new List<Contact>();
        List<User> usrList = new List<User>();
        for(Account acc:accList){
            integer i=1;
            contact con = new Contact();
            User usr = new User();
            con.FirstName = 'Test Contact '+i;
            con.LastName = acc.Name;
            con.Email    = 'contact'+i+'@fmail.com';
            con.AccountId = acc.Id;
            //usr.FirstName = 'Test Contact '+i;
            //usr.LastName  =  acc.Name;
            //usr.Alias    = acc.name+' '+i;
            //usr.Email    = 'contact'+i+'@fmail.com';
            //usr.ProfileId = '2F00e5g000002F8dk';
            //usrList.add(usr);
            conToInsert.add(con);
            i++;
        }
        System.debug('userList==>'+usrList);
        System.debug('ContList==>'+conToInsert);
        Database.insert(conToInsert);
        
        //Database.insert(usrList);
    }
}