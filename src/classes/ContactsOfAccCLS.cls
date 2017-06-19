public with sharing class ContactsOfAccCLS {
    public List<Contact> cons{get;set;}
    public ContactsOfAccCLS(){
        String accId = ApexPages.currentPage().getParameters().get('aid');
        if(accId!=null){
            cons = [select id,name,phone,email from Contact where AccountId=:accId order by name];
        }
    }
}