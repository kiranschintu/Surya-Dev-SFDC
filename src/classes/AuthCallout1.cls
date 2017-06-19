public class AuthCallout1 {
    public static String accesstoken;
   public static String getOAuthSessioId(){
     HttpRequest req = new HttpRequest();
      //req.setEndpoint('https://login.salesforce.com/services/oauth2/authorize?response_type=token&client_id=3MVG9Y6d_Btp4xp4Ai8NsH8xXzYfxQGDvfg8kdiVxmOYcuKMKn0NsPmLcgt_KV93lXMZOipY9phe.NRMpkmau&redirect_uri=https://dhr.ap1.visual.force.com/apex/basiccallout1');
     req.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9Y6d_Btp4xp4U_u6LeXMvDSJkux7ikij3oxTYpZZdkpwAFzXBjVdkaPw0pW0AVt4WVvEvpXfZ1U2M.CgB&client_secret=2067988350484466102&username=kiranch.sfdc@yahoo.com&password=Surya99495');//kczgLi5URtSYoETkULcxVvC8
     //req.setEndpoint('http://www.gmail.com');
     req.setMethod('POST');
    
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
     //return res.getBody();
     
     JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'access_token')) {
                // Get the value.
                parser.nextToken();
                accesstoken =parser.getText();
            }
            
        }
  
    return res.getbody(); 
    }
    
    //@Future(callout=true)
    public static String getInsertAccountRecord(){
    getOAuthSessioId();
     
     HttpRequest reqq = new HttpRequest();
      //req.setEndpoint('https://login.salesforce.com/services/oauth2/authorize?response_type=token&client_id=3MVG9Y6d_Btp4xp4Ai8NsH8xXzYfxQGDvfg8kdiVxmOYcuKMKn0NsPmLcgt_KV93lXMZOipY9phe.NRMpkmau&redirect_uri=https://dhr.ap1.visual.force.com/apex/basiccallout1');
     reqq.setEndpoint('https://ap1.salesforce.com/services/apexrest/chsk/FieldCase');
     //req.setEndpoint('http://www.gmail.com');
     reqq.setMethod('POST');
     
     String strbody = '{  "Name" : "Test Company"}';
     String strbody1 =JSON.Serialize(strbody);

     reqq.setHeader('Content-Type', 'application/json');
     reqq.setHeader('Authorization','OAuth '+accesstoken);
     reqq.setBody(strbody1);
     
     Http httpp = new Http();
     HTTPResponse ress = httpp.send(reqq);
     
               return ress.getBody();
    }

}