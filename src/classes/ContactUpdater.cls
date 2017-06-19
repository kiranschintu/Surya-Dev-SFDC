public class ContactUpdater {
    //public String sf{get;set;}
   
    public ContactUpdater(ApexPages.StandardController controller) {

    }

    public String user='kiranch726@yahoo.com:8125931509dh';
    public String senderID='TEST%20SMS';
    public String receipientno='8125931509';
    public String dcs='0';
    public String msgtxt='This%20is%20Test%20message';
    public String state='0';
    String endpoint = 'http://api.mVaayoo.com/mvaayooapi/MessageCompose';
  //Future annotation to mark the method as async.
  
  public PageReference updateAccount() {

    //construct an HTTP request
    HttpRequest req = new HttpRequest();
    //req.setEndpoint('http://api.mvaayoo.com/mvaayooapi/MessageCompose?user=kiranch726@yahoo.com:8125931509dh&senderID=TEST%20SMS&receipientno=8125931509&dcs=0&msgtxt=This%20is%20Test%20message&state=0');
    req.setEndpoint(endpoint+'?user='+user+
                             '&senderID='+senderID+
                             '&receipientno='+receipientno+
                             '&dcs='+dcs+
                             '&msgtxt='+msgtxt+
                             '&state='+state);
    req.setMethod('GET');

    //send the request
    Http http = new Http();
    HttpResponse res = http.send(req);

    //check the response
    if (res.getStatusCode() == 200) {

      ApexPages.Message didNotSendMsg = new ApexPages.Message(ApexPages.severity.Info, 'success'+req);
               ApexPages.addMessage(didNotSendMsg);
      //update account
      Contact acc = new Contact(Id=ApexPages.currentPage().getParameters().get('id'));
      acc.Description = res.getBody();
      update acc;
      //return null;
      
    } else {
      System.debug('Callout failed: ' + res);
    } return null;
  }
}