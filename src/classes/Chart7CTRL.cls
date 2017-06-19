public class Chart7CTRL {
    public List<BarData> barData{get;set;}
    
    public Chart7CTRL(){
        barData = new List<BarData>();
        
        barData.add(new BarData('Jan',10,45));
        barData.add(new BarData('Feb',25,50));
        barData.add(new BarData('Mar',20,25));
        barData.add(new BarData('Apr',45,10));
        barData.add(new BarData('May',25,60));
    }
    
    public Class BarData{
        public string Name{get;set;}
        public Decimal Amount{get;set;}
        public Decimal Amount1{get;set;}
        public Decimal Amount2{get;set;}
        
        public BarData(String Name,Decimal Amount,Decimal Amount1){
            this.Name = name;
            this.Amount= Amount;
            this.Amount1= Amount1;
        }
    }
}