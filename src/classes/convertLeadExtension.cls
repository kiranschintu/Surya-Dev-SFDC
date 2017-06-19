public class convertLeadExtension {     
    
//Properties
    
    
//sObjects
    
//Lead
    public Lead lead { 
get; 
private set; 
}
    
    
//Account
    
public Account account {
        
get {
            
if (account == null) account = new Account(Account_Intergraph_Line_of_Business__c = lead.Line_of_Business__c);
            
return account;
        
}
        
public set;
    
}
    
    
public Account contactAccount { 
get; 
set; 
}
    
    
//Contact
    
public Contact contact {
        
get 
{
            
if (contact == null) contact = new Contact();
            
return contact;
        
}
        
public set;
    
}
    
    
//Opportunity
    
public Opportunity opportunity {
        
get {
            
if (opportunity == null) opportunity = new Opportunity(Opportunity_Intergaph_Line_of_Business__c = lead.Line_of_Business__c);
            
return opportunity;
        
}
        
public set;
    
}
      
    
//Task
    
public Task task {
        
get {
            
if (task == null) task = new Task();
            
return task;
        
}
        
public set;
    
}
    
    
//User
    
public User user { 
        
get {
            
if (user == null)
                
user = [SELECT UserRole.Name FROM User WHERE Id = : UserInfo.getUserId()];
            
return user;
        
}
        
set; 
    
}
    
    
//Convert Lead page form fields     
    
public String recordOwner { 
get; 
set; 
}
            
    
public Boolean sendEmail { 
get; 
set; 
}
    
    
public String accountCreate { 
get; 
set; 
}
    
    
public String parentAccount { get; set; }
    
    
public List<SelectOption> accountCreateOptions {
        
get {
            
if (accountCreateOptions == null) 
{
                
accountCreateOptions = new List<SelectOption>();
                
                
accountCreateOptions.add(new SelectOption('','--None--'));
                
accountCreateOptions.add(new SelectOption('createNew','Create New Account: ' + lead.Company));
                
                String tempCompanyString = lead.Company.replaceAll('[\\.,;]','');
                
if (tempCompanyString.replaceAll('(?i)(co$|$the|inc$|incorporated$|llc$)','') != '')
                    
tempCompanyString = tempCompanyString.replaceAll('(?i)(co$|$the|inc$|incorporated$|llc$)','');
               
 try {  
                    

for (Account acct : [SELECT Id, Name FROM Account WHERE name LIKE : '%' + tempCompanyString + '%' LIMIT 998])
                        
accountCreateOptions.add(new SelectOption(acct.Id,'Attach to Existing: ' + acct.Name));
               
 }
                
catch(Exception e){ 
System.debug(e.getMessage()); 
}
            
}
            
return accountCreateOptions;
        
}
        
        
protected set;
    
}
    
    
public String opportunityName { get; set; }
    
    
public Boolean doNotCreateOpportunity { 
        
get {
            
if (doNotCreateOpportunity == null)
                
doNotCreateOpportunity = false;
            
return doNotCreateOpportunity;
        
}
        
set; 
    
}
        
    
public String convertedStatus { get; set; }
    
    
public List<SelectOption> convertedStatusOptions {
        
get {
            
if (convertedStatusOptions == null) {
                
convertedStatusOptions = new List<SelectOption>();
for (LeadStatus leadStatus : [SELECT MasterLabel FROM LeadStatus WHERE IsConverted = True])
                    convertedStatusOptions.add(new SelectOption(leadStatus.MasterLabel, leadStatus.MasterLabel));
                
                //convertedStatusOptions.add(new SelectOption('Qualified','Qualified'));
            }
            
return convertedStatusOptions;
        
}
        
        
protected set;
    
}
    
    
public List<SelectOption> epc { get; protected set; }
    
    
public List<SelectOption> oo { get; protected set; }
    
   
public List<SelectOption> both { get; protected set; }
    
    
public List<SelectOption> other { get; protected set; }
    
    
//Hidden input fields used by Salesforce lookups
    
public String ownerId_lkid {
        
get {
            
if (ownerId_lkid == null) ownerId_lkid = UserInfo.getUserId();
            
return ownerId_lkid;
        }
        
        
set;
    
}
    
    
public String ownerId_lkold {
        
get {
            
if (ownerId_lkold == null) ownerId_lkold = UserInfo.getFirstName() + ' ' + UserInfo.getLastName();
            
return ownerId_lkold;
        
}
        
        
set;
    
}
    
    
public String ownerId_lktp {
        
get {
            
return 'StandardUserLookup';
        
}
        
        
set;
    
}
    
    
public String ownerId_lspf {
        
get {
            
if (ownerId_lspf == null) ownerId_lspf = '0';
            
return ownerId_lspf;
        }
        
        
set;
    
}
    
    
public String ownerId_mod {
        
get {
            
if (ownerId_mod == null) ownerId_mod = '0';
            
return ownerId_mod;
        
}
        
        
set;
    
}
    
    
public String acclkId {
        
get 
{
            
if (acclkId == null) acclkId = '';
            
return acclkId;
        
}
        
        
set;
    
}
    
    
public String acclkId_lkid {
        
get 
{
            
if (acclkid_lkid == null) acclkid_lkid = '000000000000000';
            
return acclkid_lkid;
        
}
        
        
set;
    
}
    
    
public String acclkId_lkold {
        
get {
            
if (acclkid_lkold == null) acclkid_lkold = 'null';
            
return acclkid_lkold;
        
}
        
        
set;
    
}
    
    
public String acclkId_lktp {
        
get {
            
if (acclkid_lktp == null) acclkid_lktp = '001';
            
return acclkid_lktp;
        
}
        
        
set;
    
}
    
    
public String acclkId_lspf {
        
get 
{
            
if (acclkid_lspf == null) acclkid_lspf = '0';
            
return acclkid_lspf;
        
}
        
        
set;
    
}
    
    
public String acclkId_mod {
        
get 
{
            
if (acclkid_mod == null) acclkid_mod = '0';
            
return acclkid_mod;
        }
        
        
set;
    
}
    
    
public String parentAccount_lkid {
        
get {
            
if (parentAccount_lkid == null) parentAccount_lkid = '000000000000000';
            
return parentAccount_lkid;
        
}
        
        
set;
    
}
    
    
public String parentAccount_lkold {
        
get {
            
if (parentAccount_lkold == null) parentAccount_lkold = 'null';
            
return parentAccount_lkold;
        
}
        
        
set;
    
}
    
    
public String parentAccount_lktp {
        
get {
            
if (parentAccount_lktp == null) parentAccount_lktp = '001';
            
return parentAccount_lktp;
        
}
        
        
set;
    
}
    
    
public String parentAccount_lspf {
        
get {
            
if (parentAccount_lspf == null) parentAccount_lspf = '0';
            
return parentAccount_lspf;
        }
        
        
set;
    
}
    
    
public String parentAccount_mod {
        
get 
{
            
if (parentAccount_mod == null) parentAccount_mod = '0';
            
return parentAccount_mod;
        
}
        
        
set;
    
}
    
//End lookup fields
    
    
public String newAccountCreateOptions { get; set; }
        
    
//Convert Lead Contact page form fields
    public String contactCreate { get; set; }
    
    
public List<SelectOption> contactCreateOptions {
        
get {
            
if (contactCreateOptions == null) {
                
contactCreateOptions = new List<SelectOption>();
                
                
contactCreateOptions.add(new SelectOption('','--None--'));
                
contactCreateOptions.add(new SelectOption('createNew','Create New Contact: ' + lead.Name));
                

for (Contact contact : [SELECT Id, Name FROM Contact WHERE AccountId = : accountCreate])
                    contactCreateOptions.add(new SelectOption(contact.Id,'Attach to Existing: ' + contact.Name));
            }
            
return contactCreateOptions;
        
}
        
        
protected set;
    
}
    
    
public Boolean overwriteSource { get; set; }
    
    
//Misc
    
public Boolean loadPage { get; public set; }
    
    
// The extension constructor initializes the private member
    
// variable lead by using the getRecord method from the standard
    
// controller.
    
public convertLeadExtension(ApexPages.StandardController stdController) {
        
lead = (Lead)stdController.getRecord();
        
        
Lead tempLead = [SELECT LastName, Country_Code__c, Company, Status,
 LeadSource, Line_of_Business__c, Industry, Email,
            Phone, Street, City, State, PostalCode FROM Lead WHERE Id = : lead.Id];
        
        
//Check for proper contact information. If not present, do not load entire page
        
if (tempLead.Email == null && tempLead.Phone == null && (tempLead.Street == null && tempLead.City == null && tempLead.State == null && tempLead.PostalCode == null)) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because it contains no valid contact information (Email, Phone Number, or Address) for the Contact');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        }
        
// Required field checks
        
else if(tempLead.LastName == null) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because required information (Last Name) is missing.');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        
}
        

        
else if(tempLead.Company == null) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because required information (Company) is missing.');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        
}
        
