public class TestingCalloutExamplesample {

    // Make an HTTP callout to an external Web server 
    
   
    /*public void TotalPrice() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.cheenath.com/tutorial/sfdc/sample1/response.php');
        req.setMethod('GET');
          
        HttpResponse res = makeCallout(req);
        
         
        // Parse results 
    
        
    }
  
    // Send the request to the external Web server, 
    
    // or create a fake response for tests. 
    
    private HttpResponse makeCallout(HttpRequest req) {
        HttpResponse res;
         
        if (Test.isRunningTest()) {
        res = createMockResponse();} 
        else {
            res = new Http().send(req);
        } return res;
    }
     
    private HttpResponse createMockResponse() {
        HttpResponse res = new HttpResponse();
        res.setStatus('OK'); // all are new methods 
    
        res.setStatusCode(200);        
        
        return res;
    }*/
    
    public PageReference send(){
           /*TestingCalloutExamplesample ob = new TestingCalloutExamplesample();
           ob.TotalPrice();*/
           
           HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.cheenath.com/tutorial/sfdc/sample1/response.php');
        req.setMethod('GET');
          
        HttpResponse res;
        if (Test.isRunningTest()) {
        res = new HttpResponse();
        res.setStatusCode(200);
        } 
        else {
            res = new Http().send(req);
        } 
        if(res.getStatusCode()==200){
            Task  smsTask = new Task (Type='SMS',
                                      Status = 'Completed',
                                      ActivityDate = System.today(),
                                      Subject = 'SMS Sent'
                                     );
        }else{
            return null;
        }
         return null;
   
   }
   
       
}