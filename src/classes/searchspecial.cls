public with sharing class searchspecial {
    public string searchtext{get;set;}
    public List<Account> accounts{get;set;}
    public List<Contact> contacts{get;set;}
    public List<Lead> leads{get;set;}
    public PageReference dosearch(){
        if(searchtext.length()>1){
        List<List<sObject>> results = [FIND :searchtext IN ALL FIELDS returning Account(Name,phone),Contact(Name,phone),Lead(Name)];
        accounts=results[0];
        contacts=results[1];
        leads=results[2];
        }
        return null;
    }
}