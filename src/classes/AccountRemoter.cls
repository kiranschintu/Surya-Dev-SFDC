global with sharing class AccountRemoter {

    public String accountName { get; set; }
    public static Account account { get; set; }
    public AccountRemoter() { } // empty constructor
    
    @RemoteAction
    global static Account getAccount(String accountName) {
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account WHERE Name = :accountName];
        Account a = new Account(name='hello');
        //insert a;
        Http hp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://cmgdevvert-mrsgim.cs10.force.com/services/apexrest/mrsgimtrends?id=a0BJ0000007JsDx');
        req.setMethod('GET');
        HttpResponse res = new HttpResponse();
        res = hp.send(req);
        
        return account;
    }
}