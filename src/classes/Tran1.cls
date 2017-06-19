public class Tran1 {

    
    public Account acc{get;set;}
    
    public Tran1(){
        acc = [select id,name,phone from Account where id =: ApexPages.CurrentPage().getParameters().get('id')];
    }
    
    public Account records(){
        return acc;
    }
    
}