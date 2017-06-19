public class SOQLInFor{
    Public Static List<Account> account;
    public Static List<Account> display(){
        
    	for(Account[] ac:[Select id,name from Account]){
            for(Account acd:ac){
            System.debug('Check this : '+acd.name);
            }
            }
        return account;
    }
}