else if(tempLead.Status == null) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because required information (Lead Status) is missing.');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        
}
        
else if(tempLead.LeadSource == null) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because required information (Lead Source) is missing.');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        
}
        
else if(tempLead.Line_of_Business__c == null) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because required information (Line of Business) is missing.');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        
}
        
else if(tempLead.Industry == null) {
            
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Lead cannot be converted because required information (Industry) is missing.');
            
ApexPages.addMessage(msg);
            
loadPage = false;
        
}
        
      
else {       
            
loadPage = true;
            
doNotCreateOpportunity = true;
            
            
ID initialOwnerID = [SELECT OwnerId FROM Lead WHERE Id = : lead.Id].OwnerId;
            
            
User owner;
            
try {
                
owner = [SELECT FirstName, LastName FROM User WHERE Id = : initialOwnerId AND IsActive = true];
            
}
            
catch (Exception ex) {
                
owner = [SELECT FirstName, LastName FROM User WHERE Id = : UserInfo.getUserId() AND IsActive = true];
            
}
            
recordOwner = owner.FirstName + ' ' + owner.LastName;
                                 
            
contact.Email = tempLead.Email;
            
contact.MailingStreet = lead.Street;
            
contact.MailingCity = lead.City;
            
contact.MailingState = lead.State;
            
contact.MailingPostalCode = lead.PostalCode;
            
contact.MailingCountry = lead.Country_Code__c;
        
}     
    
}
    
    
public void parseNewAccountCreateOptions() {
        
if (newAccountCreateOptions != null) {
            
String[] newOption = newAccountCreateOptions.split(',');
            
String accountId = newOption[0];
            
String accountName = newOption[1];
            
accountCreateOptions.add(new SelectOption(accountId, 'Attach to Existing: ' + accountName));
            
newAccountCreateOptions = null;
        
}
    
}
        
    
public PageReference convert() {
        
//Check for input errors
        
List<String> errorMessages = checkForErrors();
        
if (!errorMessages.isEmpty()) {
            
//Process exceptions here
            
for (Integer i = 0; i < errorMessages.size(); i++) {
                
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessages.get(i)));
            
}
            
