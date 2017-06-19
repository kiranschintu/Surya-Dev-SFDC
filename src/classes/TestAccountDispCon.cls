@isTest
Private class TestAccountDispCon{
    private static testMethod void unitTest(){
        Account acc = new Account();
        acc.Name = 'Test';
        insert acc;
        
        ApexPages.currentPage().getParameters().put('id',acc.id);
        
        AccountDispCon ob = new AccountDispCon ();
        ob.sendEmail();
    }
}