public class CustomIterable implements Iterator<String>,Iterable<String> {

   private String fileData;
   private Integer m_index = 0;
   private String m_rowDelimiter = '\n';
    
   //Constructor to hold the uploaded CSV File
   public CustomIterable (String fileData){
      
      this.fileData=fileData;
      
   }
   
   //Traversing each item in the collection
   public Boolean hasNext(){
      return m_index < fileData.length() ? true : false;
   }
   
   //To return the next item in the collection
   public String next(){    
      
      Integer key = fileData.indexOf(m_rowDelimiter, m_index);
      system.debug('Key'+key);
      if (key == -1)
      key = fileData.length();
      system.debug('Key'+key);
      system.debug('**file length**'+fileData.length());
      
      String row = fileData.subString(m_index, key);
      m_index = key + 1;
      system.debug('Key'+key);
      //returning row;
      return row;
      
   }
   
   //Creating reference to the iterator 
   public Iterator<String> Iterator(){
      return this;  
   }       
       
                
}