public with sharing class WrapperExampleCTRL {
    
    public List<AccountsWrapper> accWrapper{get;set;}
    
    public WrapperExampleCTRL(){
        accWrapper = new List<AccountsWrapper>();
        for(Account acc : [Select id,name,Rating from Account limit 10]){
            accWrapper.add(new AccountsWrapper(acc));
        }
    }
    
    public void doSome(){
        List<Account> accs = new List<Account>();
        for(AccountsWrapper acwp : accWrapper){
            acwp.acc.Rating='Hot';
            accs.add(acwp.acc);
        }
        update accs;
        system.debug('Final Wrapper:::'+accWrapper);
    }

    public class AccountsWrapper{
        public Account acc{get;set;}
        
        public AccountsWrapper(Account acc){
            this.acc = acc;
        }
    }
}