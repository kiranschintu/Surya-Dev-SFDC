public class junctionobjCon {
    
    public Invoice_Statement__c Inv;
    public List<Line_Item__c> Lin;
    public List<Merchandise__c> Mer;
    public junctionobjCon(ApexPages.StandardController controller) {
        this.Inv = (Invoice_Statement__c)controller.getRecord();
    }
    public List<Line_Item__c> getRecords(){
        
        Lin = [select id,name,Merchandise__r.name  from Line_Item__c where Invoice_Statement__c =: Inv.id];
        
        return Lin;
    }
    public List<Merchandise__c> getMerRecords(){
        
        //Mer = [select id,name from Merchandise__c where Invoice_Statement__c =: Inv.id];
        
        return Mer;
    }
    

}