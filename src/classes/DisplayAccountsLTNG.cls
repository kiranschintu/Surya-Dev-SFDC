public class DisplayAccountsLTNG{
   @AuraEnabled
   public static List<Account> getAccounts(){
       return [SELECT Id,name,industry,Type FROM Account limit 10];
   }   
}