public with sharing class TestExtension2 {

    public TestExtension2(ApexPages.StandardController controller) {

    }
    public List<Contact> getConRecords(){
    List<Contact> con = [SELECT id,name from Contact limit 5];
    return con;
    }

}