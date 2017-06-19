global class UploadPageIterableBatch implements Database.Batchable<String>,Database.stateful{
    
    public String CSVFile;
    public Integer count=0;
   Savepoint sp;
   integer s=0;
    //Constructor to hold the uploaded CSV file
    global UploadPageIterableBatch(String CSVFile){
        this.CSVFile= CSVFile;
    }
    //Start Method
    global Iterable<String> start(Database.BatchableContext bc){
        //returning custom iterable class
        return new UploadPageIterable(CSVFile);
    }
    //execute method 
    global void execute(Database.BatchableContext BC,List<String> scope){
         if(s==0)
         {
             sp = Database.setSavepoint();
             s=1;
         }
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
            acc.fax = inputvalues[1];
            acc.phone = inputvalues[2];
            acc.Description = 'Batch Iterator';
                       
            //Adding to list
            accs.add(acc);
            system.debug('CPU Time execute for'+Limits.getCpuTime());

        }
        system.debug('CPU Time execute'+Limits.getCpuTime());
        system.debug('**scope list bf**'+accs.size());
        system.debug('**count**'+Count);
                
        //if(count==0)
        //accs.remove(0);
        //count++;
       if(accs.get(0).name.contains('Name'))
       accs.remove(0);
        
        system.debug('**scope list af**'+accs.size());
        system.debug('**count**'+Count);
        //Inserting records into LA PL Raw Object
        Database.insert(accs,false);
        }catch(exception e){
            system.debug('error trace :'+e);
            Database.rollback(sp);
        }
    }
    
    global void finish(Database.BatchableContext BC){
         system.debug('CPU Time finish'+Limits.getCpuTime());
        //send completion email
    }
}