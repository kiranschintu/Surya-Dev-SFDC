public with sharing class uploadpagecon {
    //Retrieve Content from the CSV File
  public transient Blob csvFile{get;set;}
  public transient String filename{get;set;}
  Integer m_index = 0;
  String m_rowDelimiter = '\n';
  public String csv1{get;set;}
  public String csv2{get;set;}
 
  //Passing csv file data to batch class
  public pagereference ReadFile(){
      
     /* if(csvFile!=null && filename.contains('.csv')){
          
          String FileData = csvFile.toString();
          Integer key;
          Integer d=3;
          for(Integer i=0;i<3;i++){
          while(m_index<=FileData.length()/d){
            key  = FileData.indexOf(m_rowDelimiter, m_index);
            system.debug('Key idexof :'+key);
            
            if (key == -1)
            key = FileData.length();
            system.debug('String Length :'+FileData.length());
            String row = FileData.subString(m_index, key);
            system.debug('LINE :'+row);
            m_index = key + 1;
            system.debug('m_index :'+m_index);
        }
        csv1 = FileData.subString(0,key);
        
        LaPL2ConBatch ob = new LaPL2ConBatch(csv1);
        Database.executeBatch(ob,200);
        
        if(d!=1)
        d=d-1;
        if(FileData.length()>m_index)
        FileData= FileData.substring(m_index,FileData.length());
        m_index=0;
        
             
       }
       csv1=Null;
           //csv2=Null;
           FileData=Null;
           csvFile=Null;
        return null; 
       }
      */
      
      
      
      //checking uploaded file
      if(csvFile!=null && filename.contains('.csv')){
          
          String FileData = csvFile.toString();
          Integer key;
          Integer removeFirstrow = FileData.indexOf(m_rowDelimiter, m_index);
          while(m_index<=FileData.length()/2){
            key  = FileData.indexOf(m_rowDelimiter, m_index);
            system.debug('Key idexof :'+key);
            
            if (key == -1)
            key = FileData.length();
            system.debug('String Length :'+FileData.length());
            String row = FileData.subString(m_index, key);
            system.debug('LINE :'+row);
            m_index = key + 1;
            system.debug('m_index :'+m_index);
    }
        csv1 = FileData.subString(removeFirstrow,key);
        
        UploadPageIterableBatch ob = new UploadPageIterableBatch(csv1);
        Database.executeBatch(ob,200);
        
        system.debug('** Total Rows **'+csv1);
        Integer subm_index = m_index;
        
        key = FileData.length();
        csv2 = FileData.subString(subm_index,key);
        
       
        UploadPageIterableBatch ob1 = new UploadPageIterableBatch(csv2);
        Database.executeBatch(ob1,200);
           csv1=Null;
           csv2=Null;
           FileData=Null;
           csvFile=Null;
        return null;   
       }
        else{
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a file to upload...!');
            ApexPages.addMessage(errormsg);
            return null;
        }
    }
}