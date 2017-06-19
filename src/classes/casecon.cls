public class casecon {

    private final Case cas;
    //this is the constructor
    public casecon() {
        cas = [SELECT Id,origin,contact.name,contact.phone FROM Case 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
    //this is the get method to hold the record values
    public Case getrecord() {
        return cas;
    }
}