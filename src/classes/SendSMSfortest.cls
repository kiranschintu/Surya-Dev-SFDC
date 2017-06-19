public class SendSMSfortest {
    
    private final Contact contact;
    private final String user='kiran3chintu@yahoo.com:9505696710dh';
    
    public String receipientno{get;set;}
    public String msgtxt{get;set;}
    public String msg;
    String endpoint = 'http://api.mVaayoo.com/mvaayooapi/MessageCompose';
    
    public SendSMSfortest(ApexPages.StandardController controller) {
        this.contact = (Contact)controller.getRecord();
    }

   public PageReference SendSMS() {
      
      if (contact.MobilePhone != null) {
            
            receipientno = contact.MobilePhone;
            receipientno = receipientno.replace('+','');
            receipientno = receipientno.replace(' ','');
            receipientno = receipientno.replace(')','');
            receipientno = receipientno.replace('(','');
            receipientno = receipientno.replace('-','');
            msg = msgtxt.replace(' ','%20');
                        
    
    
    HttpResponse res = new HttpResponse();
    //send the request
      
      res = createMockResponse();
    
    //check the response
    if (res.getStatusCode() == 200) {

           PageReference pg = new PageReference(contact);
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
  return null;
  }
  private HttpResponse createMockResponse() {
  
  Http http = new Http();
    //construct an HTTP request
    HttpRequest req = new HttpRequest();
    
    req.setMethod('GET');
    req.setEndpoint(endpoint+'?user='+user+
                             
                             '&receipientno='+receipientno+
                             
                             '&msgtxt='+msg
                             );
        HttpResponse res = new HttpResponse();
         // all are new methods 
    //res.send(req);
        res.setStatusCode(200);
        res = http.send(req);
         return res;
    }
   
      
}