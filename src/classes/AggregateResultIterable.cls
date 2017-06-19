global class AggregateResultIterable implements Iterable<Account> {
        
        public String query;  
        global AggregateResultIterable (String query){
             this.query = query;
         }
        global Iterator<Account> Iterator(){
            return new AggregateResultIterator(query);
       }             
   }