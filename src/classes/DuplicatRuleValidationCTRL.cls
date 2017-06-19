public class DuplicatRuleValidationCTRL {
    public Lead lead{get;set;}
    // Initialize a list to hold any duplicate records
    public List<sObject> duplicateRecords{get;set;}
    
    // Define variable that’s true if there are duplicate records
    public boolean hasDuplicateResult{get;set;}
    
    public DuplicatRuleValidationCTRL(){
        lead = new Lead();
        // Initialize empty list of potential duplicate records
        duplicateRecords = new List<sObject>();
        hasDuplicateResult = false;
    }
    
    public void doSome(){
        Database.SaveResult saveResult = Database.insert(lead, false);
        if (!saveResult.isSuccess()) {
            for (Database.Error error : saveResult.getErrors()) {
                // If there are duplicates, an error occurs
                // Process only duplicates and not other errors 
                //   (e.g., validation errors)
                if (error instanceof Database.DuplicateError) {
                    // Handle the duplicate error by first casting it as a 
                    //   DuplicateError class
                    // This lets you use methods of that class 
                    //  (e.g., getDuplicateResult())
                    Database.DuplicateError duplicateError = 
                            (Database.DuplicateError)error;
                    Datacloud.DuplicateResult duplicateResult = 
                            duplicateError.getDuplicateResult();
                    
                    // Display duplicate error message as defined in the duplicate rule
                    ApexPages.Message errorMessage = new ApexPages.Message(
                               ApexPages.Severity.ERROR, 'Duplicate Error: ' +duplicateResult.isAllowSave()+'>>>'+ 
                            duplicateResult.getErrorMessage()+'Result>>>');
                    ApexPages.addMessage(errorMessage);
                    
                    // Get duplicate records
                    this.duplicateRecords = new List<sObject>();

                    // Return only match results of matching rules that 
                    //  find duplicate records
                    Datacloud.MatchResult[] matchResults = 
                            duplicateResult.getMatchResults();

                    // Just grab first match result (which contains the 
                    //   duplicate record found and other match info)
                    Datacloud.MatchResult matchResult = matchResults[0];

                    Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();

                    // Add matched record to the duplicate records variable
                    for (Datacloud.MatchRecord matchRecord : matchRecords) {
                        System.debug('MatchRecord: ' + matchRecord.getRecord());
                        this.duplicateRecords.add(matchRecord.getRecord());
                    }
                    this.hasDuplicateResult = !this.duplicateRecords.isEmpty();
                }
            }
            
        }
    }
    
    public void doSome1(){
        Database.SaveResult saveResult = Database.insert(lead, false);
        if (!saveResult.isSuccess()) {
            for (Database.Error error : saveResult.getErrors()) {
                // If there are duplicates, an error occurs
                // Process only duplicates and not other errors 
                //   (e.g., validation errors)
                if (error instanceof Database.DuplicateError) {
                    // Handle the duplicate error by first casting it as a 
                    //   DuplicateError class
                    // This lets you use methods of that class 
                    //  (e.g., getDuplicateResult())
                    Database.DuplicateError duplicateError = 
                            (Database.DuplicateError)error;
                    Datacloud.DuplicateResult duplicateResult = 
                            duplicateError.getDuplicateResult();
                    

                    // Display duplicate error message as defined in the duplicate rule
                    ApexPages.Message errorMessage = new ApexPages.Message(
                            ApexPages.Severity.ERROR, 'Duplicate Error: ' +duplicateResult.isAllowSave()+'>>>'+ 
                            duplicateResult.getErrorMessage()+'Result>>>');
                    ApexPages.addMessage(errorMessage);
                    
                    // Get duplicate records
                    this.duplicateRecords = new List<sObject>();

                    // Return only match results of matching rules that 
                    //  find duplicate records
                    Datacloud.MatchResult[] matchResults = 
                            duplicateResult.getMatchResults();

                    // Just grab first match result (which contains the 
                    //   duplicate record found and other match info)
                    Datacloud.MatchResult matchResult = matchResults[0];

                    Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();
                    
                    // Add matched record to the duplicate records variable
                    for (Datacloud.MatchRecord matchRecord : matchRecords) {
                        System.debug('MatchRecord: ' + matchRecord.getRecord());
                        this.duplicateRecords.add(matchRecord.getRecord());
                    }
                    this.hasDuplicateResult = !this.duplicateRecords.isEmpty();
                }
            }
            
        }
        
    }
}