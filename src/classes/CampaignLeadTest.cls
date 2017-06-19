@isTest
private class CampaignLeadTest {
    private static testMethod void testSingleInsert(){
        
        Campaign c = new Campaign();
        c.name = 'sample';
        insert c;
        
        Lead l = new Lead();
        l.lastname = 'sample';
        l.company = 'sfsdfsdf';
        l.status = 'Working-Contacted';
        insert l;
        
        CampaignMember cm = new CampaignMember();
        cm.Campaignid = c.id;
        cm.Leadid = l.id;
        cm.status = 'sent';
        insert cm;
        
    }
}