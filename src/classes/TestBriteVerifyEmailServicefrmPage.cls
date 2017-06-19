@isTest
private class TestBriteVerifyEmailServicefrmPage{
    private static testmethod void unitTest(){
        Contact con = new Contact();
        con.lastname = 'test';
        con.Email = 'test@gmail.com';
        insert con;
        
        BriteVerifyEmailServicefrmPage.doCallout(con.id,con.email,'Contact');
        
    }
}