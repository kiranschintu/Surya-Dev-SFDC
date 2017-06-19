public with sharing class UpdateAccountAsVeteran{
    public static void makeAccVeteran(List<Contact> contacts,List<Contact> oldContacts,Boolean isInsert,Boolean isUpdate,Boolean isDelete){
        Map<Id, List<Contact>> AcctContactList = new Map<Id, List<Contact>>();
    Set<Id> AcctIds = new Set<Id>();    
    List<Account> AcctList = new List<Account>();
    List<Contact> ConList = new List<Contact>();
    
    if(isInsert || isUPdate) {
        for(Contact Con : contacts) {
            if(String.isNotBlank(Con.AccountId)){
                AcctIds.add(Con.AccountId);  
            }   
        }  
    }
    
    if(isDelete) {
        for(Contact Con : oldContacts) {
            AcctIds.add(Con.AccountId);     
        }  
    }           
    
    if(AcctIds.size() > 0){
        ConList = [SELECT Id, AccountId FROM Contact WHERE AccountId IN : AcctIds AND Contact_Type__c='Lead Owner'];
        
        for(Contact Con : ConList) {
            if(!AcctContactList.containsKey(Con.AccountId)){
                AcctContactList.put(Con.AccountId, new List<Contact>());
            }
            AcctContactList.get(Con.AccountId).add(Con);      
        }                           
        
        System.debug('Account Id and Contact List Map is ' + AcctContactList);
        AcctList = [SELECT Is_Veteran_Verified__c FROM Account WHERE Id IN : AcctIds];
        
        for(Account Acc : AcctList) {
            List<Contact> ContList = new List<Contact>();
            ContList = AcctContactList.get(Acc.Id)!=null ? AcctContactList.get(Acc.Id) : new List<Contact>();
            Acc.Is_Veteran_Verified__c = ContList.size()!=0?true:false;
        }    
        
        System.debug('Account List is ' + AcctList);
        update AcctList;    
    }
}
}