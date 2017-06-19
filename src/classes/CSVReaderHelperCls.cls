public with sharing class CSVReaderHelperCls {
    public Blob csvFile{get;set;}
    public string fileName{get;set;}
    
    public void importFile(){
        //String csvBody = EncodingUtil.base64Encode(csvFile);
        String csvBody = csvFile.toString();
        /*List<List<string>> csvData = CSVReader.Parse(csvBody);
        system.debug('File Data>>>'+csvData);
        system.debug('File Data Sieze>>>'+csvData.size());
        */
        csvFile=null;
    }
}