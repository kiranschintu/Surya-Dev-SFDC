@isTest
private class TestLeadTrigger{
    private static testMethod void unitTest(){
        Lead led = new Lead();
        led.LastName='Test';
        led.Company='Test';
        insert led;
    }
}