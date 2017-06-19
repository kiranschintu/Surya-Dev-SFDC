@isTest
private class TestDiplayContactCampaignHistory{
    private static testMethod void testCampaignHistory(){
        
        Account acc = new Account();
        acc.name ='Test';
        insert acc;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(acc);
        DiplayContactCampaignHistory DCC = new DiplayContactCampaignHistory(controller);
        DCC.getHistory();
    }
}