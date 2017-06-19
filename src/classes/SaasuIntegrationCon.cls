public class SaasuIntegrationCon {

    public SaasuIntegrationCon() {

    }

    Public Contact con;
    public String name;    
    public SaasuIntegrationCon(ApexPages.StandardController controller) {
    
        this.con = (Contact)controller.getRecord();
               

    }
    public pagereference dosave(){
       
       HttpRequest req = new HttpRequest();
       req.setEndpoint('https://secure.saasu.com/webservices/rest/r1/Contact?wsaccesskey=08617D99BB7D45D9878A1D071EB7168E&FileUid=35294&uid=5072185');
       req.setMethod('GET');
       HttpResponse res = new Http().send(req);
       String xml_resp = res.getBody().replace('\n','');
       
       
       
        
        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info, 'check it :'+res.getBody()+' '+name);
        ApexPages.addMessage(msg);
        
        return null;
    
    }
   
}