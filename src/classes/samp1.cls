public class samp1{
public String FirstName{get;set;}
    public void CreateContact(){
        string elementValue = 'Not Found';
        Http h = new http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.mVaayoo.com/mvaayooapi/MessageCompose?user=kiranch726@yahoo.com:8125931509dh&senderID=TEST SMS&receipientno=8125931509&dcs=0&msgtxt='+FirstName+'&state=0&');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml;charset=utf-8'); 
        req.setHeader('SOAPAction', 'http://soap.sforce.com/schemas/class/helloWorld');
        //string b ='<?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:hel="http://soap.sforce.com/schemas/class/helloWorld"><soapenv:Header><hel:DebuggingInfo><hel:debugLog>?</hel:debugLog></hel:DebuggingInfo></soapenv:Header><soapenv:Body><hel:CreateTheContact><hel:firstname>'+firstname+'</hel:firstname><hel:lastname>'+lastname+'</hel:lastname></hel:CreateTheContact></soapenv:Body></soapenv:Envelope>';
        //req.setbody(b);
        HttpResponse res = h.send(req);
        system.debug('Body was:  '+ req);
        system.debug('Body was:  '+ res);
        system.debug('String was:' + res.getBody());
        
        
       }
    }