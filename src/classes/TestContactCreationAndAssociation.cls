@isTest()
private class TestContactCreationAndAssociation{
    private static testMethod void unitTest(){
        Constituent_Group__c cg = new Constituent_Group__c(name='Test');
        insert cg;
        Test.setCreatedDate(cg.id,system.today()-3);
        system.debug('cgDate???'+cg.createdDate);
        
        Contact con = new Contact(lastname='test',email = 'test@gmail.com');
        
        //
        
        ApexPages.StandardController controller = new ApexPages.StandardController(cg);
        ContactCreationAndAssociation ccAA = new ContactCreationAndAssociation(controller);
        //setting contact for testMethod
        ccAA.con = con;
        
        ccAA.cancel();
        ccAA.SaveData();
        ccAA.SaveDataWithNoDup();
        ccAA.SaveData();//to cover else condition code
    }
}