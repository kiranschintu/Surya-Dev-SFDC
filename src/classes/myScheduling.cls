global class myScheduling implements Schedulable{
    Integer a;
    Integer b;
    Integer c;
    global myScheduling(Integer a, Integer b){
        this.a=a;
        this.b=b;
        system.debug('<<<a>>>'+a);
        system.debug('<<<b>>>'+b);
        system.debug('<<<c>>>'+c);
    }
    global void execute(SchedulableContext sc){
        system.debug('<<<a>>>'+a);
        system.debug('<<<b>>>'+b);
        c = a+b;
        system.debug('<<<c>>>'+c);
    }
}