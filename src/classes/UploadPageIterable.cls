public class UploadPageIterable implements Iterator<String>,Iterable<String> {

   private String m_Data;
   //private blob fileData;
   private Integer m_index = 0;
   private String m_rowDelimiter = '\r\n';
    
   //Constructor to hold the uploaded CSV File
   public UploadPageIterable(String m_Data){
      
      //this.fileData = fileData;
      //m_Data = fileData.toString();
      this.m_Data = m_Data;
      
   }
   
   //Traversing each item in the collection
   public Boolean hasNext(){
   system.debug('CPU Time Iterator hasnext'+Limits.getCpuTime());
      return m_index < m_Data.length() ? true : false;
   }
   
   //To return the next item in the collection
   public String next(){    
       system.debug('CPU Time Iterator next'+Limits.getCpuTime());
      Integer key = m_Data.indexOf(m_rowDelimiter, m_index);
      system.debug('Key'+key);
      if (key == -1)
      key = m_Data.length();
      system.debug('Key'+key);
      system.debug('**file length**'+m_Data.length());
      
      String row = m_Data.subString(m_index, key);
      //row = row.replaceAll(';',' ');
      //row = row.trim();
      m_index = key + 1;
      system.debug('Key'+key);
      //returning row;
      system.debug('CPU Time Iterator next1'+Limits.getCpuTime());
      return row;
      
      
   }
   
   //Creatig reference to the iterator 
   public Iterator<String> Iterator(){
      return this;  
   }       
       
                
}