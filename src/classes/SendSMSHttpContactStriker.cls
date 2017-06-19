public class SendSMSHttpContactStriker {
    
    private final Account account;
    private final String username = 'AISFMH';
    private final String password = 'aisfmh';
    private final String fromname = 'aisfmh';   
    public String receipientno{get;set;}
    public String msgtxt{get;set;}
    private final String type='1';
    String endpoint = 'http://www.smsstriker.com/API/sms.php';
    
    public SendSMSHttpContactStriker(ApexPages.StandardController controller) {
        this.account = (Account)controller.getRecord();
    }

   public PageReference SendSMS() {
      
      if (account.Phone != null) {
            
            receipientno = account.Phone;
            receipientno = receipientno.replace('+','');
            receipientno = receipientno.replace(' ','');
            receipientno = receipientno.replace(')','');
            receipientno = receipientno.replace('(','');
            receipientno = receipientno.replace('-','');
            msgtxt = msgtxt.replace(' ','%20');
                        
    //construct an HTTP request
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    req.setEndpoint(endpoint+'?username='+username+
                             '&password='+password+
                             '&from='+fromname+
                             '&to='+receipientno+
                             '&msg='+msgtxt+
                             '&type='+type);
    
    //send the request
    HttpResponse res;
        if (Test.isRunningTest()) {
        res = new HttpResponse();
        res.setStatusCode(200);
        } 
        else {
            res = new Http().send(req);
            }
    
    //check the response
    if (res.getStatusCode() == 200) {

     Task  smsTask = new Task (Type='SMS',
                                      WhoID = account.id,
                                      Status = 'Completed',
                                      ActivityDate = System.today(),
                                      Description = msgtxt.replace('%20',' '),
                                      Subject = 'SMS Sent'
                                     );
             try {
                insert smsTask;
             }  catch (System.Dmlexception e) {
                   System.debug('Error: Unable to insert task: ' + e);
                 }
 
           PageReference pg = new PageReference('/'+smsTask.Id);
           return pg;
          
    } else {
      ApexPages.Message didNotSendMsg = new ApexPages.Message(ApexPages.severity.Info, 'Sorry, but the SMS did not send correctly with following Reasong' + res + 'Please try again.');
               ApexPages.addMessage(didNotSendMsg);
               return null;
    } 
  }
      else {
             //this message will be triggered if the Contact doesn't have a mobile phone number.
             ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'This Contact does not have a mobile phone number.  Please update the mobile number and try again.');
             ApexPages.addMessage(noMobileMsg);
             return null;
          }
  }
        
}