global class batchforDateTime implements Database.Batchable<sObject>{//,database.stateful{
    
   
   DateTime d=system.NOW();
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT id,name,phone from Contact]);
   }
   
   global void execute(Database.BatchableContext bc,List<Contact> scope){
       List<Contact> bat2=new List<Contact>();
       
       for(Contact b:scope){
           b.phone='99999';
           b.description=''+d;
           bat2.add(b);
           
       }
       system.debug('Time'+d);
       update bat2;
   }
   
   global void finish(Database.BatchableContext bc){
  
   }
}