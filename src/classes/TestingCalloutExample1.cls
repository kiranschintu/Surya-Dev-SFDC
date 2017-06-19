public class TestingCalloutExample1 {

    public TestingCalloutExample1(ApexPages.StandardController controller) {

    }

    public contact con;
    Double grandTotal=0;
    public double getTotalPrice() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.cheenath.com/tutorial/sfdc/sample1/response.php');
        req.setMethod('GET');
         
        HttpResponse res = new Http().send(req);
         
        //HttpResponse res = makeCallout(req);
        
        // Parse results 
    
        JSONParser parser = JSON.createParser(res.getBody());
        
       
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'totalPrice')) {
                // Get the value.     
   
                parser.nextToken();
                // Compute the grand total price for all invoices.  
    
                 grandtotal = parser.getDoubleValue();
            }
        }
       
        system.debug('Grand total=' + grandTotal);
    /*
    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info,''+grandTotal);
    ApexPages.addMessage(msg);
        return null;*/
       
          return grandtotal;
    }
  
  }