return ApexPages.currentPage();
        
}
                
        
if (accountCreate != 'createNew') {
            
contactAccount = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                BillingCountry,Industry, Type, 
                                 RecordTypeId FROM Account WHERE Id = : accountCreate];
            
return Page.convertLeadContact;
        }
        
else {
            
System.debug('Lead Id: ' + lead.Id);
            
System.debug('Owner Id: ' + [SELECT Id FROM User WHERE Name = : recordOwner AND IsActive = true LIMIT 1].Id);
            System.debug('Converted Status: ' + convertedStatus);
            
            
Database.LeadConvert leadConvert = new database.LeadConvert();
            
leadConvert.setLeadId(lead.Id);
            
leadConvert.setOwnerId([SELECT Id FROM User WHERE Name = : recordOwner AND IsActive = true LIMIT 1].Id);
                leadConvert.setConvertedStatus(convertedStatus);
            
            
leadConvert.setSendNotificationEmail(sendEmail);
            
            
Savepoint beforeConvert = Database.setSavePoint();
            
try {
                
//If user chooses to add Task info, insert new Task
                
try {
                    
if (task.Status != null || task.Priority != null || task.ActivityDate != null || task.Subject != null || task.Description != null || task.Status != null || task.ReminderDateTime != null)
                        
insert task;
                
}
                
catch (DmlException ex) { 
                    
for (Integer i = 0; i < ex.getNumDml(); i++) {
                        
// Process exception here
                        
System.debug('Error: ' + ex.getDmlMessage(i));
                        
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
    
                }
                    
return ApexPages.currentPage();
                
}
                
//Insert new account
                
try {
                    
account.Name = lead.Company;
                    
if (parentAccount_lkid != '000000000000000') account.ParentId = parentAccount_lkid;
                    
if (account.Account_Intergraph_Line_of_Business__c == 'PPM') account.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'PPM Standard Account Record Type'].Id;
                    
else account.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'SGI Standard Record Account Type'].Id;
                    //if (lead.Line_of_Business__c != null) account.Account_Intergraph_Line_of_Business__c = lead.Line_of_Business__c;
                    if (lead.Industry != null) account.Industry = lead.Industry;
                    

                    
            //if (account.Account_Category__c != null && lead.Line_of_Business__c == 'PPM') account.Account_Category__c = account.Account_Category__c;
                                    
                    insert account;
                
}
                
