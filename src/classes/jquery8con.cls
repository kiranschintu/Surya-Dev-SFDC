public with sharing class jquery8con {
   public List<Account> accounts{get;set;}
    public jquery8con(){
    accounts=[select id,name from Account limit 10];
    }
}