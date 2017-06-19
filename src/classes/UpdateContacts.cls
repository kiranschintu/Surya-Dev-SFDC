/***
Executing trigger before actions
***/
public class UpdateContacts implements AccountTriggerActions{
    public static void beforeActions(List<SObject> records){
        List<Account> accs = (List<Account>)records;
        for(Account acc:accs){
            acc.Description +='Hello From Triggger :UpdateContacts';
        }
    }
    
    public static void afterActions(List<sObject> records){}
}