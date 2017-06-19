public with sharing class groupaccounts2 {
    public List<Opportunity> opp{get;set;}
    public List<String> UniqueStages{get;set;}
    public groupaccounts2(){
    UniqueStages = new List<String>();
    opp = [select id,name,stagename from Opportunity limit 100];
    Set<String> stage= new Set<String>();
    for(Opportunity o:opp){
        stage.add(o.stagename);
    }
    UniqueStages.addAll(stage);
    }
}