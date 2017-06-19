global class foo implements iterable<Account>{
   global Iterator<Account> Iterator(){
      return new CustomIterable();
   }
}