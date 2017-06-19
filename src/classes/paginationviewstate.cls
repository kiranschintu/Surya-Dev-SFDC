public with sharing class paginationviewstate {

    public List<Contact> contactss{get;set;}
    public paginationviewstate(ApexPages.StandardSetController controller) {
contactss=[select name,description from contact]; 
    }
    
    

}