catch (DmlException ex) { 
                    
for (Integer i = 0; i < ex.getNumDml(); i++) {
                        
// Process exception here
                        
System.debug('Error: ' + ex.getDmlMessage(i));
                        
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                    
}
                    
Database.rollback(beforeConvert);
                    
task = task.clone(false);
                    
return ApexPages.currentPage();
                
}
                
                
//Insert new Contact
                
try {
                    
//Behind the scenes mapping
                    
contact.AccountId = account.Id;
                    
if (lead.FirstName != null) contact.FirstName = lead.FirstName;
                    
contact.LastName = lead.LastName;
                    

                  
                    
insert contact;
               
 }
                
catch (DmlException ex) { 
                    
for (Integer i = 0; i < ex.getNumDml(); i++) {
                        
// Process exception here
                        
System.debug('Error: ' + ex.getDmlMessage(i));
                        
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                    }
                    
Database.rollback(beforeConvert);
                    
task = task.clone(false);
                    
account = account.clone(false);
                    
return ApexPages.currentPage();
                
}
                
                
//If user decides to create Opportunity, insert new Opportunity
                
if (!doNotCreateOpportunity) {
                    try {
                        
if (opportunity.Opportunity_Intergaph_Line_of_Business__c == 'PPM') opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'PPM Opportunity'].Id;
                        
else if (opportunity.Opportunity_Intergaph_Line_of_Business__c == 'Public Safety') opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Public Safety'].Id;
                        
else if (opportunity.Opportunity_Intergaph_Line_of_Business__c == 'US Federal Solutions') opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Federal Solutions'].Id;
                        
else opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'SGI Opportunity'].Id;
                        opportunity.AccountId = account.Id;
                        
opportunity.Name = opportunityName;
                        
opportunity.StageName = 'Lead 0%';
                        
opportunity.CloseDate = Date.today();
                        
//opportunity.Opportunity_Intergaph_Line_of_Business__c = lead.Line_of_Business__c;
                        
                        insert opportunity;
                    
}
                    catch (DmlException ex) { 
                        
for (Integer i = 0; i < ex.getNumDml(); i++) {
                            
// Process exception here
                            
System.debug('Error: ' + ex.getDmlMessage(i));
                            
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                        }
                        
Database.rollback(beforeConvert);
                        
task = task.clone(false);
                        
account = account.clone(false);
                        
contact = contact.clone(false);
                        
return ApexPages.currentPage();
                    
}
                    
                    
try {
                        
OpportunityContactRole opportunityContactRole = new OpportunityContactRole(ContactId = contact.Id, OpportunityId = opportunity.Id);
                        
                        
insert opportunityContactRole;
                    
}
                    
