global class AggregateResultIterator implements Iterator<Account>,Iterable<Account> {
        
        List<Account> results {get;set;}
        Integer index {get; set;} 
        public String name;  
        global AggregateResultIterator(String name) {
            index = 0;
            /*
            String query = 'SELECT a.Contact_Id__c, a.Completed_Date__c FROM Accumulated_Activity__c a ' + 
            'WHERE a.Completed_Date__c = LAST_MONTH GROUP BY a.Completed_Date__c';
            */
            this.name = name;
            //results = Database.query(query);
            results=[select id,phone from account where name=:name];            
        } 
 
        global boolean hasNext(){ 
           return results != null && !results.isEmpty() && index < results.size(); 
        }    
 
        global Account next(){ 
            return results[index++];            
        }
        global Iterator<Account> Iterator(){
            return new AggregateResultIterator(name);
       }         
}