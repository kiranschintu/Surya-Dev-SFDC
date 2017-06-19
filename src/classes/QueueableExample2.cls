public class QueueableExample2 implements Queueable{
    public void execute(QueueableContext qc){
        system.debug('Queueable Implemented... --2');
    }
}