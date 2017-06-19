public class convertobjpgcon1 {
    
    public ConvertObj__c conver;
    public Opportunity newOpp;
    public Account acc;
    public Contact con;
    public OpportunityContactRole ocr;
    public Task tak;
    //public ApexPages.StandardController CONTROL;
    public String sub{get;set;}
    public String stat{get;set;}
    public String prior{get;set;}
    public String des{get;set;}
    public Boolean check{get;set;}
    public Boolean disable{get;set;}
    public Boolean sendownemail{get;set;}
    
    public void doDisable(){
        if(check == true){
            disable = true;
        }else
        disable = false;
    }
    
    public convertobjpgcon1(ApexPages.StandardController controller) {
        this.conver = (ConvertObj__c)controller.getRecord();
    }
    
    public pageReference doCreateOpportunity() {
    
    newOpp = new Opportunity();
    acc = new Account();
    con = new Contact();
    ocr = new OpportunityContactRole();
    tak = new Task();
    ConvertObj__c prospect = [select Id, Name, Company__c, Status__c from ConvertObj__c where id = :conver.id];
    // add your field mappings here
    acc.Name = prospect.Company__c;
    insert acc;
    
    con.Lastname = prospect.Name;
    con.Accountid = acc.id;
    insert con;
    
    if(check == FALSE){
    newOpp.Name = prospect.Name;
    newOpp.CloseDate = Date.today();
    newOpp.StageName = prospect.Status__c;
    newOpp.Accountid = acc.id;
    insert newOpp;
    
    ocr.Role = 'Business User';
    ocr.ISPRIMARY = TRUE;
    ocr.OPPORTUNITYID = newOpp.id;
    ocr.CONTACTID = con.id;
    insert ocr;   
    }
    
    tak.WhatID = acc.id;
    tak.WhoID = con.id;
    tak.Subject = sub;
    tak.Status = stat;
    tak.Priority = prior;
    tak.Description = des;
    insert tak;
     
    if (newOpp.id != null || check == true){
        Delete prospect;
    }
    if(sendownemail == True){
        //create a mail object to send a single email.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        //set the email properties
        String s = conver.owner.email;
        String[] toAddresses = new String[] {s};
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('SF.com Email Agent');
        mail.setSubject('A new reminder');
        mail.setHtmlBody('an object with ID= is just clicked on.');

//send the email
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );

    }
    
    pageReference p = new pageReference('/' + acc.id);
    p.setRedirect(true);
    return p;
    
     }
     public pagereference docancel(){
         ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'Error'+newOpp.Owner.email);
             ApexPages.addMessage(noMobileMsg);
             return null;
     }
}