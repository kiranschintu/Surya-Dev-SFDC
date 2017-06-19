public class JWTToken1{
public void call(){
       
        http h = new Http();
        Httprequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setMethod('POST');
       
        req.setHeader('ContentType','application/x-www-form-urlencoded');
       
        String Header = '{"alg":"RS256","typ":"JWT"}';
        String Header_Encode = EncodingUtil.base64Encode(blob.valueof(Header));
       
        String claim_set = '{"iss":"service accounts Email"';
        claim_set += ',"scope":"https://www.googleapis.com/auth/analytics.readonly"';
        claim_set += ',"aud":"https://accounts.google.com/o/oauth2/token"';
        claim_set += ',"exp":"'+datetime.now().addHours(1).getTime()/1000;
        claim_set += '","iat":"'+datetime.now().getTime()/1000+'"}';
       
       
       
        String claim_set_Encode = EncodingUtil.base64Encode(blob.valueof(claim_set));
       
        String Singature_Encode = Header_Encode+'.'+claim_set_Encode;
       
        String key = 'PKCS8 format private key string';
               
        blob privateKey = EncodingUtil.base64Decode(key);
        Singature_Encode = Singature_Encode.replaceAll('=','');
        String Singature_Encode_Url = EncodingUtil.urlEncode(Singature_Encode,'UTF-8');
        blob Signature_b =   blob.valueof(Singature_Encode_Url);
        system.debug('privateKey>>>'+String.valueOf(privateKey));
        String Sinatute_blob = base64(Crypto.sign('RSA-SHA256', Signature_b , privateKey));
              
        String JWT = Singature_Encode+'.'+Sinatute_blob;
       
        JWT = JWT.replaceAll('=','');
       
             
        String grt = 'urn:ietf:params:oauth:grant-type:jwt-bearer';
        req.setBody('grant_type='+grt+'&assertion='+JWT);
        res = h.send(req);
        String Response = res.getBody() +' '+ res.getStatusCode();
        system.debug('Response ='+Response );
    }
     private String base64(Blob b) {
        String ret = EncodingUtil.base64Encode(b);
        ret = ret.replaceAll('\\+', '-');
        ret = ret.replaceAll('/', '_');
        ret = ret.replaceAll('=', '');
        return ret;
    }
}