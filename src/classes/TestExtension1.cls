public with sharing class TestExtension1 {

    public TestExtension1(ApexPages.StandardController controller) {

    }
    
    public List<Contact> getConRecords(){
    List<Contact> con = [SELECT id,name from Contact Limit 10];
    return con;
    }

}