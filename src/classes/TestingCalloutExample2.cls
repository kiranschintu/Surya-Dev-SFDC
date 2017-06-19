public class TestingCalloutExample2 {
    public contact con;
    
    public TestingCalloutExample2(ApexPages.StandardController controller) {
    
        this.con = (Contact)controller.getRecord();
               

    }
    public pagereference dosave(){
        
       HttpRequest req = new HttpRequest();
       req.setEndpoint('http://www.cheenath.com/tutorial/sfdc/sample1/data.txt');
              req.setMethod('GET');
       HttpResponse res = new Http().send(req);
      String h = res.getBody();
       if(res.getstatuscode()==200){
           con.description = h;
         }
        update con;
        pageReference p = new pageReference('/' + con.id);
    p.setRedirect(true);
    return p;
    }
  
  }