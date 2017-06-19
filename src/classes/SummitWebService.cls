global with sharing class SummitWebService{
    webservice static String InsertHyphenPayment(String ContactRefId,Integer PNumber,String PMonth,Date PDate,Decimal PCollection,String CollectionStatus){
        
        Contact con = new Contact();
        try{
        con =[select id,lastname,Summit_Ref_ID__c from Contact where Summit_Ref_ID__c =:ContactRefId];
        }catch(Exception e){
            return 'No reference id found';
        }
        Hyphen_Payment_Plan__c hp = new Hyphen_Payment_Plan__c();
        hp.Period_Number__c =PNumber;
        hp.Period_Month__c =PMonth;
        hp.Date_Plan_at_Hyphen__c =PDate;
        hp.Collection_Plan_at_Hyphen__c =PCollection;
        hp.Collection_Status__c =CollectionStatus;
        hp.Contact__c =con.id;
        insert hp;
        return 'Record Inserted Ref Number is :'+hp.id;
    }
    webservice static String updateHyphenPayment(String RecordId,Integer PNumber,String PMonth,Date PDate,Decimal PCollection,String CollectionStatus){
        Hyphen_Payment_Plan__c hp = new Hyphen_Payment_Plan__c();
        try{
        hp =[select Period_Number__c,Period_Month__c,Date_Plan_at_Hyphen__c,Collection_Plan_at_Hyphen__c,Collection_Status__c from Hyphen_Payment_Plan__c where id =:RecordId];
        }catch(Exception e){
            return 'No record exists with this id.';
        }
        hp.Period_Number__c =PNumber;
        hp.Period_Month__c =PMonth;
        hp.Date_Plan_at_Hyphen__c =PDate;
        hp.Collection_Plan_at_Hyphen__c =PCollection;
        hp.Collection_Status__c =CollectionStatus;
        update hp;
        return 'Record Updated';
        
    }
}