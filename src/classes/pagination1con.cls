public with sharing class pagination1con {

    public List<Contact> contactss{get;set;}
    public pagination1con(ApexPages.StandardSetController controller) {
    contactss=[SELECT id,name,description from Contact];
    }
    
}