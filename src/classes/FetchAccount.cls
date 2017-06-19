public with sharing class FetchAccount {

    public String getUserName() {
        return null;
    }


    //Login Domain May be test, prerellogin.pre
    final String LOGIN_DOMAIN = 'www'; //other options: test, prerellogin.pre
final String USERNAME = 'kiranch.sfdc@yahoo.com';
final String PASSWORD = '8125931509dhrf5WYvWFhpvVTI7OL8ZMI4II4v';
    
   public List<Account> accounts{get;set;}
    public String errMsg{get;set;}
    public String displayError{get;set;}
    public void fetch()
    {
        errMsg  = 'Some error occurred, please try again';
        try
        {
        //-----------------------------------
        // Login via SOAP/XML web service api
        //-----------------------------------
        HttpRequest request = new HttpRequest();
request.setEndpoint('https://' + LOGIN_DOMAIN + '.salesforce.com/services/Soap/u/22.0');
request.setMethod('POST');
request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
request.setHeader('SOAPAction', '""');
//not escaping username and password because we're setting those variables above
//in other words, this line "trusts" the lines above
//if username and password were sourced elsewhere, they'd need to be escaped below
request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + USERNAME + '</username><password>' + PASSWORD + '</password></login></Body></Envelope>');
Dom.XmlNode resultElmt = (new Http()).send(request).getBodyDocument().getRootElement()
.getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/')
.getChildElement('loginResponse','urn:partner.soap.sforce.com')
.getChildElement('result','urn:partner.soap.sforce.com');
 
//----------------------------------------------------------------------
// Grab session id and server url (ie the session)
//----------------------------------------------------------------------
final String SERVER_URL = resultElmt.getChildElement('serverUrl','urn:partner.soap.sforce.com').getText().split('/services')[0];
final String SESSION_ID = resultElmt.getChildElement('sessionId','urn:partner.soap.sforce.com').getText();
 
//----------------------------------------------------------------------
// Load first 10 accounts via REST API
//----------------------------------------------------------------------
final PageReference theUrl = new PageReference(SERVER_URL + '/services/data/v22.0/query/');
theUrl.getParameters().put('q','select id,name from Account limit 10');
request = new HttpRequest();
request.setEndpoint(theUrl.getUrl());
request.setMethod('GET');
request.setHeader('Authorization', 'OAuth ' + SESSION_ID);
 
String body = (new Http()).send(request).getBody();
System.debug('Accounts in JSON format: ' + body);
 
//----------------------------------------------------------------------
// Uncomment following if you're running on Winter '12 or later;
// JSONParser is new in Winter '12.
//----------------------------------------------------------------------

JSONParser parser = JSON.createParser(body);
do{
parser.nextToken();
}while(parser.hasCurrentToken() && !'records'.equals(parser.getCurrentName()));
parser.nextToken();
//the following line is wicked cool
final List<Account> accounts = (List<Account>) parser.readValueAs(List<Account>.class);
System.debug('Accounts as native list: ' + accounts);
 
       }
        catch(Exception e)
        {
            displayError = 'block';
        }

    }
}