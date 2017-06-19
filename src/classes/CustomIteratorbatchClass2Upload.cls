global class CustomIteratorbatchClass2Upload implements Database.batchable<String>
{
   global Iterable<String> start(Database.batchableContext info){
       System.debug('Start method');
       return new foo2Upload();     
   }
   global void execute(Database.batchableContext info, List<String> scope)
   {
        List<Account> accs = new List<Account>();
        /*for (Integer i=1;i<scope.size();i++){
               
            String[] inputvalues = new String[]{};
        
            //Read multiple column values within the same row using split method
            inputvalues = scope[i].split(',');
            Account cnt= new Account();
       
           // inputvalues[0] to inputvalues[3] holdes the index of the CSV file,Read and Map Field from CSV to Salesforce.
      
         //Note : If you want to insert Extra fields map those fields below and in your CSV file
      
            cnt.Name= inputvalues[0];
            cnt.Description = inputvalues[1];
       
            //Add uploaded values into List
            accs.add(cnt);
        }*/
        insert accs;
   }
   global void finish(Database.batchableContext info)
   {
   }
}