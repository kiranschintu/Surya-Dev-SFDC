public class ExecuteBatchApexTran{
	
    public static void dosome(){
    BatchApexTran ob = new BatchApexTran();
        Database.executebatch(ob);
        string scdate='0 0 0 15 3 ? 2014';
        system.scheduleBatch(ob,'My Scheduled Job',1);
	}
}