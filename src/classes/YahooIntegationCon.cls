public class YahooIntegationCon {

    public Contact con;
    public YahooIntegationCon(ApexPages.StandardController controller) {
        this.con = (Contact)controller.getRecord();
    }
   
    public pagereference dosave(){
        
       HttpRequest req = new HttpRequest();
       req.setEndpoint('http://www.google.com');
       req.setMethod('GET');
       String username = 'kirans.chintu';
       String password = 'surya99495';
       Blob headerValue = Blob.valueOf(username + ':' + password);
       String authorizationHeader = 'BASIC ' +
       EncodingUtil.base64Encode(headerValue);
       //req.setHeader('Authorization', authorizationHeader);
       
       HttpResponse res = new Http().send(req);
       String h = res.getBody();
       
        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info,'This is Response of Yahoo.com' + res.getBody());
        ApexPages.addMessage(msg);
    return null;
    }
  
  }