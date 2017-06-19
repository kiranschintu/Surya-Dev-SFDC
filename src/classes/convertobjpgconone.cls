global class convertobjpgconone {
    
    //Opportunity newOpp;
    //public Account acc;
    //public Contact con;
    
    /*public convertobjpgcon(ApexPages.StandardController controller) {
        this.CONTROL = controller;
    }*/
    
    webservice static  void doCreateOpportunityone( string id ) {
    
    //string x = id;
    Opportunity newOpp = new Opportunity();
    //acc = new Account();
    //con = new Contact();
    ConvertObj__c prospect = [select Id, Name, Company__c, Status__c from ConvertObj__c where id =: id];
    // add your field mappings here
   // acc.Name = prospect.Company__c;
    
    //insert acc;
    
   // con.Lastname = prospect.Name;
   // con.Accounid = acc.id;
    
   // insert con;
    newOpp.Name = prospect.Name;
    newOpp.CloseDate = Date.today();
    newOpp.StageName = prospect.Status__c;
    //newOpp.Account = new Account(Name = prospect.Company__c);
   // newOpp.Accountid = acc.id;
   // newOpp.Contactid = con.id;
    insert newOpp;
    
    //con.lastname = prospect.Name;
    // etc.
    
    if (newOpp.id != null){
        Delete prospect;
    }
    /*pageReference p = new pageReference('/' + newOpp.id);
    p.setRedirect(true);
    return p;*/
     }

}