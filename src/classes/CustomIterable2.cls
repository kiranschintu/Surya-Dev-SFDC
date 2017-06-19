global with sharing class CustomIterable2 {
    
    
   global static List<Account> memList{get; set;}
   Integer i {get; set;}
   global string name{get;set;}


    global CustomIterable2() {

    }

   global CustomIterable2 (string name)
   {    
       memList = new List<Account>();
        memList = [SELECT name,phone FROM Account where name=:name];
        
       i = 0;
   }
   
   global boolean hasNext(){
   
   system.debug('***hasNext memList***'+memList);
   system.debug('***hasNext i***'+i);
       if(i >= memList.size())
       {
           return false;
       } else {
           return true;
       }
       
   }

   global Account next()
   {
   
      system.debug('***next memList***'+memList);
   system.debug('***next i***'+i);
       if(i > memList.size())
       {
           return null;
       }
       i++;
       return memList[i-1];
   }
   
   global Iterator<Account> Iterator(){
      return new CustomIterable1(name);
   }
   
   global Pagereference ExecuteBatch(){
   
   system.debug('***ExecuteBatch memList***'+memList);
   system.debug('***ExecuteBatch i***'+i);
       //dosome();
       //dosome();
       system.debug('***ExecuteBatch memList***'+memList);
   system.debug('***ExecuteBatch i***'+i);
       if(memList.isEmpty()){
       
       }else{
       CustomIteratorbatchClass1 ob = new CustomIteratorbatchClass1();
       Database.executeBatch(ob);
       }
       return null;
   }
}