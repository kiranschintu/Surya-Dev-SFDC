@RestResource(urlMapping='/FieldCase/*')
global with sharing class MyRestResource {

    @HttpDelete
    global static String doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String Id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Name = :Id];
        delete account;
        return 'Record Deleted';
    }
  
   @HttpGet
    global static String doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        RestContext.response.addHeader('ContentType','appliction/xml');
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Account> result = [SELECT Id, Name, Phone, Website FROM Account limit 100];
        String s='<Address type="Billing"><Street>{!eachAccount.billingStreet}</Street><City>{!eachAccount.billingCity}</City><State>{!eachAccount.billingState}</State><PostalCode>{!eachAccount.billingPostalCode}</PostalCode><Country>{!eachAccount.billingCountry}</Country></Address>   ';
        return s;
    }
    /*
    @HttpGet
    global static Account doGet1() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account limit 1];
        return result;
    }
*/
    
  
  @HttpPost
    global static String doPost(String name,
        String phone, String website) {
        //RestContext.request.addHeader('ContentType','appliction/json');
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }
}