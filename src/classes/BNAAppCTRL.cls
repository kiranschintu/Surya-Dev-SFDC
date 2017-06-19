public with sharing class BNAAppCTRL {
    @RemoteAction
    public static List<Account> fetchAccounts(String searchKey){
        searchKey = searchKey+'%';
        List<Account> accounts = [select id,name from Account where name like :searchKey ];
        //String accountsData = JSON.serialize(accounts);
        return accounts;
    }
    
    @RemoteAction
    public static List<Contact> fetchContacts(String parentId){
        List<Contact> contacts = [select id,LastName,Email from Contact where AccountId=:parentId];
        return contacts;
    }
}