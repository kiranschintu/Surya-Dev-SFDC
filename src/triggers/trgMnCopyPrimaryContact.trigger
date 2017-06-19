trigger trgMnCopyPrimaryContact on Opportunity (before update) {

   for (Opportunity o : Trigger.new) {
 
       OpportunityContactRole[] contactRoleArray =[select ContactID, isPrimary from OpportunityContactRole where OpportunityId = :o.id];
       if (contactRoleArray.size() > 0) {
         o.Opportunity_Intergaph_Line_of_Business__c = 'Kiran.........';
          
       }else{
      
           o.Opportunity_Intergaph_Line_of_Business__c = 'Kiran.........';
      
       }
      
   }
 }