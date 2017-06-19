@isTest
private class idmeVerificationControllerTest{
    private static testmethod void unitTest1(){
        Contact con = new Contact();
        con.lastName = 'Test';
        con.firstName = 'User';
        insert con;
        ApexPages.standardController sc = new ApexPages.StandardController(con);
        idmeVerificationController idm = new idmeVerificationController(sc);
        idm.getFinishPage();
    }
}