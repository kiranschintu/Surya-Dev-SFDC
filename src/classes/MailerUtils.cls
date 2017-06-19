public class MailerUtils {
      
    Public static void sendMail() {
     list<contact> con = [select email from contact where id='0039000000FcXqr'];
     
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        //String[] toAddresses=new String[]{'kirans.chintu@gmail.com','suryakiran@dhruvsoft.com','suryakiran.chintala@gmail.com'};
        //List<String> toAddresses;
        String[] toAddresses=new String[]{'0039000000FcXqr'};
        mail.setToAddresses(toAddresses);
 
        mail.setSubject('This is for testing purpose');
        system.debug('Hello');
 
        mail.setUseSignature(false);
        mail.setHtmlBody('Hello');
 
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
 
    }   
    
    
 
    
}