@isTest
private class TestSchedulingClass{
    private static testmethod void myTest(){
        string scdate='0 0 0 15 3 ? 2014';
        
        SchedulingClass sc= new SchedulingClass();
        
        system.schedule('Scheduling Class', scdate,sc);
        
    }
}