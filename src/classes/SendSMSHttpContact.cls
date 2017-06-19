public class SendSMSHttpContact {
    
    private final Account account;
    private final String user='anil.a@vertexcs.com:Vertex@143';
    private final String senderID='TEST%20SMS';
    public String receipientno{get;set;}
    private final String dcs='0';
    public String msgtxt{get;set;}
    //public String msg ;
    private final String state='0';
    String endpoint = 'http://api.mVaayoo.com/mvaayooapi/MessageCompose';
    
    public SendSMSHttpContact(ApexPages.StandardController controller) {
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
                        
    Http http = new Http();
    //construct an HTTP request
    HttpRequest req = new HttpRequest();
    
    req.setMethod('GET');
    req.setEndpoint(endpoint+'?user='+user+
                             '&senderID='+senderID+
                             '&receipientno='+receipientno+
                             '&dcs='+dcs+
                             '&msgtxt='+msgtxt+
                             '&state='+state);
    
    //send the request
      HttpResponse res;
        /*if (Test.isRunningTest()) {
        res = new HttpResponse();
        res.setStatusCode(200);
        } 
        else {*/
            res = new Http().send(req);
            //}
       
         //check the response
    if (res.getStatusCode() == 200) {

     Task  smsTask = new Task (Type='SMS',
                                      WhatID = account.id,
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
 
           //return new ApexPages.StandardController(contact).view();
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