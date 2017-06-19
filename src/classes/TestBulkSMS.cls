@isTest
private class TestBulkSMS{
    
    private static testMethod void testUnas1(){
               
        List<Contact> con = new List<Contact>();
        con.add(new Contact(lastname='xxx',MobilePhone='12345'));
        con.add(new Contact(lastname='xxx1',MobilePhone=''));
        insert con;
                                          
       ApexPages.StandardSetController controller = new ApexPages.StandardSetController(con);
       SendBulkSMSHTTPContact test1 = new SendBulkSMSHTTPContact(controller);
       test1.msgtxt='hello world';
       test1.SendSMS();
       test1.getSomething();
       
       //verify results
       
       system.assert(con[0].mobilephone != null);
       }
}