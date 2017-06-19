public with sharing class ActionSupportReRenderCls {
    public Account acc{get;set;}
    public String selectedValue{get;set;}
    public List<SelectOption> options{get;set;}
    public ActionSupportReRenderCls(){
        options = new List<SelectOption>();
        options.add(new selectOption('','--None--'));
        options.add(new SelectOption('One', 'One'));
        options.add(new SelectOption('Two', 'Two'));
    }
    
    public Void doTest(){
        system.debug(acc);
        system.debug('Hello>>>'+selectedValue);
        //acc.Description='9999999999'+acc.name;
    }
}