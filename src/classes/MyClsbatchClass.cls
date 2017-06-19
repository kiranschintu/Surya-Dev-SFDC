global class MyClsbatchClass implements Database.batchable<MyCls.MyInnerCls>{ 
   List<MyCls.MyInnerCls> wrapDatas;
   global MyClsbatchClass(List<MyCls.MyInnerCls> wrapData){
       wrapDatas = wrapData;
   }
   global Iterable<MyCls.MyInnerCls> start(Database.batchableContext info){ 
       return new MyClsfoo(wrapDatas); 
   }     
   global void execute(Database.batchableContext info, List<MyCls.MyInnerCls> scope){ 
       system.debug('Records>>>'+scope);
   }     
   global void finish(Database.batchableContext info){     
   } 
}