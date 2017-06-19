public with sharing class Utility_RowIterator1 implements Iterator<List<String>>, Iterable<List<String>>
{
   private String m_Data;
   private Blob fileData;
   private Integer m_index = 0;
   private String m_rowDelimiter = '\n';
    
   public Utility_RowIterator1(blob fileData)
   {
      this.fileData = fileData;
      m_Data = fileData.toString();
   }
  
    
   public Boolean hasNext()
   {
       //return m_Data.length() > 1 ? true : false;
      return m_index < m_Data.length() ? true : false;
   }
   public List<String> next()
   {    
      Integer key = m_Data.indexOf(m_rowDelimiter, m_index);
       
      if (key == -1)
        key = m_Data.length();
             
      String row1 = m_Data.subString(m_index, key);
      m_index = key + 1;
      List<String> row = new List<String>();
      row.add(row1);
      return row;
   }
   public Iterator<List<String>> Iterator()
   {
      return this;  
   }
}