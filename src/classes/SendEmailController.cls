public class SendEmailController{
    public String subject{get;set;}
    public String body{get;set;}
    public String sourceObject{get;set;}
    public Id recordId{get;set;}
    List<String> toAddresses;

    public SendEmailController(){
        toAddresses = new List<String>();
        if(sourceObject=='Event'){
            prepareEventReceipents();
        }else if(sourceObject=='Schedule Item'){
            prepareScheuleItemReceipents();        
        }
    }
    
    public void prepareEventReceipents(){
        /*EventApi__Event__c --> EventApi__Attendee__c - EventApi__Preferred
        for(EventApi__Attendee__c attendee:[Select id,name,EventApi__Preferred__c from EventApi__Attendee__c where EventApi__Event__c=:recordId where EventApi__Preferred__c!=null]){
            toAddresses.add(attendee.EventApi__Preferred__c);
        }*/
    }
    
    public void prepareScheuleItemReceipents(){
        /*for(EventApi__Registration_Item__c regItem:[Select id,name,EventApi__Attendee__r.EventApi__Preferred_Email__c from EventApi__Registration_Item__c where EventApi__Schedule_Item__c=:recordId where EventApi__Attendee__r.EventApi__Preferred_Email__c!=null]){
            toAddresses.add(attendee.EventApi__Preferred__c);
        }*/
    }

    public PageReference send() {
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

        
        // Sets the paramaters of the email
        email.setSubject( subject );
        email.setToAddresses( toAddresses );
        email.setPlainTextBody( body );
    
        // Sends the email
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        
        return null;
    }
    
    /****
    
    1. EventApi__Event__c --> EventApi__Attendee__c - EventApi__Preferred_Email__c

2.EventApi__Schedule_Item__c --> EventApi__Registration_Item__c -EventApi__Attendee__r.EventApi__Preferred_Email__c
    ****/
}