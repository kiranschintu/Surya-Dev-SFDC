@isTest
private class TestCa_Mark_Order_Shipped_Extension{
    private static testmethod void mymethod(){
        Account a = new Account();
        a.name = 'Hello';
        insert a;
        List<Account> aa = new List<Account>();
        aa.add(a);
        ApexPages.StandardSetController std = new ApexPages.StandardSetController(aa);
        Ca_Mark_Order_Shipped_Extension ob = new Ca_Mark_Order_Shipped_Extension(std);
    }
}