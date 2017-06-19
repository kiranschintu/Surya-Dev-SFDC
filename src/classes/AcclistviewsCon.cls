public class AcclistviewsCon {
    Public List<SelectOption> options{get;set;}
    public String selectedvalue{get;set;}
    public List<Account> accs{get;set;}
    public AcclistviewsCon(ApexPages.StandardSetController controller) {
        options = new List<SelectOption>();
        selectedvalue = '00B90000006lQkUEAU';
        System.SelectOption[] listViews = controller.getListViewOptions();
        //options = controller.getListViewOptions();
        options.add(new SelectOption('Hello','One'));
        system.debug('Hello'+controller.getListViewOptions());
        for(System.SelectOption listView : listViews)
        {
            String s = listView.getValue().substring(0,15);
            options.add(new SelectOption(s,listView.getLabel()));
        }  
    }


    public AcclistviewsCon(ApexPages.StandardController controller) {
        
    }
    
     public PageReference selectedValue(){
        //[select id,name from contact where AccountId=:Selection];
        
        return null;
    }

}