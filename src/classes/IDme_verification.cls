public class IDme_verification{
    private String apiURL = 'https://api.id.me/v2/verify';
    private String verificationResponse;
    private String authProviderID;
    
    public class verificationRequest{

        String first_name;
        String last_name;
        String ssn;
        String birth_date;
        String service_date;
        String client_id;
        String client_secret;

        public verificationRequest(String userID){
          // look up necessary attributes from User object
        }

        public verificationRequest(String fName, String lName, String socialSN, String birthDate, String serviceDate){
            // gets everything passed to it.
            first_name = fName;
            last_name = lname;
            ssn = socialSN;
            birth_date = birthDate;
            service_date = serviceDate;
        }
    }
    
    public String verify(verificationRequest vReq, String authProviderName){
        setupIdSecret(vReq, authProviderName);

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setTimeout(10000);
        req.setMethod('POST');
        
        
        apiURL += '?client_id=' + vreq.client_id + '&client_secret=' + vreq.client_secret;
        apiURL += '&first_name=' + vreq.first_name + '&last_name=' + vreq.last_name;
        apiURL += '&birth_date=' + vreq.birth_date + '&service_date=' + vreq.service_date;
        apiURL += '&ssn=' + vreq.ssn;
        system.debug('apiURL: ' + apiurl);
        req.setEndpoint(apiURL);
                
        String jsonVReq = JSON.serialize(vReq);
        system.debug('jsonVRew: ' + jsonVReq);
        req.setBody(jsonVReq);
        
        HttpResponse res = new HttpResponse();
        if(!Test.isRunningTest()){
            res = h.send(req);
        }
        else{
            res.setStatusCode(200);
        }
        verificationResponse = res.getBody();
        system.debug('response: ' + res.getBody());
        system.debug('res status: ' + res.getStatus());        
        system.debug('res status code: ' + res.getStatusCode());
        
        String returnString;
        if (res.getStatusCode() == 404) {
            // identity not verified
            returnString = 'false';
        } else if (res.getStatusCode() == 200){
            // identity verified
            returnString = 'true';            
        } else {
            returnString = 'other';
        }
        system.debug('returnString>>>'+returnString);
        return returnString;
    }
    
    public void setupIdSecret(verificationRequest vr, String authProviderName){
        List<AuthProvider> prov = [select consumersecret, consumerkey from AuthProvider where friendlyname=:authProviderName];
        if(!prov.isEmpty()){
            vr.client_ID = prov[0].consumerkey;
            vr.client_Secret = prov[0].consumersecret;
        }
    }    
}