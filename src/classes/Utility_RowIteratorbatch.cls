global class Utility_RowIteratorbatch{
    
  public String nameFile{get;set;}
  //Retrieve Content from the CSV File
  public transient Blob csvFile{get;set;}
 
  global Utility_RowIteratorbatch(){

  }
  
  /*global Utility_RowIteratorbatch(string nameFile){
      
      this.nameFile= nameFile;
      
  }

  global Iterable<String> start(Database.BatchableContext info){
     
     
     return new Utility_RowIterator(nameFile);
   }
  
   
  global void execute(Database.BatchableContext BC,List<String> scope){
             //List<String> acc = new List<String>();
             system.debug('**scope size**'+scope.size());
             List<Account> accs = new List<Account>();
             
             for (Integer i=1;i<scope.size();i++){
                 List<String> inputvalues = new List<String>();
                 inputvalues = scope[i].split(',');
                 Account acc= new Account();
                 acc.name=inputvalues[0];
                 acc.description='Batch Iterator';
                 accs.add(acc);
             }
             
             insert accs;
             
   }
   
 
  
  global void finish(Database.BatchableContext BC){
    //send completion email
  }*/
  global pagereference executebatch(){
      
     try{ 
     if(csvFile!=null && nameFile.contains('.csv')){
        // Convert the Blob content to String
        //nameFile=csvFile.toString();
        //nameFile= nameFile.trim();
        //nameFile= nameFile.replaceAll('(\\s+)', ' ');
   Utility_RowIteratorMainbatch ob = new Utility_RowIteratorMainbatch(csvFile);
      Database.executeBatch(ob,40);
      //ob=null;
      //nameFile=Null;
        }
        else
        {
        ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a record to upload...!'+nameFile);
            ApexPages.addMessage(errormsg);
        }
        
      
      }catch(exception e){
      ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Limit Exception');
            ApexPages.addMessage(errormsg);
      }
      return null;
  }
  
  
  global pagereference executebatch1(){
      
     try{ 
     if(csvFile!=null && nameFile.contains('.csv')){
      Utility_RowIteratorMainbatch1 ob = new Utility_RowIteratorMainbatch1(csvFile);
      Database.executeBatch(ob,40);
      }
        else
        {
        ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a record to upload...!'+nameFile);
            ApexPages.addMessage(errormsg);
        }
        
      
      }catch(exception e){
      ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Limit Exception');
            ApexPages.addMessage(errormsg);
      }
      return null;
  }
  
  public void catchingbatch(Map<Integer,String> scope){
  //List<String> acc = new List<String>();
             transient List<Account> accs = new List<Account>();
             system.debug('**scope size**'+scope.size());
             Map<Integer,String> mymap = new Map<Integer,String>();
             
             for (Integer i=0;i<scope.size();i++){
                 transient List<String> inputvalues = new List<String>();
                 Account acc= new Account();
                 //scope.get(0);
                inputvalues = scope.get(0).split(',');
                acc.name=inputvalues[0];
                acc.description='Batch Iterator';
                accs.add(acc);
             }
             system.debug('**scope size bf**'+accs.size());
             
             system.debug('**scope size af**'+accs.size());
             
             insert accs;
             
             
  }
}