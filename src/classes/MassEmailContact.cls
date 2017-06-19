global class MassEmailContact implements Database.Batchable<sObject>,Database.stateful {


String query = 'Select id,name,email from contact';
   
      
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //delete scope;
        List<Contact> accns = new List<Contact>();
        

   for(sObject s : scope){Contact a = (contact)s;
       
       
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {a.Email};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Apex Sharing Recalculation ');
    mail.setPlainTextBody('The batch Apex job processed ' );
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

update accns;
    }


global void finish(Database.BatchableContext BC){
      
}

}