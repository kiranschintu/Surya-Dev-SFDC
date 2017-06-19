public class form1Con {
    public String fn{get;set;}
    public String ln{get;set;}
    public String phone{get;set;}
    
    public String fn1{get;set;}
    public String ln1{get;set;}
    public String phone1{get;set;}
    
    public PageReference next(){
        
        PageReference pg = new PageReference('/apex/form2?fn='+fn+'&ln='+ln+'&phone='+phone);
        pg.setRedirect(true);
        return pg;
    }
    
    public void values(){
        fn1 = ApexPages.currentPage().getParameters().get('fn');
        ln1 = ApexPages.currentPage().getParameters().get('ln');
        phone1 = ApexPages.currentPage().getParameters().get('phone');
    }
}