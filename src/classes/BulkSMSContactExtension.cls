public with sharing class BulkSMSContactExtension {

    public BulkSMSContactExtension(ApexPages.StandardSetController controller) {
         List<Contact> ccc=[select MobilePhone from Contact limit 2];
        for(Contact a:ccc){
           if(a.MobilePhone!=null){
              Comb=a.MobilePhone+','+Comb;
           } 
        }
        cc=ccc;
    }


         
    Private List<Contact> cc;
    public String Comb='';
    
    private final String TOKEN = 'bb83f60c-c9fd-4dbf-a023-94f2dff5f54e';
    private final String SIGNATURE = '3WT8uw3Nx4OtmimmoFnPGBn+';
    private final String ENCODING = 'Seven';
    public String recipients {get; set;}
    public String message {get; set;}
    
    public String getContacts(){
        return Comb;
    }
    
    public PageReference sendSMS () {
       if (Comb != null) {
 
          //this reformats the phone number as required by the web service; removes all spaces and characters while adding the country code.  Currently
          //it's hardcoded to insert the U.S. country code prefix.
          recipients = Comb;
          recipients = recipients.replace('-', '');
          recipients = recipients.replace('(','');
          recipients = recipients.replace(')','');
          recipients = recipients.replace(' ', '');
 
          //initialize the SOAP object and call the web service 'Send_Plain'.  Set the timeout.
          upsidewirelessComWebserviceSms.SMSSoap sms = new upsidewirelessComWebserviceSms.SMSSoap();
          sms.timeout_x = 2000;
          upsidewirelessComWebserviceSms.SMSSendMultipleResult result = sms.Send_Plain_Multiple(TOKEN,SIGNATURE,recipients,message,ENCODING);
 
          //Create a new task, related to the Contact, if the response is successful.
          if (result.isOk == true) {
             Task smsTask = new Task (Type='SMS',
                                      Status = 'Completed',
                                      ActivityDate = System.today(),
                                      Description = message,
                                      Subject = 'SMS Sent'
                                     );
             try {
                insert smsTask;
             }  catch (System.Dmlexception e) {
                   System.debug('Error: Unable to insert task: ' + e);
                 }
             
             return null;
             //return new ApexPages.StandardController(acct).view();
 
          } else {
               //this message will be triggered if the text was not sent successfully.
               ApexPages.Message didNotSendMsg = new ApexPages.Message(ApexPages.severity.Info, 'Sorry, but the SMS did not send correctly.  Please try again.');
               ApexPages.addMessage(didNotSendMsg);
               return null;
             } //close else
 
       } //close first if-statement
          else {
             //this message will be triggered if the Contact doesn't have a mobile phone number.
             ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'This Contact does not have a mobile phone number.  Please update the mobile number and try again.');
             ApexPages.addMessage(noMobileMsg);
             return null;
          }
           
    } //close sendSMS method
    public PageReference cancel () {
       //sends the user back to the Contact detail page.
       //PageReference contactPage = new ApexPages.StandardController(acct).view();
       //setRedirect(false);
       return null;
       //return contactPage;
    } //close cancel method

}