catch (DmlException ex) { 
                        
for (Integer i = 0; i < ex.getNumDml(); i++) {
                            
// Process exception here
                            
System.debug('Error: ' + ex.getDmlMessage(i));
                            
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                        
}
                        
Database.rollback(beforeConvert);
                        
task = task.clone(false);
                        
account = account.clone(false);
                        
contact = contact.clone(false);
                        
return ApexPages.currentPage();
                    
}
                
}
                
                
System.debug('Account Id: ' + account.Id);
                
System.debug('Opportunity Id: ' + opportunity.Id);
                
System.debug('Contact Id: ' + contact.Id);
                
leadConvert.setAccountId(account.Id);
                
leadConvert.setContactId(contact.Id);
                
leadConvert.doNotCreateOpportunity = true;
        
                
Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert);
                
System.assert(leadConvertResult.isSuccess());
                                        
                //erase the Billing Address that the convert process has populated
                
                account.BillingCity = null;
                
account.BillingCountry = null;
                
account.BillingPostalCode = null;
                
account.BillingState = null;
                
account.BillingStreet = null;
                
update account;
                
                
if (account.Account_Intergraph_Line_of_Business__c == 'PPM') {
                    
PageReference accountPage = new PageReference('/' + leadConvertResult.getAccountId() + '/e');
                    accountPage.setRedirect(true);
                    
return accountPage;
                }
                
else {
                    
PageReference accountPage = new PageReference('/' + leadConvertResult.getAccountId());
                    accountPage.setRedirect(true);
                    
return accountPage;
                
}
            
}
            
catch (DmlException ex) { 
                
for (Integer i = 0; i < ex.getNumDml(); i++) {
                    
// Process exception here
                    
System.debug('Error: ' + ex.getDmlMessage(i));
                    
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                
}
                
Database.rollback(beforeConvert);
                
task = task.clone(false);
                
account = account.clone(false);
                
contact = contact.clone(false);
                
opportunity = opportunity.clone(false);
                
return ApexPages.currentPage();
            
}
            
