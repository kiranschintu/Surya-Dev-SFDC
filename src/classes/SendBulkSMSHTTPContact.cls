public class SendBulkSMSHTTPContact {

    private String user = 'prasad.vad@gmail.com:8125931509dh';
    private String senderID = 'TEST%20SMS';
    private String dcs = '0';
    Private String state = '0';
    public String receipientnos {get; set;}
    public String msgtxt {get; set;}
    private String endpoint = 'http://api.mVaayoo.com/mvaayooapi/MessageCompose';
    private List<Contact> acc;
    public String Combination = '';
            
    public SendBulkSMSHTTPContact(ApexPages.StandardSetController controller) {
        if(!Test.isRunningTest()){
           acc = (List<contact>)controller.getSelected();
         }else
            {
             acc = [Select mobilephone From Contact Limit 1];
             }
        for (contact ac:acc){
            if(ac.MobilePhone != null){
                Combination = ac.MobilePhone+','+Combination;
                }else{
                Combination = '';
                break;   
           }
           }
      }
    public String getSomething(){
             return Combination;
    }
    Public PageReference SendSMS(){
    
            if (Combination != '') {
            if(acc.size() <150){
            receipientnos = Combination;
            receipientnos = receipientnos.replace('+','');
            receipientnos = receipientnos.replace(' ','');
            receipientnos = receipientnos.replace(')','');
            receipientnos = receipientnos.replace('(','');
            receipientnos = receipientnos.replace('-','');
            msgtxt = msgtxt.replace(' ','%20');
    //construct an HTTP request
    HttpRequest req = new HttpRequest();
    
    req.setEndpoint(endpoint+'?user='+user+
                             '&senderID='+senderID+
                             '&receipientno='+receipientnos+
                             '&dcs='+dcs+
                             '&msgtxt='+msgtxt+
                             '&state='+state);
    req.setMethod('GET');

    //send the request
    Http http = new Http();
    
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
        
        for(Integer i=0;i<acc.size();i++){
         Task smsTask = new Task (Type='SMS',
                                      WhoID = acc[i].id,
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
             }
          //return page.BulkSMSHTTPCSucess;
        ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'checking'+' '+req+' '+res);
             ApexPages.addMessage(noMobileMsg);
        return null;
        
     } else {
          ApexPages.Message didNotSendMsg = new ApexPages.Message(ApexPages.severity.Info, 'Sorry, but the SMS did not send correctly with following Reasong' + res + 'Please try again.');
               ApexPages.addMessage(didNotSendMsg);
               return null;
    } 
    
    } 
    else {
             //this message will be triggered if the Contacts exceed the limit.
             ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'Contacts does not exceed 150');
             ApexPages.addMessage(noMobileMsg);
             return null;
          }
    
  }
      else {
             //this message will be triggered if the Contact doesn't have a mobile phone number.
             ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'You have selected the Contacts which does not have Mobile Numbers.Please Select valid Contacts');
             ApexPages.addMessage(noMobileMsg);
             return null;
          }
      
  
  }
   
}