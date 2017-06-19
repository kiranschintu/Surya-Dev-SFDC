public class GETPDFContentCls{
    
    @future(callout=true)
    public static void doCallout(){
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://ap1.salesorce.com/services/apexrest/sendPDFEmail');
        req.setHeader('Authorization','OAuth '+Userinfo.getSessionId());
        req.setMethod('GET');
        HttpResponse res = new HttpResponse();
        res = htp.send(req);
        system.debug('Response is :'+res);
        system.debug('Response is :'+res.getStatusCode());
    }
}