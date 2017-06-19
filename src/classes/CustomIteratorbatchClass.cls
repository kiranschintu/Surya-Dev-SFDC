global class CustomIteratorbatchClass implements Database.batchable<Account>{ 
   global Iterable<Account> start(Database.batchableContext info){ 
       return new foo(); 
   }     
   global void execute(Database.batchableContext info, List<Account> scope){ 
       List<Account> accsToUpdate = new List<Account>(); 
       for(Account a : scope){ 
           a.phone ='1111111111'; 
           accsToUpdate.add(a); 
       } 
       update accsToUpdate; 
   }     
   global void finish(Database.batchableContext info){     
   } 
}