public class PageBlockTableEnhancerADVDemo_Con {
    public List<Account> getAccouts(){
        return [select id,name,phone,Account_Number__c from Account where Account_Number__c <100 limit 100];
    }
}