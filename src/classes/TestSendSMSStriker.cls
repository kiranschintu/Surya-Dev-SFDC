@isTest
private class TestSendSMSStriker{
   
    private static testMethod void testUnas1(){
        
        Contact con = new Contact();
        con.LastName = 'test';
        con.MobilePhone ='12345';
        insert con;
                     
        ApexPages.StandardController controller = new ApexPages.StandardController(con);
        SendSMSHttpContactStriker test1 = new SendSMSHttpContactStriker(controller);
        test1.msgtxt = 'hello kiran' ;
        test1.SendSMS();
        
      } 
       
    }