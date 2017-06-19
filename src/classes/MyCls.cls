global class MyCls{
    List<MyInnerCls> obs = new List<MyInnerCls>();
    public void doSOme(){
        MyInnerCls ob = new MyInnerCls();
        ob.name='Surya';
        ob.phone='9876789790';
        
        MyInnerCls ob1 = new MyInnerCls();
        ob1.name='Surya1';
        ob1.phone='8888888888';
        
        obs.add(ob);
        obs.add(ob1);
        
        MyClsbatchClass obBat = new MyClsbatchClass(obs);
        Database.executeBatch(obBat,1);
    }
    
    global class MyInnerCls{
        public string name;
        public string phone;
    }
}