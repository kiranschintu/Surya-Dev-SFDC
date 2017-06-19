global class SendEmailToOpportContactBatch implements Database.batchable<sObject>,Schedulable{
    global Database.queryLocator start(Database.batchableContext bc){
        Date dt=system.today()+5;
        return Database.getQueryLocator([select id,name,Constituent__c from Opportunity where CloseDate=:dt AND stageName!='Closed Won']);
    }
    
    global void execute(Database.batchableContext bc,List<Opportunity> opps){
        List<Messaging.singleEmailMessage> mails = new List<Messaging.singleEmailMessage>();
        Set<Id> contactIds = new Set<Id>();
        for(Opportunity opp : opps){
            contactIds.add(opp.Constituent__c);
        }
        //Retrieve Email Template
        EmailTemplate empt = [select id,name from EmailTemplate where name='New Contact' limit 1];
        //for(Contact con : [Select id,FirstName,LastName,name,Email from Contact where id IN:contactIds]){
        for(Id conId : contactIds){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(conId);
            mail.setTemplateId(empt.id);
            mails.add(mail);
        }
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
    }
    
    global void finish(Database.batchableContext bc){
    
    }
    
    //Schedule Apex execute method
    global void execute(SchedulableContext sc){
        //execute batch from here
        SendEmailToOpportContactBatch stopc = new SendEmailToOpportContactBatch();
        Database.executeBatch(stopc);
    }
}