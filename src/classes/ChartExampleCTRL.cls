public class ChartExampleCTRL{
    // Get a set of Opportunities
    public List<Opportunity> opportunities{get;set;}
    public List<ChartData> chData{get;set;}
    public ChartExampleCTRL(){
        chData = new List<ChartData>();
        for(Opportunity opp :[SELECT name, type, amount, closedate FROM Opportunity]){
            //ChartData chd = new ChartData(opp.name,opp.amount);
            //chartData.add(chd);
        }
        chData.add(new ChartData('', 30));
        chData.add(new ChartData('', 50));
        chData.add(new ChartData('', 60));
    }
    
    public class ChartData{
        public string Name{get;set;}
        public Integer Amount{get;set;}
        public ChartData(string Name,Integer Amount){
            this.Name=Name;
            this.Amount=Amount;
        }
    }
}