public with sharing class SidebarbirthdayCon {
    public List<Contact> con{get;set;}
    public String bremaind{get;set;}
    public SidebarbirthdayCon(){
        //bremaind = system.today().day()+'-'+system.today().month();
        con = [select id,name,Birthdate  from Contact where Birthdate=TODAY];
    }
}