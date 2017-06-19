public class Chart3CTRL {
    public List<BarData> barData{get;set;}
    
    public Chart3CTRL (){
        barData = new List<BarData>();
        
        barData.add(new BarData('Jan',30));
        barData.add(new BarData('Feb',20));
        barData.add(new BarData('Mar',10));
        barData.add(new BarData('Apr',15));
        barData.add(new BarData('May',25));
    }
    
    public Class BarData{
        public string Name{get;set;}
        public Integer Amount{get;set;}
        
        public BarData(String Name,Integer Amount){
            this.Name = name;
            this.Amount= amount;
        }
    }
}