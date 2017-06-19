public class Chart6CTRL{
    public List<BarData> barData{get;set;}
    
    public Chart6CTRL(){
        barData = new List<BarData>();
        
        barData.add(new BarData('Jan',10));
        barData.add(new BarData('Feb',25));
        barData.add(new BarData('Mar',20));
        barData.add(new BarData('Apr',45));
        barData.add(new BarData('May',25));
    }
    
    public Class BarData{
        public string Name{get;set;}
        public Decimal Amount{get;set;}
        public Decimal Amount1{get;set;}
        public Decimal Amount2{get;set;}
        
        public BarData(String Name,Decimal Amount){
            this.Name = name;
            this.Amount= Amount;
        }
    }
}