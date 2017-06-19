public class AccountDeepCloneUtil { 

public static void cloneAccount(Account acc) { 
    Map<Opportunity, List<OpportunityLineItem>> OpportunityLineItemsMapping = new Map<Opportunity, List<OpportunityLineItem>>();
    
    List<Opportunity> newOpportunityList = new List<Opportunity>(); 
    List<Opportunity> oppList = [Select Id, Name,StageName,CloseDate,AccountId,TotalOpportunityQuantity, (Select Id,OpportunityId,Quantity,TotalPrice,PricebookEntryId from  OpportunityLineItems)  from Opportunity where AccountId = :acc.Id]; 
    
    /*Account  newAcc = acc.clone();
    newAcc.name +='Ending with Update'; 
    system.debug('New Account'+newAcc );
    
    insert newAcc;
    */
    
    List<Account> acclst = new List<Account>();
    acclst.add(acc);
    List<Account> acclst1 = new List<Account>();
    acclst1 = acclst.deepclone(false,false,false);
    system.debug('acclst1>>>'+acclst1);
    insert acclst1;  //insert the account  record 
    
    
    /*
    for(Opportunity opp : oppList)
    {
        Opportunity newOpp = opp.clone(); 
        newOpp.AccountId = newAcc.Id; 
        newOpportunityList.add(newOpp); 
    }
    
    insert newOpportunityList;
    
    for(Opportunity opp : newOpportunityList)
    {
        OpportunityLineItemsMapping.put(opp, opp.OpportunityLineItems.deepClone(false, false,false));
    }
    
    List<OpportunityLineItem> ops = new List<OpportunityLineItem>();

    for(Opportunity opp : OpportunityLineItemsMapping.KeySet())
    {
        for(OpportunityLineItem  oppLineItem : OpportunityLineItemsMapping.get(opp))
        {   
             oppLineItem.OpportunityId = opp.Id; 
             ops.add(oppLineItem);
        }
     }
     insert ops;
    
    */
}
}