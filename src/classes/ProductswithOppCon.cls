public class ProductswithOppCon {

    public Product2 Inv;
    public List<OpportunityLineItem> Lin;
    public List<Opportunity> Mer;
    
    public ProductswithOppCon(ApexPages.StandardController controller) {
        this.Inv = (Product2)controller.getRecord();
    }
    public List<OpportunityLineItem> getRecords(){
        
        Lin = [select OpportunityId,Opportunity.RecordTypeId,Opportunity.Amount,Opportunity.AccountId,Opportunity.contact__c from OpportunityLineItem where PricebookEntry.Product2.id =: Inv.id];
        
        return Lin;
    }

}