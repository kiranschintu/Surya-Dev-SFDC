@isTest
private class TestAccessCustomSetting{
    @testSetup static void setData(){
        dhr__Account_CSV__c acsv = new dhr__Account_CSV__c();
        acsv.name = 'Test';
        acsv.dhr__Column1__c = 'Test1';
        acsv.dhr__Column2__c = 'Test2';
        acsv.dhr__Column3__c = 'Test3';
        insert acsv;
    }
    
    @isTest static void myUnitTest(){
        //Map<String,dhr__Account_CSV__c> maps = new Map<String,dhr__Account_CSV__c>([select id,name from dhr__Account_CSV__c ]);
        //system.debug('maps >>>'+maps);
        AccessCustomSetting ob = new AccessCustomSetting();
        ob.dosome();
    }
}