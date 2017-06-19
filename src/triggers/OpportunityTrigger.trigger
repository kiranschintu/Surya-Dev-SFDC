trigger OpportunityTrigger on Opportunity (after insert) {
    
    String currentURL = ApexPages.currentPage().getParameters().get('retURL');//URL.getCurrentRequestUrl();
    //URL comparisonURL = new URL(URL.getSalesforceBaseUrl().toExternalForm() + Page.YOUR_VF_PAGE_URL.getUrl());
    system.debug('currentURL:::'+ currentURL);
    //system.debug('comparisonURL:::'+ comparisonURL);
    //boolean knownPath = currentURL.getPath() == comparisonURL.getPath();
     
    
    /*Set<Id> accountIds = new Set<Id>();
    Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
    List<Contact> consToUpdate = new List<Contact>();
    
    for(Opportunity opp:trigger.new){
        if(opp.AccountId!=null){
            accountIds.add(opp.AccountId);
            oppMap.put(opp.AccountId,opp);
        }
    }
    for(Contact con:[Select id,description,AccountId from Contact where AccountId IN:accountIds AND Is_Primary__c=true]){
        if(oppMap.containsKey(con.AccountId) && oppMap.get(con.AccountId)!=null){
            con.description = oppMap.get(con.AccountId).description;
            consToUpdate.add(con);
        }
    }
    if(!consToUpdate.isEmpty()){
        update consToUpdate;
    }*/
}