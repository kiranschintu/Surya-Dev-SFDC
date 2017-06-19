public class Salesforce1CTRL {
    public Attachment attachment{get;set;}
    public Salesforce1CTRL(){
        attachment = new Attachment();
    }
    @RemoteAction
    public static void doSome(){
        system.debug('called:::');
    }
}