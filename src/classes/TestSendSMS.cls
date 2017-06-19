@isTest
private class TestSendSMS{
   
    private static testMethod void testUnas1(){
        
        Account con = new Account();
        con.Name = 'test';
        con.Phone ='12345';
        insert con;
                     
        ApexPages.StandardController controller = new ApexPages.StandardController(con);
        SendSMSHttpContact test1 = new SendSMSHttpContact(controller);
        test1.msgtxt = 'hello kiran' ;
        test1.SendSMS();
        
        
      }
      private static testMethod void testUnas2(){
        
        Account con = new Account();
        con.Name = 'test';
        insert con;
                     
        ApexPages.StandardController controller = new ApexPages.StandardController(con);
        SendSMSHttpContact test1 = new SendSMSHttpContact(controller);
        test1.msgtxt = 'hello kiran' ;
        test1.SendSMS();
        system.assert(con.phone==null);
        
      }  
      
       
    }