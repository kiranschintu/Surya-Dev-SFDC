@isTest
private class TestingCalloutExample {

    public void totalPrice() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.cheenath.com/tutorial/sfdc/sample1/response.php');
        req.setMethod('GET');
          
        HttpResponse res = makeCallout(req);
        System.assert(res.getStatusCode() == 200);    
        
       }
       private HttpResponse makeCallout(HttpRequest req) {
        HttpResponse res;
         
        if (Test.isRunningTest()) {             res = createMockResponse();         } else {
            res = new Http().send(req);
        } return res;
    }
   private HttpResponse createMockResponse() {
        HttpResponse res = new HttpResponse();
        res.setStatus('OK'); // all are new methods 
    
        res.setStatusCode(200);        
        
        return res;
    }
   
    static testmethod void testCalloutMethod() {
        TestingCalloutExample demo = new TestingCalloutExample();
        
       demo.totalPrice();
        
        String endpoint='http://google.com';       
        Contact con = new Contact();
        con.LastName = 'test';
        con.MobilePhone ='12345';
        insert con;
        //String msgtxt;
            
        ApexPages.StandardController controller = new ApexPages.StandardController(con);
        SendSMSfortest test1 = new SendSMSfortest(controller);
        test1.msgtxt = 'hello kiran' ;
        PageReference endPage = test1.SendSMS();
        System.assertEquals(endPage.getUrl(),'http://www.salesforcewebform.com/thankyou.html');
        
        // Verify fake results 
    
        //System.assert(price == 17.0);
    }
    
       
}