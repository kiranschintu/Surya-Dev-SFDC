public with sharing class MultipleBlocksCls {
    public Account acc{get;set;}
    public Contact con{get;set;}
    public List<Account> accs{get;set;}
    public List<Contact> cons{get;set;}

    
    public MultipleBlocksCls(){
        acc = new Account();
        con = new Contact();
    }
    
    public void doAccSearch(){
        system.debug('Acc>>>'+acc);
        if(acc.Name!=null){
            accs = [select id,name,phone,Industry from Account limit 10];
        }
    }
    
    public void doConSearch(){
        cons = [select id,name,phone,Email from Contact limit 10];
    }
}