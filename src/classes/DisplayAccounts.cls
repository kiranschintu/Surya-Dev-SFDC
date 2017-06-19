public with sharing class DisplayAccounts{
    
    //This method can be used to disply all Accounts
    public List<Account> getAllAccounts(){
        List<Account> acc = [SELECT id,name,phone,website from Account];
        
        /* ---Sending Email From Apex-- */
        
        //Create a mail object to send a single email.
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        
        //Set the Email properties
        String[] toAddresses =new String[]{'sample@dhruvsoft.com'};
        msg.setToAddresses(toAddresses);
        msg.setEmailPriority('EmailPriority.High');
        msg.setReplyTo('person1@salesforce.com');
        msg.setSaveAsActivity(false);
        msg.setSubject('This is how you use the ' + 'sendEmail method.'); 
        msg.setPlainTextBody('Welcome .....');
        
        //send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg} );
        
        return acc;
    }
}