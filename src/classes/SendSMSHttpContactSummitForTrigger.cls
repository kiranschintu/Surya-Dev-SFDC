public class SendSMSHttpContactSummitForTrigger {
    
    @Future(callout=true)
    public static void SendSMS(String id) {
    
    Account account =[select id,name,phone from Account where id =:id];
    final String user='kiranch';
    final String password='dVDIdGMITRMHJV';
    final String api_id='3424583';
    String receipientno=account.phone;
    final String dcs='0';
    String msgtxt='Hello Karthik';
    //public String msg ;
    final String state='0';
    String endpoint = 'http://api.clickatell.com/http/sendmsg';
      
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
    //req.setEndpoint('http://api.clickatell.com/http/sendmsg?user='+user+'&password='+password+'&api_id='+api_id+'&to=918125931509&text=hello');
    req.setEndpoint(endpoint+'?user='+user+
                             '&password='+password+
                             '&api_id='+api_id+
                             '&to='+receipientno+
                             '&text='+msgtxt);
    
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
                                      WhatID = account.id,
                                      Status = 'Completed',
                                      ActivityDate = System.today(),
                                      Description = 'sample',
                                      Subject = 'SMS Sent'
                                     );
             try {
                insert smsTask;
             }  catch (System.Dmlexception e) {
                   System.debug('Error: Unable to insert task: ' + e);
                 }
 
             
      
    } 
    
    
     
  }
      
   }   
  }