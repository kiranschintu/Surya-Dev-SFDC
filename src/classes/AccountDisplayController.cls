public with sharing class AccountDisplayController{
    public string SelectedAccountId{get;set;}
    public Account acc{get;set;}
    public AccountDisplayController() {}
    public List<Account> getAccounts() {
            return[select id, Name from Account ORDER BY Name limit 10];
    }
    public pageReference OpenAccount() {
        //Do any process you want here
        Account a = new Account();
        acc = new Account();
        
        a=[Select id,name from Account where id=:SelectedAccountId];
        acc.name=a.name;
        return null;
        //return new PageReference('/' + SelectedAccountId);
    }
}