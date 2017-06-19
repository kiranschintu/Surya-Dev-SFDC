global class BatchApexTranAccount implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT id,name,phone from Account]);
    }
    
    global void execute(Database.BatchableContext bc,List<sObject> scope){
        List<Account> account=new List<Account>();
        for(sObject s:scope){
            Account a=(Account)s;
            a.phone='8125931509';
            account.add(a);
        }
        Database.update(account,false);
    }
    
    global void finish(Database.BatchableContext bc){
    
    }
}