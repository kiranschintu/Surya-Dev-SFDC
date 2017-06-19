public with sharing class BusinessDaysCalWitHolidays{
    
    //Calculating Business Days including related Holidays
    public static void docal(){
        Case cas = [select id,Due_Date__c from Case where id='50090000004NaY8'];
        Date casDueDate = cas.due_Date__c;
        Date systemDate = casDueDate.addDays(19);
        system.debug('Date value::'+systemDate);
        Integer holidaysCount = 0;
        // Get the default business hours
        BusinessHours bh = [SELECT FridayStartTime,MondayStartTime,SaturdayStartTime,SundayStartTime,ThursdayStartTime,TuesdayStartTime,WednesdayStartTime FROM BusinessHours limit 1];
        
        while (casDueDate != systemDate) {
            Datetime now = Datetime.newInstance(casDueDate.year(), casDueDate.month(), casDueDate.day(), 0, 0, 0);        
            system.debug('Now>>>'+now);
            system.debug('BusinessHours>>>'+BusinessHours.isWithin(bh.Id, now));
            Boolean isHoliday = !BusinessHours.isWithin(bh.Id, now);
            System.debug('The value of isHoliday is : '+isHoliday);
            if (isHoliday) {
                holidaysCount++;
            }
            casDueDate = casDueDate.addDays(1);
        }
        System.debug('The holidays are : '+holidaysCount);
        system.debug('Due Date is::'+casDueDate);    
    }
}