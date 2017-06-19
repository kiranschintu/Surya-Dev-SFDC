public class DisplayAccountLTNG{
   @AuraEnabled
  public static Account getAccount(){
       return [SELECT Id, name, industry, Type  FROM Account  limit 1];
   }   
}