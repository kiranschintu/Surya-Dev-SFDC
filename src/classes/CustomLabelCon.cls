public class CustomLabelCon {
    public String myLabel{get;set;}
    
    public CustomLabelCon(){
        //myLabel = 'LineBreak';//'CustomOne';
        myLabel = system.label.Translation;
    }
    public PageReference doaction(){
        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.confirm, 'Wish You A Wonderful Begining');
             ApexPages.addMessage(msg);
        return null;
    }
   
}