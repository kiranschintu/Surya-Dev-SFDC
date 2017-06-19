public class Chart4CTRL{
    public List<BarData> barData{get;set;}
    
    public Chart4CTRL(){
        barData = new List<BarData>();
        
        barData.add(new BarData('Jan',30,45,50));
        barData.add(new BarData('Feb',20,50,35));
        barData.add(new BarData('Mar',10,25,30));
        barData.add(new BarData('Apr',15,10,40));
        barData.add(new BarData('May',25,60,10));
    }
    
    public Class BarData{
        public string Name{get;set;}
        public Decimal Amount{get;set;}
        public Decimal Amount1{get;set;}
        public Decimal Amount2{get;set;}
        
        public BarData(String Name,Decimal Amount,Decimal Amount1,Decimal Amount2){
            this.Name = name;
            this.Amount= Amount;
            this.Amount1= Amount1;
            this.Amount2= Amount2;
        }
    }
}