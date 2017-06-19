public class sendingemailcon {

    public string email{get;set;}
    public string subject{get;set;}
    public string body{get;set;}
    public sendingemailcon(ApexPages.StandardController controller) {

    }
    public PageReference sendEmail(){
        try{
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'suryakiran@dhruvsoft.com' limit 1];
        //create a mail object to send a single email.
        //String replyemail = userinfo.getUserEmail();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
        //set the email properties
        String[] toAddresses = new String[] {email};
        mail.setToAddresses(toAddresses);
        //mail.setorgWideEmailAddressId(owea.get(0).Id);
        mail.setReplyTo('kirans.chintu@gmail.com');
        mail.setSenderDisplayName('SF.com Email Agent');
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        
        //send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );
        return null;
        }catch(Exception e){
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'suryakiran@dhruvsoft.com' limit 1];
        //create a mail object to send a single email.
        //String replyemail = userinfo.getUserEmail();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
        //set the email properties
        String[] toAddresses = new List<String> {email};
        mail.setToAddresses(toAddresses);
        //mail.setorgWideEmailAddressId(owea.get(0).Id);
        mail.setReplyTo('kirans.chintu@gmail.com');
        mail.setSenderDisplayName('SF.com Email Agent');
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        
        //send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );
        
        return null;
        }
    }
}