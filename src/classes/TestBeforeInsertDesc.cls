@isTest
private class TestBeforeInsertDesc{
    static testMethod void unitTest(){
    // Perform our data preparation.
    List<Account> accounts = new List<Account>{};
        
    for(Integer i = 0; i < 200; i++){
        Account a = new Account(Name = 'Test Account ' + i);
        accounts.add(a);
    }

    // Start the test, this changes governor limit context to 
    // that of trigger rather than test. 
    //test.startTest();
        
    // Insert the Account records that cause the trigger to execute.
    insert accounts; 
        
    // Stop the test, this changes limit context back to test from trigger.
    //test.stopTest();
    }
}