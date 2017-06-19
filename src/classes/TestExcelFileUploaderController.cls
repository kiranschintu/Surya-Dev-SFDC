@isTest
Private Class TestExcelFileUploaderController{
    private static testMethod void unitTest(){
        
        String strdata = '{"Sheet1":[{'
                              +'"Municipality Name": "ABERDEEN",'
                              +'"County": "8",'
                              +'"Number": "08401005",'
                              +'"Payment Amount": "$100,000"'
                            +'},{'
                              +'"Municipality Name": "ADA ",'
                              +'"County": "33",'
                              +'"Number": "33401005",'
                              +'"Payment Amount": "$50,000"'
                            +'},{'
                              +'"Municipality Name": "ADAMSVILLE",'
                              +'"County": "60",'
                              +'"Number": "60401005",'
                              +'"Payment Amount": "$0"'
                            +'}]}';
    
    
    ExcelFileUploaderController ob = new ExcelFileUploaderController();
    ob.fileData = strdata;
    ob.doInsertData();
    }
}