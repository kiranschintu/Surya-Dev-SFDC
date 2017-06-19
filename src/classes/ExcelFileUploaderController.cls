public with sharing class ExcelFileUploaderController {
    public string fileData{get;set;}
    public ExcelFileUploaderController(){
    
    }
    
    public void doInsertData(){
        system.debug('Data>>>'+fileData);
        String jsnStr = fileData;
        List<Tax_Return__c> taxReturns = new List<Tax_Return__c>();
        JSONParser parser = JSON.createParser(jsnStr);
        String startAray;
        while (parser.nextToken() != null) {
            // Start at the array
            if(parser.getCurrentToken()==JSONToken.FIELD_NAME){
            startAray = parser.getText();
                system.debug('startAray'+startAray);
            }
            system.debug('*&^%$'+parser.getText());
                if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                    system.debug('Start>>>'+parser.getCurrentToken()+'%%%'+parser.getText());
                    Tax_Return__c taxReturn = new Tax_Return__c();
                    while (parser.nextToken() != null) {
                        if (parser.getCurrentToken() == JSONToken.END_ARRAY) {
                        system.debug('END Array');
                        startAray=null;
                            break;
                        }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && parser.getText()=='municipality name'){
                            parser.nextToken();
                            taxReturn.Name = parser.getText();
                            system.debug('while End>>'+parser.getText());
                        }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && parser.getText()=='county'){
                            parser.nextToken();
                            taxReturn.county__c = parser.getText();
                            system.debug('while End>>'+parser.getText());
                        }
                        else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && parser.getText()=='number'){
                            parser.nextToken();
                            taxReturn.Number__c = parser.getText();
                            system.debug('while End>>'+parser.getText());
                        }
                        else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && parser.getText()=='payment amount'){
                            parser.nextToken();
                            taxReturn.Payment_Amount__c = parser.getText();
                            system.debug('while End>>'+parser.getText());
                        }
                        else if(parser.getCurrentToken() == JSONToken.END_OBJECT){
                            system.debug('ENd Object>>'+taxReturn);
                            taxReturn.Sheet_Name__c = startAray;
                            taxReturns.add(taxReturn);
                            taxReturn = new Tax_Return__c();
                        }
                    }
                }
        }
        
        if(!taxReturns.isEmpty()){
            insert taxReturns;
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info,'Records inserted successfully');
            ApexPages.addMessage(msg);
        }
    }
}