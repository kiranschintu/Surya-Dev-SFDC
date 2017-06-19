@RestResource (urlMapping='/showAccounts/*')
global with sharing class SuryaRestController{

     
    @HttpGet
    global static List<Account> getAccounts() {
        List<Account> lst;
        RestRequest req = RestContext.request;
        //RestResponse res = RestContext.response;
        //String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        lst = [SELECT Id, Name, Phone, Website FROM Account limit 100];
        return lst;
    }
  
}