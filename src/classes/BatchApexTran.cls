public class BatchApexTran implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT id,name,description from Account]);
    }
    public void execute(Database.BatchableContext bc,List<Account>  scope){
        List<Account> accountsss=new List<Account>();
        Set<String> myStr = new Set<String>();
        for(Account a:scope){
        accountsss.add(a);
        }
        update accountsss;
    }
    public void finish(Database.BatchableContext bc){
        FutureCls.docall();
        system.debug('Batch Apex Completed');
    }
}