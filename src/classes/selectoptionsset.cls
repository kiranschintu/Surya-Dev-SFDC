public with sharing class selectoptionsset {
    public List<SelectOption> options{get;set;}
    Set<SelectOption> setOptions = new Set<SelectOption>();
    public selectoptionsset(){
        //displayoptions();
    }
    public void displayoptions(){
        options = new List<SelectOption>();
        for(Account a : [select id,Industry from Account where Industry!=null]){
            setOptions.add(new SelectOption(a.Industry,a.Industry));
        }
        options.addAll(setOptions);
        options.sort();
        options.add(0,new SelectOption('--None--','--None--'));
    }
}