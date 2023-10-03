public class AccountQueryAction {
	@InvocableMethod(label = 'Get Account Names' description = 'Returns account names' category = 'Account')
    public static List<String> getAccountNames(List<Id> ids){
        List<String> accountNames = new List<String>();
        List<Account> accounts = [SELECT Name from Account Where Id in :ids];
        for (Account account :accounts){
            accountNames.add(account.Name);
        }
        system.debug('Method getAccountNames ran!');
        return accountNames;
    }
}