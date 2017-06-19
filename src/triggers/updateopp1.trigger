trigger updateopp1 on Opportunity (before update) {
    
    List<Opportunity> con =Trigger.new;
    Opportunity opp = Trigger.old[0];
    for (Opportunity newOpp : con) {
   String lm =''+opp.LastModifieddate;
   String nm =''+newOpp.LastModifieddate;
   if(opp.LastModifieddate!=newOpp.LastModifieddate)
        newOpp.description =''+newOpp.LastModifieddate+'Diff'+opp.LastModifieddate;
    
    }
    
}