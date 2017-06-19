/*
======================================================================
NOTES:
You'll need to create a remote site setting for the login url.  If you're org is on na1, then you'll need the following URL as a remote site setting:  https://www.salesforce.com
======================================================================
*/
public class VerifyPassword {

    public final String LOGIN_DOMAIN = 'www'; //other options: test, prerellogin.pre

    //public String username {get{ return UserInfo.getUsername(); }}
    public transient String username {get;set;}
    public transient String password {get;set;}

    public PageReference doVerify(){
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + LOGIN_DOMAIN + '.salesforce.com/services/Soap/u/22.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', '""');
        request.setBody(buildSoapLogin(username,password));

        //basically if there is a loginResponse element, then login succeeded; else there
        //  would be soap fault element after body
        final Boolean verified = (new Http()).send(request).getBodyDocument().getRootElement()
          .getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/')
          .getChildElement('loginResponse','urn:partner.soap.sforce.com') != null;

        if(verified) ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Correct password!'));
        else         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Incorrect password!'));

        return null;
    }

    public static String buildSoapLogin(String username, String password){
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartElement('', 'login', 'urn:partner.soap.sforce.com');
        w.writeNamespace('', 'urn:partner.soap.sforce.com');
        w.writeStartElement('', 'username', 'urn:partner.soap.sforce.com');
        w.writeCharacters(username);
        w.writeEndElement();
        w.writeStartElement('', 'password', 'urn:partner.soap.sforce.com');
        w.writeCharacters(password);
        w.writeEndElement();
        w.writeEndElement();
        
        String xmlOutput = 
              '<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Body>' 
            + w.getXmlString() 
            + '</Body></Envelope>';
        w.close();
        return xmlOutput;
    }
    
}