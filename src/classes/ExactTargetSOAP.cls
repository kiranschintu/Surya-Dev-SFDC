public class ExactTargetSOAP {
    public static List<String> getEmailList(){
        String xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><wsse:Security soapenv:mustUnderstand="1" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"><wsse:UsernameToken wsu:Id="UsernameToken-24440876" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"><wsse:Username>##USERNAME##</wsse:Username><wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">##PASSWORD##</wsse:Password></wsse:UsernameToken></wsse:Security></soapenv:Header><soapenv:Body><RetrieveRequestMsg xmlns="http://exacttarget.com/wsdl/partnerAPI"><RetrieveRequest><ObjectType>List</ObjectType><Properties>ID</Properties><Properties>List.ListName</Properties><Properties>List.Type</Properties><Properties>List.Category</Properties><Properties>Client.ID</Properties></RetrieveRequest></RetrieveRequestMsg></soapenv:Body></soapenv:Envelope>';
        makeRequestNow(xml);
        return null;
    }
 
    private static void makeRequestNow(String xml){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('SOAPAction','Retrieve');
        req.setHeader('Accept-Encoding','gzip,deflate');
        req.setHeader('Content-Type','text/xml;charset=UTF-8');
        req.setHeader('User-Agent','Jakarta Commons-HttpClient/3.1');
        req.setBody(xml);
 
        req.setEndpoint('https://webservice.exacttarget.com/Service.asmx');
 
        string bodyRes = '';
 
        try {
            HttpResponse res = h.send(req);
            bodyRes = res.getBody();
            } 
            catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            }
        System.debug('Soap request:' + xml);
        System.debug('Soap response:' + bodyRes);
 
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,bodyRes));
       }
  }