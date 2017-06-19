@isTest
private class P3TestP3_Custom_URL{
    private static testmethod void P3_Custom_URLTst(){
        
        P3_Custom_URL__c pcurl = new P3_Custom_URL__c();
        pcurl.name= 'Test';
        pcurl.P3_Custom_URL_Value__c = 'sample';
        insert pcurl;
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/P3_Custom_URL';  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        P3_Custom_URL.URLContext ami = new P3_Custom_URL.URLContext();
        ami.keyId = 'Test';
        ami.Value = '123456T';
        
        P3_Custom_URL.CustomUrl();
    }
    private static testmethod void P3_Custom_URLTst1(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://ap1.salesforce.com/services/apexrest/AccessMatter';  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        P3_Custom_URL.URLContext ami = new P3_Custom_URL.URLContext();
        ami.keyId = 'Test';
        ami.Value = '123456T';
        
        P3_Custom_URL.CustomUrl();
        
    }
}