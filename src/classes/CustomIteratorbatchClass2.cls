global class CustomIteratorbatchClass2 implements Database.Batchable<Account>{
  
  public string name{get;set;}  
  
  global CustomIteratorbatchClass2(){

  }
  
  global CustomIteratorbatchClass2(String name){
      this.name = name;
  }

  global Iterable<Account> start(Database.BatchableContext info){
     
     return new AggregateResultIterator(name);
   }
  
   
  global void execute(Database.BatchableContext BC, List<Account> scope){
             List<Account> acc = new List<Account>();
             for(Account a:scope){
             a.phone='99999';
             acc.add(a);
             }
             update acc;
   }
 
  
  global void finish(Database.BatchableContext BC){
    //send completion email
  }
  global pagereference executebatch(){
      CustomIteratorbatchClass2 ob = new CustomIteratorbatchClass2('sdfsdf');
      Database.executeBatch(ob);
      return null;
  }
}