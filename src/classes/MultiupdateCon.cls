public with sharing class MultiupdateCon {
    public List<MyWrapper> accounts{get;set;}
    public MultiupdateCon(){
        accounts = new List<MyWrapper>();
        List<Account> acc = [select id,name,Phone from Account limit 30];
        for(Account a:acc){
            accounts.add(new MyWrapper(a));
        }
    }
    
    public void doupdate(){
        
        List<Account> acc = new List<Account>();
        for(MyWrapper mw:accounts){
            Account a = new Account();
            a.Name = mw.account.Name;
            a.id = mw.account.Id;
            acc.add(a);
        }
        update acc;
    }
    
    public class MyWrapper{
        public Account account{get;set;}
        
        public MyWrapper(Account account){
            this.account = account;
        }
    }
}