Public class CaseEmailController{
    @AuraEnabled
    public static List<Case> allCases(){
        return [SELECT id,Subject,Description,CaseNumber from Case where subject!=null limit 5];
    }
}