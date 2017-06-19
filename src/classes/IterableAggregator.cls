global class IterableAggregator implements Database.Batchable<AggregateResult> {
    
    global Iterable<AggregateResult> start(Database.batchableContext info){
        // just instantiate the new iterable here and return
        return new AggregateResultIterable();
    }

    global void execute(Database.BatchableContext BC, List<Sobject> scope){
        System.debug('SCOPE > ' + scope);
    }

    global void finish(Database.BatchableContext BC){
    }   

    global class AggregateResultIterable implements Iterable<AggregateResult> {
        global Iterator<AggregateResult> Iterator(){
            return new AggregateResultIterator();
       }
    }

    global class AggregateResultIterator implements Iterator<AggregateResult> {
        AggregateResult [] results {get;set;}
        Integer index {get; set;} 
                
        global AggregateResultIterator() {
            index = 0;
            String query = 'Select Department, COUNT(Name) From Contact GROUP BY Department';
            results = Database.query(query);            
        } 
        
        global boolean hasNext(){ 
           return results != null && !results.isEmpty() && index < results.size(); 
        }    
        
        global AggregateResult next(){ 
            return results[index++];            
        }       
    }    

}