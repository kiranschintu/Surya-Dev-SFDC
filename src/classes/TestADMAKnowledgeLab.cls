@isTest
private class TestADMAKnowledgeLab{
    private static testMethod void testwebservice(){
        
        Account ac = new Account(name='web',domain__c='email@sample.com',Member_Status__c='Current',Member_Ship_Type__c='Member');
        insert ac;
        
        Account acc = new Account(name='web',domain__c='email@xxxx.com',Member_Status__c='Current',Member_Ship_Type__c='Member');
        insert acc;
        
        
        
        Contact con = new Contact();
        con.firstName = 'FN';
        con.lastName = 'LN';
        con.Accountid = ac.id;
        con.Email = 'Email@xxxx.com';
        con.Password__c = '123';
        con.TempForgotPwd__c = '1234';
        con.Time_Stamp__c = system.now();
        con.Exp_Actv_Time__c = system.today();
        con.accountid =acc.id;
        insert con;
        
       // ADMAKnowledgeLab ob = new ADMAKnowledgeLab();
        ADMAKnowledgeLab.contactinfo info = new ADMAKnowledgeLab.contactinfo();
        info.salutation='Mr.';
        info.FN='FN';
        info.LN='LN';
        info.Email='sample@sample.com';
        info.Pwd='1213ef';
        info.gender=True;
        info.url='http://www.google.com';
                
        ADMAKnowledgeLab.Registration(info);
        //ADMAKnowledgeLab.RegistrationCnfm(con.TempForgotPwd__c);
        //ADMAKnowledgeLab.Login('sample@sample.com','1213ef');
        //ADMAKnowledgeLab.forgotPassword(con.email);
        //ADMAKnowledgeLab.forgotPasswordCnfm('123450',con.Email,'conTempForgotPwd__c');
        //ADMAKnowledgeLab.SearchingAccount('searchText','searchText1','searchText2');
        //ADMAKnowledgeLab.ShowingAccount(ac.name);
    }
    
   /* private static testMethod void testwebservicenegetive(){
        
        Account ac = new Account(name='web',Company_Email__c='Email@sfsf.com',Member_Status__c='Current',Member_Ship_Type__c='Member');
        insert ac;
        
        Contact con = new Contact();
        con.firstName = 'FN';
        con.lastName = 'LN';
        con.Accountid = ac.id;
        con.Email = 'Email@xxxx.com';
        con.Password__c = '123';
        con.TempForgotPwd__c = '1234';
        con.Time_Stamp__c = system.now();
        con.Exp_Actv_Time__c = system.today();
        
        
        ADMAKnowledgeLab ob = new ADMAKnowledgeLab();
        ADMAKnowledgeLab.Registration(con.firstName,con.lastName,con.Email,con.Password__c);
        ADMAKnowledgeLab.RegistrationCnfm(con.TempForgotPwd__c,con.Email,'123546');
        ADMAKnowledgeLab.Login(con.Email,con.Password__c);
        ADMAKnowledgeLab.forgotPassword(con.email);
        ADMAKnowledgeLab.forgotPasswordCnfm(con.TempForgotPwd__c,con.Email);
        ADMAKnowledgeLab.SearchingAccount('searchText');
        ADMAKnowledgeLab.ShowingAccount(ac.name);
        
    }*/
}