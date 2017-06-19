@isTest
private class TestBriteVerifyBatchHandler{
    private static testmethod void unitTest(){
        Contact con = new Contact();
        con.lastName='Test';
        con.Email='test@gmail.com';
        insert con;
        
        BriteVerifyBatchHandler ob = new BriteVerifyBatchHandler('Contact');
        Database.executeBatch(ob,80);
    }
}