public with sharing class deleteaccountscon {
    
    public pagereference deleteacc(){
        List<Account> acc = [select id,name from Account];
        Database.delete(acc,false);
        return null;
    }
}