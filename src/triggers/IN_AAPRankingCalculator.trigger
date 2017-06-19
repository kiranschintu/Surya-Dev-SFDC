trigger IN_AAPRankingCalculator on Opportunity (before update) {

    List<Opportunity> opps =Trigger.new;
    AAPRanking.doranking(opps);
    
   
}