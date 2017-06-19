global class MassUpdateoppmonth implements Database.Batchable<sObject> {

String query = 'Select id,CloseDate,Opp_Month__c from Opportunity';
   
      
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //delete scope;
        List<Opportunity> opp = new List<Opportunity>();

   for(sObject s : scope){
   Opportunity op = (Opportunity)s;
       if(op.CloseDate.Year()==system.today().Year()){
            op.Opp_Month__c = 'Current year';
            opp.add(op);
            }
       
       
        if(op.CloseDate.Year()==DateTime.now().Year()){
            op.Opp_Month__c = 'Current year';
            opp.add(op);
            }
          else if(op.CloseDate.Year()==(DateTime.now().Year()-1)){
              op.Opp_Month__c = 'Previous year';
              opp.add(op);
          }
          else if(op.CloseDate.Year()==(DateTime.now().Year()-2)){
              op.Opp_Month__c = 'Before Previous Year';
              opp.add(op);
          }
          
        }

update opp;
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