public with sharing class insertaccountcon {
    public Account acc{get;set;}
    
    public insertaccountcon(ApexPages.StandardController controller) {
        acc = new Account();
        acc.RecordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
    }

    public pageReference doinsert(){
        insert acc;
        
        return null;
    }
}