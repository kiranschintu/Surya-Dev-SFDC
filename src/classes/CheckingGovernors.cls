public class CheckingGovernors{
	
    public static void doSomething(){
    	List<Account> acc = [select id,(select id from contacts) from Account];
        system.debug('Accounts'+acc.size());
        for(Account ac:acc){
        system.debug('Contacts'+ac.contacts.size());
        }
        //system.debug('Contacts'+acc.id);
        /*for(Account ac:[select id,phone,(select id,lastname from contacts) from Account]){
        ac.phone='8125931508';
            
            //List<Account> acc = [select id from account];
            Update ac;
            //acd.add(ac);
        }*/
        //update acd;
    }
}