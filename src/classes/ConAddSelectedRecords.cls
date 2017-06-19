public class ConAddSelectedRecords {

    Public List<Account> accounts{get;set;}
    public List<AccountWrapper> accountsselection{get;set;}
    public List<Account> selectedAccounts{get;set;}
    public ConAddSelectedRecords(ApexPages.StandardController controller) {
        accounts = new List<Account>();
    }
    public void DisplayRecords(){
        accounts=[select id,name from Account limit 20];
        accountsselection= new List<AccountWrapper>();
        for(Account a:accounts){
        accountsselection.add(new AccountWrapper(a));
        }
    }
    
    public void DisplaySelectedRecords(){
        selectedAccounts = new List<Account>();
        for(AccountWrapper aw:accountsselection){
            if(aw.selected==True)
            selectedAccounts.add(aw.acc);
        }
    }
    
    public class AccountWrapper{
        
        public Account acc{get;set;}
        public Boolean selected{get;set;}
        public AccountWrapper(Account acc){
        this.acc=acc;
        selected=false;
        }
    }

}