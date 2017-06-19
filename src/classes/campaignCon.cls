public class campaignCon {

    public CampaignMember cm;
    
    public campaignCon(ApexPages.StandardController controller) {
        this.cm = (CampaignMember)controller.getRecord();
    }

    public CampaignMember getRecord(){
        cm = [select id,status,campaignid,campaign.name from campaignMember];
        return cm;
    }

}