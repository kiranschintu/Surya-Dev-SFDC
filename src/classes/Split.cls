public with sharing class Split {
  
  static String color = 'blue@grey.com';
  String color1 = color.split('\\@')[1];
  public List<Account> acc;
    public static void dosub(){
        String s=color.substring(0, 4);
        system.debug('Sub String :'+s);
    }
  public List<Account> getRecords(){
      //acc = [select id,name,Member_Status__c from Account where Company_Email__c like :'%'+color1];
      return acc;
  }
  Public String getname(){
      return color1;
  }
}