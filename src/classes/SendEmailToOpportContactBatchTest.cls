@isTest
private class SendEmailToOpportContactBatchTest{
    private static testMethod void unitTest(){
        //Insert Account
        Account acc = new Account(Name='Test');
        insert acc;
        
        //Insert Contact
        Contact con = new Contact(lastName='test',Email='test@gmail.com');
        insert con;
        
        //Insert Opportunity
        Opportunity opp = new Opportunity(name='Test',AccountId=acc.id,StageName='Prospecting',CloseDate=system.today()+5,Constituent__c=con.id);
        insert opp;
        
        SendEmailToOpportContactBatch stocb = new SendEmailToOpportContactBatch();
        Database.executeBatch(stocb);
        
        system.schedule('Test_Job','0 0 13 * * ?',stocb);
        
    }
}