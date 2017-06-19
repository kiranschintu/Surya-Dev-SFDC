public class VfOppContactRoleControllers 
{
    
    @future(callout=true)
    public static void updatePrimaryContact(String id)
    {
        Opportunity oppToUpdate;
       // for(OpportunityContactRole ocr : [select ContactId from OpportunityContactRole where OpportunityId = :oppId ])
       // {
                oppToUpdate = new Opportunity(Id = id, Opportunity_Intergaph_Line_of_Business__c = 'Hell',description='Helll');
       // }   
        
        
            update oppToUpdate;
    }
}