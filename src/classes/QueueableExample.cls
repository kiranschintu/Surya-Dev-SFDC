public class QueueableExample implements Queueable{
    public void execute(QueueableContext qc){
        system.debug('Queueable Implemented...');
        System.enqueueJob(new QueueableExample1());
    }
}