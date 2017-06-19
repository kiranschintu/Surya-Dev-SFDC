global class MassUpdateDescriptionAcc implements Database.Batchable<sObject>,Database.stateful {


String query = 'Select id,name,ownerid,description from Account';
   
      
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //delete scope;
        List<Account> accns = new List<Account>();

   for(sObject s : scope){Account a = (Account)s;
        
            a.Batch__c = 'This is mass update';
            accns.add(a);
           
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

}