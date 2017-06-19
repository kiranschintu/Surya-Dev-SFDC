@isTest
private class testingtrantran2{
    private static testmethod void mytest(){
        Account a=new Account();
        a.name='Sample';
        insert a;
        ApexPages.StandardController sc = new ApexPages.StandardController(a);
        Tran2 t= new Tran2(sc);    
    }
}