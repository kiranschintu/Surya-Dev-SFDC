/***
Executing trigger after actions
***/
public class UpdateContacts1 implements AccountTriggerActions{
    
    public static void beforeActions(List<sObject> records){}
    
    public static void afterActions(List<SObject> records){
        List<Account> accs = (List<Account>)records;
        List<Account> accsAftUpd = new List<Account>();
        for(Account acc:accs){
            Account a = new Account();
            //a.id= acc;
            a.id = acc.id;
            a.Description ='Hello From Triggger :UpdateContacts1';
            accsAftUpd.add(a);
        }
        update accsAftUpd;
    }
}