public class SendEmailContact {

    public SendEmailContact() {

    }

    public String subject { get; set; }
    public String body { get; set; }

    public SendEmailContact(ApexPages.StandardController controller) {
        
    }

    public PageReference send() {
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

        List<String> toAddresses = new List<String>();
        toAddresses.add('kirans.chintu@gmail.com');

        // Sets the paramaters of the email
        email.setSubject( subject );
        email.setToAddresses( toAddresses );
        email.setPlainTextBody( body );
    
        // Sends the email
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        
        return null;
    }
}