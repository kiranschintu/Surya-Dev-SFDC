global class ContentVersionBatch implements Database.Batchable<sObject>,Database.Stateful{
    
    public integer count=0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select id,Title,FileType,VersionData from ContentVersion where title='Asia PL 12-5-13']);
    }
    global void execute(Database.BatchableContext bc,List<ContentVersion> cv){
        
            system.debug('**scope size**'+cv.size());
            List<Account> accounts= new List<Account>();
            ContentVersion c = cv[0];
            
            Blob bodyBlob = c.VersionData;
            String bodyStr = bodyBlob.toString(); 
            List<string> bodystr1 = new List<String>(); 
            bodystr1 = bodystr.split('\n');
            system.debug('**Records size**'+bodystr1.size());
            
            for (Integer i=1;i<bodystr1.size();i++){
            String[] inputvalues = new String[]{};
            //Read multiple column values within the same row using split method
            inputvalues = bodystr1[i].split(',');
            
            Account acc = new Account();
            //Assigning CSV file columns values to Asia PL Raw Object fields
            acc.Name = 'HELLO';
            acc.Description = inputvalues[3];
            
            //Adding to list
            accounts.add(acc);
        }
        system.debug('**scope list bf**'+accounts.size());
        system.debug('**count**'+Count);
                
        //if(count==0)
        //accounts.remove(0);
        //count++;
        //system.debug('**scope list af**'+accounts.size());
        //system.debug('**count**'+Count);
        
        //Inserting records into Asia PL Raw Object
        Database.insert(accounts,false);
    }
    global void finish(Database.BatchableContext bc){
    
    }
}