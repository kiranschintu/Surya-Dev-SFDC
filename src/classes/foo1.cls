global class foo1 implements iterable<Account>
{
   global Iterator<Account> Iterator()
   {
      //return new CustomIterable1();
     return null; 
   }
}