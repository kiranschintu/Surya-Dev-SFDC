public class SavePointCheck{
    public static void doSome(){
        //Savepoint for transaction
        Savepoint sp = Database.setSavepoint();
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(name='Account 1',Rating='Hot'));
        accounts.add(new Account(name='Account 2',Rating='Cold'));
        for(Account a:accounts){
            if(a.Rating=='Hot'){
                InsertData(a);
            }else{
                //Database.rollback(sp);
                break;//stopping the transaction
            }
        }
    }
    
    public static void InsertData(Account ac){
        insert ac;
        system.debug('Inserted:::'+ac.id);
    }
}