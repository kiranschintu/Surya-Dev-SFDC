trigger ShareWithReportingMng on Opportunity  (after insert,after update) {
    
 if (Trigger.isInsert) {
    List<OpportunityShare> oppSharList = new List<OpportunityShare>();
    for( Opportunity cs : trigger.new ) {
        if( cs.User__c != NULL ) {
            // Create a new OpportunityShare object for each Opportunity where User__c field is not NULL.
            OpportunityShare oppShar = new OpportunityShare();
            // Give Read write access to that user for this particular Opportunity record.
            oppShar.OpportunityAccessLevel = 'edit';
            // Assign Opportunity Id of Opportunity record.
            oppShar.OpportunityId = cs.id;
            // Assign user id to grant read write access to this particular Opportunity record.
            oppShar.UserOrGroupId = cs.User__c;
            oppSharList.add( oppShar );
        }
    }
    if( oppSharList != null && oppSharList.size() != 0 ) {
        try {
            insert oppSharList;
        }catch( Exception e ) {
            trigger.new[0].User__c.addError('Error::::::'+e.getMessage());
        }
    }
 }

 // updating existing records
  else if(Trigger.isUpdate) {

    List<OpportunityShare> oppSharList = new List<OpportunityShare>();
    List<ID> shareIdsToDelete = new List<ID>();

    for (Opportunity cs: Trigger.new) {

      // if the record was public but is now private -- delete the existing share
      if (Trigger.oldMap.get(cs.id).User__c != null && cs.User__c == null) {
        shareIdsToDelete.add(cs.id);

      // if the record was private but now is public -- create the new share for the group
      } else if (Trigger.oldMap.get(cs.id).User__c == null && cs.User__c != null) {

            OpportunityShare oppShar = new OpportunityShare();
            // Give Read write access to that user for this particular Opportunity record.
            oppShar.OpportunityAccessLevel = 'edit';
            // Assign Opportunity Id of Opportunity record.
            oppShar.OpportunityId = cs.id;
            // Assign user id to grant read write access to this particular Opportunity record.
            oppShar.UserOrGroupId = cs.User__c;
            oppSharList.add( oppShar );

      }

    }

    // do the DML to delete shares
    if (!shareIdsToDelete.isEmpty())
      delete [select id from OpportunityShare where OpportunityId IN :shareIdsToDelete and RowCause = 'Manual'];

    // do the DML to create shares
    if (!oppSharList.isEmpty())
      insert oppSharList;

  }
 
}