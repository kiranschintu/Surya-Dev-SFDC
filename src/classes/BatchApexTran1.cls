global class BatchApexTran1 implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        //return Database.getQueryLocator([SELECT id,name,description from Account]);
        return null;
    }
    global void execute(Database.BatchableContext bc,List<sObject>  scope){
       // List<Account> account=new List<Account>();
        //for(sObject o:scope){
        
        Account a=new Account();    
        a.name='Using Batch';
        insert a;
        System.debug('Hello : '+a);
        //account.add(a);
        //}
        //update account;
    }
    global void finish(Database.BatchableContext bc){
        
        system.debug('Batch Apex Completed');
    }
}