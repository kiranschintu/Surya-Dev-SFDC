global class CustomIterableBatchForAccount implements Database.Batchable<String>,Database.Stateful{
    
    public String CSVFile;
    //Constructor to hold the uploaded CSV file
    global CustomIterableBatchForAccount(String CSVFile){
        this.CSVFile= CSVFile;
    }
    //Start Method
    global Iterable<String> start(Database.BatchableContext bc){
        return new CustomIterable(CSVFile);
    }
    //execute method 
    global void execute(Database.BatchableContext bc,List<String> scope){
        
        List<String> inputvalues;
        try{        
            system.debug('**scope size**'+scope.size());
            List<Account> accounts= new List<Account>();
            
            for (Integer i=0;i<scope.size();i++){
                inputvalues = new List<String>();
                Account acc= new Account();
                
                //split the rows
                inputvalues = scope[i].split(',');
                
                //Assigning CSV file columns values to Asia PL Raw Object fields
                acc.Name= inputvalues[0];
                acc.phone = inputvalues[1];
                acc.description = inputvalues[2];
                //Adding to list
                accounts.add(acc);
            }
            Database.insert(accounts,false);
        }catch(Exception e){
            system.debug('Exception--->'+e+'%%%'+e.getmessage());
        }
        
    }
    
    global void finish(Database.BatchableContext bc){
    }
}