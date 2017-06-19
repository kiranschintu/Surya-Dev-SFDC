public class DiplayContactCampaignHistory {
    
    final Account account;
    
    public DiplayContactCampaignHistory(ApexPages.StandardController controller) {
        this.account = (Account)controller.getRecord();
    }
    //retrieving campaign history
    public List<CampaignMember> getHistory(){
        List<Contact> contact;
        contact = [select id,name from contact where AccountId =:account.id];
        List<CampaignMember> cmember;
        List<Id> CmIds = new List<Id>();
        for(Contact con:contact){
          CmIds.add(con.id);
        }
        cmember = [select id,contact.name,contactId,Campaign.name,Campaign.StartDate,Campaign.Type,Campaign.Status,Campaign.IsActive from CampaignMember where Contactid IN:CmIds];
        
        return cmember;
    }
    
    /*private static testMethod void testCampaignHistory(){
        
        Account acc = new Account();
        acc.name ='Test';
        insert acc;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(acc);
        DiplayContactCampaignHistory DCC = new DiplayContactCampaignHistory(controller);
        DCC.getHistory();
    }*/

}