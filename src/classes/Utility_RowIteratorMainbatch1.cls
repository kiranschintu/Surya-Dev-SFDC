global class Utility_RowIteratorMainbatch1 implements Database.Batchable<List<String>>,Database.stateful{
    
  public blob nameFile;
  public Integer count=0;
  public Integer i=0;
  
  global Utility_RowIteratorMainbatch1(Blob nameFile){
      
      this.nameFile= nameFile;
      
  }

  global Iterable<List<string>> start(Database.BatchableContext info){
     return new Utility_RowIterator1(nameFile);
   }
  
   
  global void execute(Database.BatchableContext BC,List<List<String>> scope){
             
             
             
             try{
             //List<String> acc = new List<String>();
             transient List<Account> accs = new List<Account>();
             system.debug('**scope size**'+scope.size());
             
             for(List<String> s:scope){
             system.debug('**scope 2 size**'+s.size());
                 for(Integer i=0;i<s.size();i++){
                 transient List<String> inputvalues = new List<String>();
                 Account acc= new Account();
                 inputvalues = s[i].split(',');
                 
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
             
             }
             system.debug('**scop size list bf**'+accs.size());
             system.debug('**Count**'+count);
             if(count==0)
             accs.remove(0);
             count++;
             
             system.debug('**Count**'+count);
             system.debug('**scop size list af**'+accs.size());
             
             insert accs;
             /*for (Integer i=0;i<scope.size();i++){
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
             
             insert accs;*/
             }catch(exception e){
             //system.debug('error trace :');
             }          
             
   }
   
 
  
  global void finish(Database.BatchableContext BC){
    //send completion email
  }
  
}