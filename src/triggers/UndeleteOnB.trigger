trigger UndeleteOnB on B__c (after delete, after insert, after undelete,after update) {

    B__c[] cons;
    if (Trigger.isDelete) 
        cons = Trigger.old;
    else
        cons = Trigger.new;

    // get list of accounts
    Set<ID> acctIds = new Set<ID>();
    for (B__c con : cons) {
            acctIds.add(con.A__c);
    }
    
    Map<ID, B__c> contactsForAccounts = new Map<ID, B__c>([select Id ,A__c from B__c where A__c in :acctIds]);

    
    Map<ID, A__c> acctsToUpdate = new Map<ID, A__c>([select Id,No_Of_B_s__c from A__c where Id in :acctIds]);
                                                                 
    for (A__c acct : acctsToUpdate.values()) {
        Set<ID> conIds = new Set<ID>();
        
        //For No of Contacts in SFDC
        for (B__c con : contactsForAccounts.values()) {
            if (con.A__c == acct.Id)
                conIds.add(con.Id);
        }
        if (acct.No_Of_B_s__c != conIds.size())
            acct.No_Of_B_s__c = conIds.size();
      
    update acctsToUpdate.values();
}
}