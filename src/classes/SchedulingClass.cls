public class SchedulingClass implements Schedulable{
    public void execute(SchedulableContext sc){
        Account a=new Account();
        a.name='Schedule';
        insert a;
    }
}