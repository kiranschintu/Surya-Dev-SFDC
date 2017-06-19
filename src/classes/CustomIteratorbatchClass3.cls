global class CustomIteratorbatchClass3 implements Database.Batchable<String>{
    
  public String nameFile{get;set;}
  //Retrieve Content from the CSV File
  public Blob csvFile{get;set;}
  
  global CustomIteratorbatchClass3(){

  }
  
  global CustomIteratorbatchClass3(blob csvFile){
      
      this.csvFile= csvFile;
      nameFile = csvFile.toString();
  }

  global Iterable<String> start(Database.BatchableContext info){
     
     
     return new CustomIteratorIterableClass3(nameFile);
   }
  
   
  global void execute(Database.BatchableContext BC,String[] scope){
             //List<String> acc = new List<String>();
             system.debug('**scope size**'+scope.size());
             List<Account> accs = new List<Account>();
             for (Integer i=1;i<scope.size();i++){
                 String[] inputvalues = new String[]{};
                 inputvalues = scope[i].split(',');
                 Account acc= new Account();
                 acc.name=inputvalues[0];
                 acc.description='Batch Iterator';
                 accs.add(acc);
             }
             accs.remove(0);
             insert accs;
             
   }
 
  
  global void finish(Database.BatchableContext BC){
    //send completion email
  }
  global pagereference executebatch(){
      
      if(csvFile!=null)
        {
        // Convert the Blob content to String
        nameFile=csvFile.toString();
   
        }
        else
        {
        ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a record to upload...!');
            ApexPages.addMessage(errormsg);
        }
      //CustomIteratorbatchClass3 ob = new CustomIteratorbatchClass3(nameFile);
      //Database.executeBatch(ob,10);
      return null;
  }
}