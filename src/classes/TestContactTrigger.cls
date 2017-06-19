@isTest
private class TestContactTrigger{
    private static testmethod void unitTest(){
        Contact con = new Contact();
        con.lastname = 'test';
        con.Email = 'test@gmail.com';
        insert con;
        
        con.Email = 'test1@gmail.com';
        update con;
    }
}