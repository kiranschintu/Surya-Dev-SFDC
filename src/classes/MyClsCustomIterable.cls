global class MyClsCustomIterable implements Iterator<MyCls.MyInnerCls>{ 

   List<MyCls.MyInnerCls> myWrapDt{get; set;} 
   Integer i {get; set;} 

   public MyClsCustomIterable(List<MyCls.MyInnerCls> myWrapData){ 
       myWrapDt=myWrapData;
       i = 0; 
   }   

   global boolean hasNext(){ 
       if(i >= myWrapDt.size()) {
           return false; 
       } else {
           return true; 
       }
   }    

   global MyCls.MyInnerCls next(){ 
       // 8 is an arbitrary 
       // constant in this example
       // that represents the 
       // maximum size of the list.
       if(i == 8){return null;} 
       i++; 
       return myWrapDt[i-1]; 
   } 
}