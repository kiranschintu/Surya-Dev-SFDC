public class LTNGLeadForm{
    @AuraEnabled
    public static string createLeaad(Lead newLead){
        try{
            insert newLead;
            return 'Success: '+newLead.id;
        }catch(Exception e){
            return 'Error:'+e.getMessage();
        }
    }
    
    @AuraEnabled
    public static List<Lead> fetchLeads(){
        return [Select id,name,email,AnnualRevenue,Reimburse__c,CreatedDate from Lead limit 30];
    }
    
    @AuraEnabled
    public static string updateSFLead(Lead extLead){
        try{
            system.debug('Lead to Update>>>>'+extLead);
            update extLead;
            return 'Success.';
        }catch(Exception e){
            return 'Error:'+e.getMessage();
        }
    }
}