Public class SendSMSRouteSMSService{
    public void sendSMS(){
        string to='9966817112';
        string text='this is sample sms';
        string username='janauser';
        string password='jan66usr';
        string sender='TSTSMS';
        string MType='TXT';
        
        Xmlstreamwriter xmlW = new Xmlstreamwriter();
        xmlW.writeStartDocument('UTF-8','1.0');
        xmlW.writeStartElement(null,'message-submit-request',null);
    
        if(username != null){
        xmlW.writeStartElement(null,'username',null);
        xmlW.writeCharacters(username);
        xmlW.writeEndElement();
        }           
        if(password!=null){
        xmlW.writeStartElement(null,'password',null);
        xmlW.writeCharacters(password);
        xmlW.writeEndElement();
        } 
        if(sender!=null){
        xmlW.writeStartElement(null,'sender-id',null);
        xmlW.writeCharacters(sender);
        xmlW.writeEndElement();
        } 
        if(MType!=null){
        xmlW.writeStartElement(null,'MType',null);
        xmlW.writeCharacters(MType);
        xmlW.writeEndElement();
        } 
        xmlW.writeStartElement(null,'message-text',null);
        if(text != null){
        xmlW.writeStartElement(null,'text',null);
        xmlW.writeCharacters(text);
        xmlW.writeEndElement();
        }           
        if(to!=null){
        xmlW.writeStartElement(null,'to',null);
        xmlW.writeCharacters(to);
        xmlW.writeEndElement();
        } 
        xmlW.writeEndElement();
        xmlW.writeEndElement(); //end SFDCRequest                 
    
        xmlW.writeEndDocument();
        String XMLString  =  xmlW.getXMLString();   
        system.debug('----------'+xmlstring);
        xmlW.close();
        
        HttpRequest oRequest = new HttpRequest();
        
        String vdata = EncodingUtil.urlEncode(XMLString, 'UTF-8');
        oRequest.setEndpoint('http://sms6.routesms.com:8080/bulksms/bulkxmlapi?data='+vdata);
        oRequest.setMethod('GET');  
        oRequest.settimeout(120000);
        system.debug('*******oRequest*********'+oRequest);
    
        Http oHttp = new Http();
        oRequest.setMethod('GET');    
        HttpResponse oResponse = new HttpResponse();
        oResponse = oHttp.send(oRequest);
        System.debug('************XML Response*****************'+oResponse);
        System.debug('************XML Response body *****************'+oResponse.getBody());
    }
}