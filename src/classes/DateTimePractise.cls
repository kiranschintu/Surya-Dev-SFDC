public class DateTimePractise{
    public static void dosome(){
        
        Account accc = [Select id,name,phone,Last_Modified_Date_For_Reload__c,lastmodifieddate from Account where id='0019000000nvko3'];
       Date d1=accc.Last_Modified_Date_For_Reload__c.Date();
       Date d2=system.now().Date();
       Time t1=accc.Last_Modified_Date_For_Reload__c.Time();
       Time t2=system.now().Time();
       Time t3=t2-(1000*60);
       if(t1<= t2 && t1>= t3 && t1!=Null && t2!=Null && t3!=Null)
           system.debug('Success');
    }
}