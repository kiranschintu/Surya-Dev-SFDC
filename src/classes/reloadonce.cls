public with sharing class reloadonce {

    public boolean showPopup{get;set;}
    public contact con{get;set;}
    public reloadonce(ApexPages.StandardController controller) {
        con = (Contact)controller.getRecord();
    }
    public void changename(){
    //con = [select id,name,reload__c from Contact where id='0039000000peDni'];
    con.dhr__reload__c ='n';
    update con;
    }

}