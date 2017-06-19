public with sharing class oppcancelCon {

    public Opportunity opportunity { get; set; }
    

    public PageReference save() {
        return null;
    }
    public PageReference canceling() {
        PageReference pg = new Pagereference('/apex/success');
        pg.setRedirect(True);
        return pg;
    }

}