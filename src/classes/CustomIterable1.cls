global class CustomIterable1 implements Iterator<Account>, iterable<Account>
{
   global static List<Account> memList{get; set;}
   Integer i {get; set;}
   global string name{get;set;}

   global CustomIterable1 (string name)
   {    
       memList = new List<Account>();
        memList = [SELECT name,phone FROM Account where name=:name];
        //dosome();
       i = 0;
   }
   
   global CustomIterable1 ()
   {    
       memList = new List<Account>();
        memList = [SELECT name,phone FROM Account];
        //dosome();
       i = 0;
   }
   
   /*global void dosome(){
   system.debug('***dosome memList***'+memList);
   system.debug('***dosome i***'+i);
   memList = new List<Account>();
   i=0;
   memList = [SELECT name,phone FROM Account ];//where name=:name];
   system.debug('***dosome memList***'+memList);
   system.debug('***dosome i***'+i);
   
       //return memList;
   }*/
   

   global boolean hasNext()
   {
   
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
   global Iterator<Account> Iterator()
   {
      //public String name;  
        //global CustomIterable1(String name){
             //this.name = name;
         //}
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