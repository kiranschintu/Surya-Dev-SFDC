public with sharing class aggregate1 {
    
    public List<groupstage> values{get;set;}
    public List<groupstage1> values1{get;set;}
    List<Opportunity> opps = new List<Opportunity>();
    public aggregate1(){
        List<AggregateResult> agr= [Select StageName,Sum(Amount)amount,count(id)cont from Opportunity group by StageName];
        values = new List<groupstage>();
        values1 = new List<groupstage1>();
        opps = [select name,stagename,amount from Opportunity];
        for(AggregateResult a:agr){
            values.add(new groupstage(a,opps));
        }
        for(Opportunity o:opps){
            values1.add(new groupstage1(o));
        }
    }
    
    
    
    public class groupstage{
        public Double amount{get;private set;}
        public string stage{get;private set;}
        public Integer count{get;private set;}
        public List<Opportunity> opp{get;private set;}
        public Map<string,opportunity> mymap;
        public groupstage(AggregateResult agr,List<Opportunity> opp){
            amount = (Double)agr.get('amount');
            stage = (String)agr.get('stagename');
            count = (Integer)agr.get('cont');
            this.opp = opp;
            mymap.put((String)agr.get('stagename'),opp[0]);
        }
        
    }
    public class groupstage1{
        public Double Amount{get;private set;}
        public string stage{get;private set;}
        public String Name{get;private set;}
        public groupstage1(Opportunity opp){
            amount = (Double)opp.get('amount');
            stage = (String)opp.get('stagename');
            name = (String)opp.get('name');
        }
    }
}