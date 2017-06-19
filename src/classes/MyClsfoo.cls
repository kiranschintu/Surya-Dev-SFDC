global class MyClsfoo implements iterable<MyCls.MyInnerCls>{
   List<MyCls.MyInnerCls> obs = new List<MyCls.MyInnerCls>();
   global MyClsfoo(List<MyCls.MyInnerCls> obs1){
       obs=obs1;
   }
   global Iterator<MyCls.MyInnerCls> Iterator(){
      
      
      return new MyClsCustomIterable(obs);
   }
}