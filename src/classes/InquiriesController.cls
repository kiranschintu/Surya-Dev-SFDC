public class InquiriesController {
    @AuraEnabled
    public static List<Inquiry__c> AllEmails() {
        return [SELECT id,name,dhr__Name__c,dhr__Email__c,dhr__Qualified__c FROM Inquiry__c where dhr__Qualified__c!=true];
    }
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense){
        upsert expense;
        return expense;
    }
}