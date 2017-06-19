@isTest
private class TestBatchNotifications{
    private static testMethod void unitTest(){
        Test.startTest();
        database.batchableContext bc;
        Map<String,String> failedRecordIds = new Map<String,String>();
        failedRecordIds.put('123456789012345','DML expection');
        
        List<Batchnotificationemails__c> batchEmlsLst = new List<Batchnotificationemails__c>();
        
        Batchnotificationemails__c batchEmls = new Batchnotificationemails__c();
        batchEmls.name='PSS';
        batchEmls.Email__c='test@gmail.com';
        batchEmls.Is_PSS__c=true;
        
        Batchnotificationemails__c batchEmls1 = new Batchnotificationemails__c();
        batchEmls1.name='Sales';
        batchEmls1.Email__c='test@gmail.com';
        batchEmls1.Is_Sales__c=true;
        
        Batchnotificationemails__c batchEmls2 = new Batchnotificationemails__c();
        batchEmls2.name='UW';
        batchEmls2.Email__c='test@gmail.com';
        batchEmls2.Is_UW__c=true;
        
        Batchnotificationemails__c batchEmls3 = new Batchnotificationemails__c();
        batchEmls3.name='All';
        batchEmls3.Email__c='test@gmail.com';
        
        batchEmlsLst.add(batchEmls);
        batchEmlsLst.add(batchEmls1);
        batchEmlsLst.add(batchEmls2);
        batchEmlsLst.add(batchEmls3);

        insert batchEmlsLst;
        
        Test.stopTest();
        
        //BatchNotifications.emailNotifications(null,'PSS','BatchClassName',failedRecordIds);
        BatchNotifications.emailNotifications(BC, 'PSS','BatchClassName',failedRecordIds);
        BatchNotifications.emailNotifications(BC, 'Sales','BatchClassName',failedRecordIds);
        BatchNotifications.emailNotifications(BC, 'UW','BatchClassName',failedRecordIds);
        BatchNotifications.emailNotifications(BC, 'All','BatchClassName',failedRecordIds);
        
        Database.SaveResult[] saveResults = Database.insert(batchEmlsLst,false);
        
        BatchNotifications.fetchSaveResults(saveResults);
        
        Database.DeleteResult[] deleteResults = Database.delete(batchEmlsLst,false);
        
        BatchNotifications.fetchDeleteResults(deleteResults);
        
        
    }
}