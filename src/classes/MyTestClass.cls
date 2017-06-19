@isTest(seeAllData=true)
private class MyTestClass{
    private static void doAcc(){
        Test.startTest();
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        Test.stopTest();
    }
    private static void doOpp(){
        Test.startTest();
        //doAcc();
        Opportunity opp = new Opportunity();
        opp.name = 'HelloTest';
        opp.closedate=system.today();
        insert opp;
        Test.stopTest();
    }
    private static testmethod void dotest(){
        //Test.startTest();
        doAcc();
        doOpp();
         //Test.stopTest();
    }
}