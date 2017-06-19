public class tableinpgsection {
    public Account account{get;set;}
    public tableinpgsection(){
        String id = ApexPages.CurrentPage().getParameters().get('id');
        account = [select id,name,phone,industry,rating from Account where id='001900000131Vmo'];
    }
}