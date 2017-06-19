public class ContactCreationAndAssociation {
    public Constituent_Group__c groupcust{get;set;}
    public Contact con{get;set;}
    public boolean isDuplicate{get;set;}
    public ContactCreationAndAssociation(ApexPages.StandardController controller){
       groupcust = (Constituent_Group__c)controller.getRecord();
       con = new Contact();
       isDuplicate=false;
    }
    public PageReference SaveData(){
        Map<String,Contact> existingEmailsMap = existingContacts();
        
        if(existingEmailsMap.containsKey(con.Email.toLowerCase())){
            isDuplicate=true;
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Duplicate Email found.');
            ApexPages.addMessage(msg);
            
            return null;
        }else{
            isDuplicate=false;
            insert con;
            
            //insert junction record
            ConstituentGroup_Constituent_Junction__c ccjun = new ConstituentGroup_Constituent_Junction__c();
            ccjun.Constituent_Group__c = groupcust.id;
            ccjun.Contact__c = con.id;
            
            insert ccjun;
            
            PageReference pg = new PageReference('/'+groupcust.id);
            pg.setRedirect(true);
            return pg;
        }
    }
    
    public PageReference SaveDataWithNoDup(){
        Map<String,Contact> existingEmailsMap = existingContacts();
        PageReference pg;
        if(existingEmailsMap.containsKey(con.Email.toLowerCase())){
            
            //insert junction record
            ConstituentGroup_Constituent_Junction__c ccjun = new ConstituentGroup_Constituent_Junction__c();
            ccjun.Constituent_Group__c = groupcust.id;
            ccjun.Contact__c = existingEmailsMap.get(con.Email.toLowerCase()).id;
            
            insert ccjun;
            
            pg = new PageReference('/'+groupcust.id);
            pg.setRedirect(true);
        }
        return pg;
    }
    
    public Map<String,Contact> existingContacts(){
        Map<String,Contact> existngEmails = new Map<String,Contact>();
        for(Contact con:[select id,Email from Contact where Email!=null limit 100]){
            existngEmails.put(con.Email.toLowerCase(),con);
        }
        return existngEmails;
    }
    
    public PageReference cancel(){
        return Apexpages.currentPage();
    }
}