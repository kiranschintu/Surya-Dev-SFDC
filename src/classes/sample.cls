public class sample {

    
    // Static variable that assumes a test is not running
    //Public String num{get;set;}
    
    public String main(){
 
        // Do a whole bunch of stuff
 
        // Build the http request
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.mVaayoo.com/mvaayooapi/MessageCompose?user=kiranch726@yahoo.com:8125931509dh&senderID=TEST SMS&receipientno=8125931509&dcs=0&msgtxt=This is Test message&state=0&');
        req.setMethod('POST');
       ApexPages.Message didNotSendMsg = new ApexPages.Message(ApexPages.severity.Info, 'Sorry'+req);
               ApexPages.addMessage(didNotSendMsg);
        // Invoke web service call
        String result = '';
        // Make a real callout since we are not running a test
            HttpResponse res = h.send(req);
            result = res.getBody();
        
        // Do whole bunch of stuff
 
        return null;
    }
 
    // Wrapper method for "main" that we will call in the Test Class
    
}