catch (Exception ex) {
                
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
                
System.debug('Error: ' + ex.getMessage());
                
Database.rollback(beforeConvert);
                
task = task.clone(false);
                
account = account.clone(false);
                
contact = contact.clone(false);
                
opportunity = opportunity.clone(false);
                
return ApexPages.currentPage();
            
}
        
}
    
}
    
    
public PageReference convertAndAttachAccount() {
        
Database.LeadConvert leadConvert = new database.LeadConvert();
        
leadConvert.setLeadId(lead.Id);
        
leadConvert.setOwnerId([SELECT Id FROM User WHERE Name = : recordOwner AND IsActive = true LIMIT 1].Id);
        leadConvert.setConvertedStatus(convertedStatus);
        leadConvert.doNotCreateOpportunity = true;
        leadConvert.setSendNotificationEmail(sendEmail);
        leadConvert.setOverwriteLeadSource(overwriteSource);
        
        //variables to store old Billing Address to repopulate the fields with after convert
        String tempBillingStreet;
        String tempBillingCity;
        String tempBillingState;
        String tempBillingPostalCode;
        String tempBillingCountry;
        
        Savepoint beforeConvert = Database.setSavePoint();
        try {   
            //If user chooses to add Task info, insert new Task
            try {
                if (task.Status != null || task.Priority != null || task.ActivityDate != null || 
                     task.Subject != null || 
                    task.Description != null || task.Status != null || task.ReminderDateTime != null)
                    insert task;
            }
            catch (DmlException ex) { 
                for (Integer i = 0; i < ex.getNumDml(); i++) {
                    // Process exception here
                    System.debug('Error: ' + ex.getDmlMessage(i));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                }
                return Page.convertLead;
            }
            //Update the account the lead is attaching to
            try {
                if (parentAccount_lkid != '000000000000000') contactAccount.ParentId = parentAccount_lkid;
                system.debug(contactAccount.recordTypeId);
                if (account.Account_Intergraph_Line_of_Business__c == 'PPM') contactAccount.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'PPM Standard Account Record Type'].Id;
                else contactAccount.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'SGI Standard Record Account Type'].Id;
                system.debug(contactAccount.recordTypeId);
                if (account.Account_Intergraph_Line_of_Business__c != null) contactAccount.Account_Intergraph_Line_of_Business__c = account.Account_Intergraph_Line_of_Business__c;
                if (lead.Industry != null) contactAccount.Industry = lead.Industry;
                //only overwrite the physical address of any of the current fields are blank
                
                  //if (account.Category__c != null) acct.Category__c = account.Category__c;
                
                //grab current Billing Address info to use for repopulating the fields after convert
                tempBillingStreet = contactAccount.BillingStreet;
                tempBillingCity = contactAccount.BillingCity;
                tempBillingState = contactAccount.BillingState;
                tempBillingPostalCode = contactAccount.BillingPostalCode;
                tempBillingCountry = contactAccount.BillingCountry;
                                
                update contactAccount;
                leadConvert.setAccountId(contactAccount.Id);
            }
            catch (DmlException ex) { 
                for (Integer i = 0; i < ex.getNumDml(); i++) {
                    // Process exception here
                    System.debug('Error: ' + ex.getDmlMessage(i));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                }
                Database.rollback(beforeConvert);
                task = task.clone(false);
                return Page.convertLead;
            }
            
            //Insert new Contact
            try {
                if (contactCreate == 'createNew') {
                    //Behind the scenes mapping
                    contact.AccountId = contactAccount.Id;
                    if (lead.FirstName != null) contact.FirstName = lead.FirstName;
                    contact.LastName = lead.LastName;
                                        insert contact;
                    
                    leadConvert.setContactId(contact.Id);
                }
                else {
                    //Behind the scenes mapping
                    Contact tempContact = [SELECT Id, Department, MailingStreet, MailingCity, MailingPostalCode,
                        MailingState, MailingCountry, Email FROM Contact WHERE Id = : contactCreate];
                        
                    if (tempContact.MailingStreet == null || tempContact.MailingCity == null ||
                        tempContact.MailingPostalCode == null || tempContact.MailingState == null ||
                        tempContact.MailingCountry == null) {
                        tempContact.MailingStreet = contact.MailingStreet;
                        tempContact.MailingCity = contact.MailingCity;
                        tempContact.MailingPostalCode = contact.MailingPostalCode;
                        tempContact.MailingState = contact.MailingState;
                        tempContact.MailingCountry = contact.MailingCountry;
                    }
                    
                    if (tempContact.Email == null) tempContact.Email = contact.Email;
                    
                    update tempContact;
                    leadConvert.setContactId(tempContact.Id);
                }
            }
            catch (DmlException ex) { 
                for (Integer i = 0; i < ex.getNumDml(); i++) {
                    // Process exception here
                    System.debug('Error: ' + ex.getDmlMessage(i));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                }
                Database.rollback(beforeConvert);
                task = task.clone(false);
                return Page.convertLead;
            }
            
            //If user decides to create Opportunity, insert new Opportunity
            if (!doNotCreateOpportunity) {
                try {
                    if (opportunity.Opportunity_Intergaph_Line_of_Business__c == 'PPM') opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'PPM Opportunity'].Id;
                    else if (opportunity.Opportunity_Intergaph_Line_of_Business__c == 'Public Safety') opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Public Safety'].Id;
                    else if (opportunity.Opportunity_Intergaph_Line_of_Business__c == 'US Federal Solutions') opportunity.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Federal Solutions'].Id;
                    opportunity.AccountId = contactAccount.Id;
                    opportunity.Name = opportunityName;
                    opportunity.StageName = 'Lead 0%';
                    opportunity.CloseDate = Date.today();
                    //opportunity.Opportunity_Intergaph_Line_of_Business__c = lead.Line_of_Business__c;
                    
                    insert opportunity;
                }
                catch (DmlException ex) { 
                    for (Integer i = 0; i < ex.getNumDml(); i++) {
                        // Process exception here
                        System.debug('Error: ' + ex.getDmlMessage(i));
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                    }
                    Database.rollback(beforeConvert);
                    task = task.clone(false);
                    contact = contact.clone(false);
                    return Page.convertLead;
                }
                    
                try {
                    OpportunityContactRole opportunityContactRole = new OpportunityContactRole(ContactId = contact.Id, OpportunityId = opportunity.Id);
                    
                    insert opportunityContactRole;
                }
                catch (DmlException ex) { 
                    for (Integer i = 0; i < ex.getNumDml(); i++) {
                        // Process exception here
                        System.debug('Error: ' + ex.getDmlMessage(i));
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
                    }
                    Database.rollback(beforeConvert);
                    task = task.clone(false);
                    account = account.clone(false);
                    contact = contact.clone(false);
                    return ApexPages.currentPage();
                }
            }
                    
            Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert);
            System.assert(leadConvertResult.isSuccess());
            
            system.debug([SELECT RecordTypeId FROM Account WHERE Id = : leadConvertResult.getAccountId()].RecordTypeId);
            
            //update account after convert to revert Billing Address to what it was before
            contactAccount.BillingStreet = tempBillingStreet;
            contactAccount.BillingCity = tempBillingCity;
            contactAccount.BillingState = tempBillingState;
            contactAccount.BillingPostalCode = tempBillingPostalCode;
            contactAccount.BillingCountry = tempBillingCountry;
            update contactAccount;
            
            if (account.Account_Intergraph_Line_of_Business__c == 'PPM') {
                PageReference accountPage = new PageReference('/' + leadConvertResult.getAccountId() + '/e');
                accountPage.setRedirect(true);
                return accountPage;
            }
            else {
                PageReference accountPage = new PageReference('/' + leadConvertResult.getAccountId());
                accountPage.setRedirect(true);
                return accountPage;
            }
        }
        catch (DmlException ex) { 
            for (Integer i = 0; i < ex.getNumDml(); i++) {
                // Process exception here
                System.debug('Error: ' + ex.getDmlMessage(i));
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getDmlFieldNames(i) + ': ' + ex.getDmlMessage(i)));
            }
            Database.rollback(beforeConvert);
            task = task.clone(false);
            contact = contact.clone(false);
            opportunity = opportunity.clone(false);
            return ApexPages.currentPage();
        }
        catch (Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
            System.debug('Error: ' + ex.getMessage());
            Database.rollback(beforeConvert);
            task = task.clone(false);
            contact = contact.clone(false);
            opportunity = opportunity.clone(false);
            return ApexPages.currentPage();
        }
    }
    
    public List<String> checkForErrors() {
        List<String> errors = new List<String>();
        try{
            User temp = [SELECT Id FROM User WHERE Name = : recordOwner AND IsActive = true LIMIT 1];
        }
        catch (Exception ex) {
            errors.add('There is no active user in the system with the name specified for Record Owner.');
        }
        finally {
            if (accountCreate == null) {
                errors.add('You must select an Account Name.');
            }
            if (user.UserRole.Name.contains('Partner') && 
                parentAccount_lkid == '000000000000000') {
                errors.add('Partner users must choose a parent account. Use the magnifying glass icon to find and choose an Account.');
            }
            if (account.Account_Intergraph_Line_of_Business__c == null) {
                account.Account_Intergraph_Line_of_Business__c.addError('You must enter a value.');
            }
            
            
            if (lead.Street == null) {
                lead.Street.addError('You must enter a value.');
            }
            if (lead.City == null) {
                lead.City.addError('You must enter a value.');
            }
            if (lead.State == null) {
                lead.State.addError('You must enter a value.');
            }
            if (lead.PostalCode == null) {
                lead.PostalCode.addError('You must enter a value.');
            }
            
            
            if (!doNotCreateOpportunity && opportunityName == null) {
                errors.add('If creating an Opportunity, Opportunity Name must have a value.');
            }
            if (!doNotCreateOpportunity && opportunity.Opportunity_Intergaph_Line_of_Business__c == null) {
                opportunity.Opportunity_Intergaph_Line_of_Business__c.addError('You must enter a value.');
            }
            
            
           
        }
        return errors;
    }
}