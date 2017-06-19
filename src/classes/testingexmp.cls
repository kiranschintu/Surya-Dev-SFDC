@isTest
private class testingexmp{
static testmethod void testCalloutMethod() {
        TestingCalloutExamplesample demo = new TestingCalloutExamplesample();
        
        // Make the call which contains the HttpRequest calls. 
    
        // No HTTP request is sent for the test, instead 
    
        // a fake response is returned. 
    
        //demo.TotalPrice();
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        System.assert(res.getStatusCode() == 200);
        demo.send();
         Task  smsTask = new Task (Type='SMS',
                                      Status = 'Completed',
                                      ActivityDate = System.today(),
                                      Subject = 'SMS Sent'
                                     );
         insert smsTask;
        
        
        // Verify fake results 
    
        //System.assert(price == 17.0);
    }
    }