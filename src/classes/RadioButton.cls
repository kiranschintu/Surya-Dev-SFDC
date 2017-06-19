public with sharing class RadioButton {

    
    public List<SelectOption> chars{get;set;}
    public transient string SelectedValue {get;set;}
    public RadioButton(){
        chars = new List<SelectOption>();
        if(chars!=null){
            chars.add(new SelectOption('Maleeeee','Male'));
            chars.add(new SelectOption('Femaleeeee','Female'));
        }
    }
    
    public PageReference checkstatus() {
        //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info, 'You have selected :'+SelectedValue));
        ApexPages.Message msg = new ApexPages.message(ApexPages.severity.Info, 'You have selected :'+SelectedValue);
        ApexPages.addMessage(msg);
        return null;
    }
    
    @RemoteAction
    public static PageReference checkStatausJS(){
        ApexPages.Message msg = new ApexPages.message(ApexPages.severity.Info, 'You are calling Remote Action Method');
        ApexPages.addMessage(msg);
        return null;
    }

    
}