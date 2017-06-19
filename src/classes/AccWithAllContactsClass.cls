public with sharing class AccWithAllContactsClass {
    List<Account> lstaccount = new List<Account>();
    List<contact> lstcontacts = new List<contact>();
    public List<contact> getConRecords() {
       lstcontacts.clear();
       accIds.clear();
       lstaccount.clear();

       system.debug('****AccNameTextValue is *****'+accName);
       lstaccount=[select id,name from Account where name=:accName];
       for(Integer i=0;i<lstaccount.size();i++)
       {
           accIds.add(lstaccount[i].Id);
       }
       
        lstcontacts =[select id,name,accountId from contact where 
accountid in : accIds];
        system.debug('**** List of Contacts for Test is ***'+lstcontacts);
        return lstcontacts;
    }
    
    set<string> accIds = new set<string>();
    public pagereference showContacts() {
       return null;
        
    }
    public String accName { get; set; }
}