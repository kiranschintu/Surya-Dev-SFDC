@isTest
private class TestBatchApexTran{
    private static testmethod void mymethod1(){
        
        //Account a = new Account(name='Surya');
        //insert a;
        BatchApexTran obj=new BatchApexTran();
        Database.executebatch(obj);
        
    }
}