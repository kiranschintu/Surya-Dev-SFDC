global class MassUpdateRecords implements  Database.Batchable<sObject> {

global final string query;// = 'SELECT id,name,ownerid from Account where ownerid=\'00590000000zui5\'';
String email;// = 'kiranschintu@gmail.com';
Id toUserId;// = '00590000000z91P';
Id fromUserId;// = '00590000000zui5';

    global MassUpdateRecords (String q,String em,Id tou,Id frmu)
    {
       query = q;
       email = em;
       toUserId = tou;
       fromUserId = frmu;
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //delete scope;
        List<Account> accns = new List<Account>();

   for(sObject s : scope){Account a = (Account)s;
        if(a.OwnerId==fromUserId){
            a.OwnerId=toUserId;
            accns.add(a);
            }
        }

update accns;
    }


global void finish(Database.BatchableContext BC){
  // Get the ID of the AsyncApexJob representing this batch job  
  // from Database.BatchableContext.    
  // Query the AsyncApexJob object to retrieve the current job's information.  

    AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
    TotalJobItems, CreatedBy.Email
    from AsyncApexJob where Id =:BC.getJobId()];

  // Send an email to the Apex job's submitter notifying of job completion.  
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {a.CreatedBy.Email};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Apex Sharing Recalculation ' + a.Status);
    mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
    ' batches with '+ a.NumberOfErrors + ' failures.');

  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
/*global PageReference dosome(){
    //MassUpdateRecords batchapx = new MassUpdateRecords(query,email,toUserId,fromUserId);
    ID batchprocessid = Database.executeBatch();
    return null;
}*/


}