public class IN_accountcon {

    

    public List<Account> acc{get;set;}
    
    public List<Account> getrecords() {
        acc = [SELECT id,name,phone FROM Account];
        return acc;
    }
}