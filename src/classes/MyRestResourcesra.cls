@RestResource(urlMapping='/displayaccoutns/*')
global with sharing class MyRestResourcesra {

    @HttpGet
    global static List<Account> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        List<Account> result = [SELECT Id, Name, Phone, Website FROM Account where phone!=null limit 10];
        return result;
        /*RestContext.response.addHeader('ContentType','appliction/xml');
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        String s='<Address type="Billing"><Street>{!eachAccount.billingStreet}</Street><City>{!eachAccount.billingCity}</City><State>{!eachAccount.billingState}</State><PostalCode>{!eachAccount.billingPostalCode}</PostalCode><Country>{!eachAccount.billingCountry}</Country></Address>   ';
        return s;*/
    }
}