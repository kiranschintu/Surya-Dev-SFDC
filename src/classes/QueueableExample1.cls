public class QueueableExample1 implements Queueable{
    public void execute(QueueableContext qc){
        system.debug('Queueable Implemented... --1');
        System.enqueueJob(new QueueableExample2());
    }
}