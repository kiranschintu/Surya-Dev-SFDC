global with sharing class ReadAndPopulateBatch implements Database.batchable<String>, Database.Stateful
{
   private String m_csvFile;
   private Integer m_startRow;
   //private CSVParser m_parser;
   private static final Integer SCOPE_SIZE = 100;
   public ReadAndPopulateBatch(){}
   public static ID run(){
   return null;
   }
   global Iterable<String> start(Database.batchableContext batchableContext)
   { 
       return null;
       //return new CSVIterator(m_csvFile, m_parser.crlf);
   }
   global void execute(Database.BatchableContext batchableContext, List<String> scope)  
   {
       //TODO: Create a map with the column name and the position.
       String csvFile = '';
       for(String row : scope)
       {
          //csvFile += row + m_parser.crlf;
       }
       //List<List<String>> csvLines = CSVReader.readCSVFile(csvFile,m_parser);
       //TODO: csvLines contains a List with the values of the CSV file.
       //These information will be used to create a custom object to
       //process it.
   }
   global void finish(Database.BatchableContext batchableContext){}
}