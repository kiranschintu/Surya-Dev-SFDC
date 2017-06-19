@isTest(seeAllData=true)
private class CalloutClassTest {
     @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new TestSendSMSHttpCalloutMock());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class tat implements HttpCalloutMock. 
        /*Account con = new Account();
        con.Name = 'test';
        con.Phone ='12345';
        insert con;*/
        Account con = [select name,phone from Account where phone!=null limit 1];
                     
        ApexPages.StandardController controller = new ApexPages.StandardController(con);
        SendSMSHttpContact test1 = new SendSMSHttpContact(controller);
        test1.msgtxt = 'hello kiran' ;
        test1.SendSMS();
    }
}