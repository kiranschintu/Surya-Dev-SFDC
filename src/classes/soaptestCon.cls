public with sharing class soaptestCon {
    public string response{get;set;}
    public void dosome(){
        VinayPartnerSoapSforceCom.Soap sp = new VinayPartnerSoapSforceCom.Soap();
        VinayPartnerSoapSforceCom.LoginResult lr = sp.login('kirans.chintu@gmail.com','surya996383');
        
        
        VinayMycustomsoap.SessionHeader_element sh = new VinayMycustomsoap.SessionHeader_element();
        sh.sessionId = lr.sessionId;
        
        VinayMycustomsoap.MyCustomSOAP res = new  VinayMycustomsoap.MyCustomSOAP();
        res.SessionHeader=sh;
        
        response = res.displayacc();
    }

}