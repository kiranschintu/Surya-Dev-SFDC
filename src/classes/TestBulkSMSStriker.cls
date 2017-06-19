@isTest
private class TestBulkSMSStriker{
    
    private static testMethod void testUnas1(){
               
        List<Contact> con = new List<Contact>();
        con.add(new Contact(lastname='xxx',MobilePhone='12345'));
        con.add(new Contact(lastname='xxx1',MobilePhone=''));
        insert con;
                                          
       ApexPages.StandardSetController controller = new ApexPages.StandardSetController(con);
       SendBulkSMSHTTPContactStriker test1 = new SendBulkSMSHTTPContactStriker(controller);
       test1.msgtxt='hello world';
       test1.SendSMS();
       test1.getSomething();
       system.assert(con[0].mobilephone != null);
       }
    private static testMethod void testUnas2(){ 
        List<Contact> con = new List<Contact>();
        con.add(new Contact(lastname='xxx',MobilePhone=null));
        insert con;
                                          
       ApexPages.StandardSetController controller = new ApexPages.StandardSetController(con);
       SendBulkSMSHTTPContactStriker test1 = new SendBulkSMSHTTPContactStriker(controller);
       test1.msgtxt='hello world';
       test1.SendSMS();
       test1.getSomething();
       system.assert(con[0].mobilephone == null);

     }
    }