public with sharing class ContactAndLeadSearch{
    public static List<List<SObject>> searchContactsAndLeads(string name){
        List<List<SObject>> searchList = [FIND :name IN NAME FIELDS 
                                      RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)];
        
        return searchList;
    }
}