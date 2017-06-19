public with sharing class vinaywebservice {

    public void DoCalloutForSession(){
        
        VinaypartnerSoapSforceCom.SOAP service = new VinaypartnerSoapSforceCom.SOAP();
        VinaypartnerSoapSforceCom.LoginResult lr = service.login('innovat123@yahoo.com','sfdc@963');
        
        VinayMycustomsoap.MyCustomSOAP mcs = new VinayMycustomsoap.MyCustomSOAP();
        VinayMycustomsoap.SessionHeader_element shr= new VinayMycustomsoap.SessionHeader_element();
        shr.sessionId=lr.sessionid;
        mcs.SessionHeader=shr;
        
        List<String> result = mcs.displayFruit();
        system.debug('Final Result');
        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.info,'Response'+result);
        ApexPages.addMessage(msg);
        } 
}