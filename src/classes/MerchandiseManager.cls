@RestResource(urlMapping='/Merchandise/*')
global with sharing class MerchandiseManager {
  
    @HttpGet
    global static List<Merchandise__c> doGet() {
        RestRequest req = RestContext.request;
        //set if merchid is part of uri      
        String username = req.requestURI.substring(
                                  req.requestURI.lastIndexOf('/')+1);
        if(username!='Merchandise'){
        List<Merchandise__c> result = 
                       [SELECT Name,Description__c,Price__c,Total_Inventory__c
                        FROM Merchandise__c 
                        WHERE ID = :username];
        return result;}
        else{
        List<Merchandise__c> result=[SELECT Name,ID,Price__c FROM Merchandise__c];
        return result;}
    }
    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String merchId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Merchandise__c result = [SELECT Id from Merchandise__c where Id = :merchId];
        Delete result;
    }
  
    @HttpPost
    global static String createMerchandise(String name,
        String description, Decimal price, Double inventory) {
        Merchandise__c m = new Merchandise__c(
            Name=name,
            Description__c=description,
            Price__c=price,
            Total_Inventory__c=inventory);
        insert m;
        return m.Id;
    }
}