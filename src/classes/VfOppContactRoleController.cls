public with sharing class VfOppContactRoleController 
{
    public string oppId {get; set;}
    
    public VfOppContactRoleController(ApexPages.StandardController oppController)
    {
        oppId = oppController.getId();
    }
    
    public void updatePrimaryContact()
    {
        Opportunity oppToUpdate;
       // for(OpportunityContactRole ocr : [select ContactId from OpportunityContactRole where OpportunityId = :oppId ])
       // {
                oppToUpdate = new Opportunity(Id = oppId, Opportunity_Intergaph_Line_of_Business__c = 'Hell',description='Helll');
       // }   
        
        
            update oppToUpdate;
    }
}