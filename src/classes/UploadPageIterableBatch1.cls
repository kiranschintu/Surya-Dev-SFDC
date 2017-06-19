global class UploadPageIterableBatch1 implements Database.Batchable<String>,Database.stateful{
    
    public String CSVFile;
    public Integer count=0;
    //Constructor to hold the uploaded CSV file
    global UploadPageIterableBatch1(String CSVFile){
        this.CSVFile= CSVFile;
    }
    //Start Method
    global Iterable<String> start(Database.BatchableContext bc){
        //returning custom iterable class
        return new UploadPageIterable(CSVFile);
    }
    //execute method 
    global void execute(Database.BatchableContext BC,List<String> scope){
        try{
            List<Account> accs= new List<Account>();
            for (Integer i=0;i<scope.size();i++){
            List<String> inputvalues = new List<String>();
            Account acc= new Account();
            
            //split the rows
            inputvalues = scope[i].split(',');
            //if (scope[i].replaceAll(',','').trim().length() == 0) break;
            //Assigning CSV file columns values to LA PL Raw Object fields
            acc.Name = inputvalues[0];
            acc.Description = 'Batch Iterator';
                       
            //Adding to list
            accs.add(acc);
        }
        system.debug('**scope list bf**'+accs.size());
        system.debug('**count**'+Count);
                
        //if(count==0)
        //accs.remove(0);
        //count++;
        system.debug('**scope list af**'+accs.size());
        system.debug('**count**'+Count);
        
        //Inserting records into LA PL Raw Object
        Database.insert(accs,false);
        }catch(exception e){
            system.debug('error trace :'+e);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        //send completion email
    }
}