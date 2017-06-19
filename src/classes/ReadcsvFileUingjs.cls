public with sharing class ReadcsvFileUingjs {
    
    public string nameFile{get;set;}
    public string HeaderValues{get;set;}
    
    public PageReference ReadFile(){
        //if(HeaderValues!=Null)
         
        /*List<dhr__Account_CSV__c> mcs = dhr__Account_CSV__c.getall().values();
        List<String> headeravaluess ;
        
        
        if(HeaderValues!=Null ){
            headeravaluess = HeaderValues.split(',');
            if(headeravaluess[0]=='Name'){
             ApexPages.Message msg= new ApexPages.Message(ApexPages.severity.Info, 'Columns Matched');
         ApexPages.addMessage(msg);
       }else{
       ApexPages.Message msg= new ApexPages.Message(ApexPages.severity.Error, 'Header values'+HeaderValues+'::'+mcs[0].dhr__Column1__c);
         ApexPages.addMessage(msg);
       }
        }    
        
        */
        
        UploadPageIterableBatch ob = new UploadPageIterableBatch(nameFile);
        Database.executeBatch(ob,10);
        nameFile=null;
        return null;
    }
}