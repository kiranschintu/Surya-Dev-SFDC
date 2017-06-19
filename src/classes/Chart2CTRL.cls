public class Chart2CTRL{
    public List<PieData> pieData{get;set;}
    
    public Chart2CTRL(){
        pieData = new List<PieData>();
        
        for(Account acc:[Select id,name,AnnualRevenue from Account where AnnualRevenue!=null limit 5]){
            PieData.add(new PieData(acc.Name.subString(0,5),acc.AnnualRevenue));
        }
        
    }
    
    public class PieData{
        public string name{get;set;}
        public Decimal data{get;set;}
        
        public PieData(String name,Decimal data){
            this.name=name;
            this.data=data;
        }
    }
}