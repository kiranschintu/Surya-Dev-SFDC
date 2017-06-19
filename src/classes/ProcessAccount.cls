public class ProcessAccount{
    public void doSome(Account acc){
        Account ac = new Account();
        ac.id=acc.id;
        ac.rating='Hot';
        update ac;
    }
}