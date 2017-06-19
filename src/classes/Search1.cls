public with sharing class Search1 {
    
    public string searchtext{get;set;}
    public List<Account> accounts{get;set;}
    public List<Contact> contacts{get;set;}
    public List<Lead> leads{get;set;}
    public String MyDate{get;set;}
    public PageReference dosearch(){
        List<List<sObject>> results = [FIND :searchtext IN ALL FIELDS returning Account(Name,phone),Contact(Name,phone),Lead(Name)];
         //MyDate=MyDate;
        //Date d = Date.parse(MyDate);
        //List<Account> accs = [Select id,name from Account where dhr__SLAExpirationDate__c=:d];
        accounts=results[0];
        contacts=results[1];
        leads=results[2];
       
        return null;
    }
}