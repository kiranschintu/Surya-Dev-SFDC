@isTest
private class TestStreetVerficationCon{
    private static testmethod void mymethod(){
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        ApexPages.StandardController pg = new ApexPages.StandardController(acc);
        StreetVerficationCon sv = new StreetVerficationCon(pg);
        ApexPages.CurrentPage().getparameters().put('id', acc.id);
        sv.incrementCounter();
        StreetVerficationCon.updateAccount(acc.id,acc.name);
        
        
    }
}