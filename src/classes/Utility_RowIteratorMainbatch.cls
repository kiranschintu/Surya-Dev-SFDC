global class Utility_RowIteratorMainbatch implements Database.Batchable<String>,Database.stateful{
    
  public blob nameFile;
  public Integer count=0;
  public Integer i=0;
  
  global Utility_RowIteratorMainbatch(Blob nameFile){
      
      this.nameFile= nameFile;
      
  }

  global Iterable<string> start(Database.BatchableContext info){
     return new Utility_RowIterator(nameFile);
   }
  
   
  global void execute(Database.BatchableContext BC,List<String> scope){
             
             
             /*//List<String> acc = new List<String>();
             transient List<Account> accs = new List<Account>();
             system.debug('**scope size**'+scope.size());
             String row='';
             Map<Integer,String> mamap = new Map<Integer,String>();
             
             for (String s:scope){
                 mamap.put(i,s);
                 i++;
             }*/
             
             try{
             //List<String> acc = new List<String>();
             transient List<Account> accs = new List<Account>();
             system.debug('**scope size**'+scope.size());
             
             for (Integer i=0;i<scope.size();i++){
                 transient List<String> inputvalues = new List<String>();
             Account acc= new Account();
                 inputvalues = scope[i].split(',');
                 
                 acc.name=inputvalues[0];
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 acc.description='Batch Iterator';
                 accs.add(acc);
             }
             system.debug('**scop size list bf**'+accs.size());
             system.debug('**Count**'+count);
             if(count==0)
             accs.remove(0);
             count++;
             
             system.debug('**Count**'+count);
             system.debug('**scop size list af**'+accs.size());
             
             insert accs;
             //accs=Null;
             //scope=null;
             //nameFile=null;
             }catch(exception e){
             //system.debug('error trace :');
             }            
             
   }
   
 
  
  global void finish(Database.BatchableContext BC){
    //send completion email
  }
  
}