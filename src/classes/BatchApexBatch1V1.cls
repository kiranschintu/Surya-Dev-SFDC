global class BatchApexBatch1V1 implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT id,name from Batch1__c]);
   }    
   
   global void execute(Database.BatchableContext bc,List<Batch1__c> scope){
       List<Batch2__c> bat2=new List<Batch2__c>();
       
       for(Batch1__c b:scope){
               batch2__c ba2= new Batch2__C();
               ba2.Name = b.name;
               bat2.add(ba2);
           
       }
       
       if(!bat2.isEmpty())
       insert bat2;
   }
   
   global void finish(Database.BatchableContext bc){}
}