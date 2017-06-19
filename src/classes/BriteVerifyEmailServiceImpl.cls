public class BriteVerifyEmailServiceImpl implements BriteVerifyService{
    
    public BriteVerifyServiceResponse getEmailVerificationStatus(String EmailAddress){
        BriteVerifyServiceResponse webResponse = new BriteVerifyServiceResponse();
        try{
            dhr__Briteverify__c obs = dhr__Briteverify__c.getInstance('BriteEndPoint');
            //String endPoint = 'https://bpi.briteverify.com/emails.json?address='+EmailAddress+'&apikey=077c2d6a-d993-42b6-9536-9abf5528845b';
            if(obs!=null && obs.url__c!=null && obs.apikey__c!=null){
                String endPoint = obs.url__c+'?address='+EmailAddress+'&apikey='+obs.apikey__c;
                Http htp = new Http();
                HttpRequest req = new HttpRequest();
                req.setEndpoint(endPoint);
                req.setMethod('GET');
                
                HttpResponse res = new HttpResponse();
                if(!Test.isRunningTest()){
                    res = htp.send(req);
                }else{
                    res.setStatusCode(200);
                    res.setBody('{"address": "johndoe@briteverify.com","account": "johndoe","domain": "briteverify.com","status": "valid","disposable": false,"role_address": false,"duration": 0.104516605}');
                }
                system.debug('Web service Result:'+res.getStatus());
                if(res.getStatusCode()==200 && res.getBody()!=null){
                    webResponse =  (BriteVerifyServiceResponse)JSON.deserializeStrict(res.getBody(), BriteVerifyServiceResponse.class);
                    system.debug('Final Response is:'+webResponse);
                }
            }
        }catch(Exception e){
            system.debug('Error Occured');
        }
        return webResponse;
    }
}