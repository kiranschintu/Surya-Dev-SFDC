global class CustomIteratorbatchClass1 implements Database.batchable<Account>
{
   global Iterable<Account> start(Database.batchableContext info)
   {
       System.debug('Start method');
       //return new foo1();
       
       //return new CustomIterable1();
       return null;     
   }
   global void execute(Database.batchableContext info, List<Account> scope)
   {
       List<Account> memsToUpdate = new List<Account>();
       System.debug('Member list size is ' + scope.size());
       for(Account m : scope)
       {
           m.phone='4444';
           memsToUpdate.add(m);
       }
       update memsToUpdate;
   }
   global void finish(Database.batchableContext info)
   {
   }
}
/*
global class scheduleBirthdayWish implements Schedulable
{
    global void execute(SchedulableContext SC)
    {
        memberBirthdayBatch mbw = new memberBirthdayBatch();
        Database.executeBatch(mbw);
    }
}*/