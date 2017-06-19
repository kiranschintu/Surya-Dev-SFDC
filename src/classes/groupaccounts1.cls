public with sharing class groupaccounts1 {
    
        public List<Lead> leads{get;set;}
        public List<String> industries{get;set;}
        public groupaccounts1(){
        industries = new List<String>();
        leads = [select id,name,Industry from Lead];
        
        Set<String> industryset = new Set<String>();
        for(Lead l:leads){
        industryset.add(l.Industry);
        }
        
        //for(String s:industryset){
            //industries.add(s);
        //}
        industries.addAll(industryset);
        
        
    }
    
   
}