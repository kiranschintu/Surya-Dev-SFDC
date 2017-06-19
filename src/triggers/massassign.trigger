trigger massassign on Account (after update) {
    
   /* public Set<Id> SetAccountId = new Set<Id>();
 for(Account objAccount: [Select Id from Account where Id in : Trigger.new])
 {
  SetAccountId.add(objAccount.Id);
 }
 if(!SetAccountId.isEmpty())
 {
  string query='Select id,name,ownerid,description from Account where Id IN :SetAccountId';
  BatchToUpdateContactType objBatchToUpdateContactType=new BatchToUpdateContactType(query);
  Database.executeBatch(objBatchToUpdateContactType);
  MassUpdateDescriptionAcc batchApex = new MassUpdateDescriptionAcc(query);
    Database.executeBatch(batchApex);
    //ID batchprocessid = Database.executeBatch(batchApex);
 }*/
    MassUpdateDescriptionAcc batchApex = new MassUpdateDescriptionAcc();
    Database.executeBatch(batchApex);
    ID batchprocessid = Database.executeBatch(batchApex,100);
     
    
}