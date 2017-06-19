global with sharing class RemoteAction2s {
    public static Account account;// { get; set; }
     
    @RemoteAction
    global static Account doSome(String accountName) {
        account = [select id, name, phone, type, numberofemployees from 
             Account where name = :accountName limit 1];
        return account;
    }   
}