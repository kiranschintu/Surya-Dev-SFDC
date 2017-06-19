global class S2SBatch1 implements Database.Batchable<sObject>,database.stateful{
    
   
   global Map<String,String> insertrecords = new Map<String,String>();
   
   global Database.QueryLocator start(Database.BatchableContext BC){
    return Database.getQueryLocator([SELECT id,LocalRecordId,status,ParentRecordId FROM PartnerNetworkRecordConnection WHERE status='Invite']);
   }
   
   global void execute(Database.BatchableContext bc,List<PartnerNetworkRecordConnection> scope){
       List<PartnerNetworkRecordConnection> pnrs = new List<PartnerNetworkRecordConnection>();
       for(PartnerNetworkRecordConnection pnr : scope){
        insertrecords.put(pnr.LocalRecordId,pnr.LocalRecordId);
        pnrs.add(pnr);
        }
        delete pnrs;
   }
   
   global void finish(Database.BatchableContext bc){
    S2sCalledClass.doshare(insertrecords);
   }
}