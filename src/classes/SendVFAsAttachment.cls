/**
*   Created By  :   Surya
*   Description :   This class exposes @future method to send VF page rendered as PDF as attachment in Email
*/
global class SendVFAsAttachment implements Schedulable{
    global String sessId;
    global SendVFAsAttachment(String sesId){
        sessId = sesId;
        system.debug('Session Id>>>'+sesId);
    }
    
    global void execute(SchedulableContext sc){
        system.debug('Session Id>>>'+sessId);
        sendVF(sessId );
    }
    
    @future(callout=true)
    public static void sendVF(String Sessionid)
    {
        System.debug('SesionId>>>'+Sessionid);
        //Replace below URL with your Salesforce instance host
        String addr = 'https://ap1.salesforce.com/services/apexrest/dhr/sendPDFEmail';
        HttpRequest req = new HttpRequest();
        req.setEndpoint( addr );
        req.setMethod('GET');
        req.setHeader('Authorization', 'OAuth ' + Sessionid);
        req.setHeader('Content-Type','application/json');
        //req.setBody(reqBody);
        Http http = new Http();
        HttpResponse response = http.send(req);
        System.debug('Status Code>>>'+response.getStatusCode()+'Message'+response.getStatus());
        System.debug('Session Id'+Sessionid);
    }
}