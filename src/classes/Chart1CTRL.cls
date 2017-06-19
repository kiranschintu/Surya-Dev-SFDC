public class Chart1CTRL{
    public List<PieData> pieData{get;set;}
    
    public Chart1CTRL(){
        pieData = new List<PieData>();
        
        PieData.add(new PieData('Jan',30));
        PieData.add(new PieData('Feb',20));
        PieData.add(new PieData('Mar',10));
        PieData.add(new PieData('Apr',15));
        PieData.add(new PieData('May',25));
        
    }
    
    public class PieData{
        public string name{get;set;}
        public Integer data{get;set;}
        
        public PieData(String name,Integer data){
            this.name=name;
            this.data=data;
        }
    }
}