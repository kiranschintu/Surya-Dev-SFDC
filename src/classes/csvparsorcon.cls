public with sharing class csvparsorcon {
    
    public String nameFile{get;set;}
    //Retrieve Content from the CSV File
    public transient Blob csvFile{get;set;}
    List<List<String>> allFields;
    
    public pagereference executebatch(){
      
     try{ if(csvFile!=null)
        {
        
        nameFile=csvFile.toString();
        
        parseCSV(nameFile,true);
        
        // Convert the Blob content to String
        //nameFile= nameFile.trim();
        //nameFile= nameFile.replaceAll('(\\s+)', ' ');
        
   
        }
        else
        {
        ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a record to upload...!');
            ApexPages.addMessage(errormsg);
        }
        List<Account> acc = new LIst<Account>();
        for(List<String> ss:allFields){
            for(string s:ss){
            Account a = new Account();
            a.name = 's';
            acc.add(a);
            }
        insert acc;    
        }
        
      
      nameFile=Null;
      }catch(exception e){
      ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Limit Exception');
            ApexPages.addMessage(errormsg);
      }
      return null;
  }
    
    
    public List<List<String>> parseCSV(String contents,Boolean skipHeaders) {
    allFields = new List<List<String>>();

    // replace instances where a double quote begins a field containing a comma
    // in this case you get a double quote followed by a doubled double quote
    // do this for beginning and end of a field
    contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
    // now replace all remaining double quotes - we do this so that we can reconstruct
    // fields with commas inside assuming they begin and end with a double quote
    contents = contents.replaceAll('""','DBLQT');
    // we are not attempting to handle fields with a newline inside of them
    // so, split on newline to get the spreadsheet rows
    List<String> lines = new List<String>();
    try {
        lines = contents.split('\n');
    } catch (System.ListException e) {
        System.debug('Limits exceeded?' + e.getMessage());
    }
    Integer num = 0;
    for(String line : lines) {
        // check for blank CSV lines (only commas)
        if (line.replaceAll(',','').trim().length() == 0) break;
        
        List<String> fields = line.split(',');  
        List<String> cleanFields = new List<String>();
        String compositeField;
        Boolean makeCompositeField = false;
        for(String field : fields) {
            if (field.startsWith('"') && field.endsWith('"')) {
                cleanFields.add(field.replaceAll('DBLQT','"'));
            } else if (field.startsWith('"')) {
                makeCompositeField = true;
                compositeField = field;
            } else if (field.endsWith('"')) {
                compositeField += ',' + field;
                cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                makeCompositeField = false;
            } else if (makeCompositeField) {
                compositeField +=  ',' + field;
            } else {
                cleanFields.add(field.replaceAll('DBLQT','"'));
            }
        }
        
        allFields.add(cleanFields);
    }
    if (skipHeaders) allFields.remove(0);
    return allFields;       
}

}