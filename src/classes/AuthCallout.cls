public class AuthCallout {
     
   public String accesstoken;
   public String getOAuthSessioId(){
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
    
    public List<String> getAccountRecords(){
    getOAuthSessioId();
         HttpRequest reqq = new HttpRequest();
      //req.setEndpoint('https://login.salesforce.com/services/oauth2/authorize?response_type=token&client_id=3MVG9Y6d_Btp4xp4Ai8NsH8xXzYfxQGDvfg8kdiVxmOYcuKMKn0NsPmLcgt_KV93lXMZOipY9phe.NRMpkmau&redirect_uri=https://dhr.ap1.visual.force.com/apex/basiccallout1');
     reqq.setEndpoint('https://ap1.salesforce.com/services/apexrest/chsk/FieldCase');
     //req.setEndpoint('http://www.gmail.com');
     reqq.setMethod('GET');
     
     reqq.setHeader('Authorization','OAuth '+accesstoken);
     
     Http httpp = new Http();
     HTTPResponse ress = httpp.send(reqq);
     
     
     JSONParser parser1 = JSON.createParser(ress.getBody());
        //List<List<String>> AccountNames = new List<List<String>>();
        List<String> AccountName = new List<String>();
        while (parser1.nextToken() != null) {
        
            if ((parser1.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser1.getText() == 'Name')) {
                // Get the value.
                parser1.nextToken();
                String AccountName1 =parser1.getText();
                AccountName.add(accountName1);
                //AccountNames.add(AccountName);
            }
            
        }    
        
    return AccountName;
    }
}