public with sharing class aletoncecon {

    public aletoncecon(ApexPages.StandardController controller) {

    }
    
    @Future()
    public static void dofieldupdate(String id){
        //String id = ApexPages.CurrentPage().getParameters().get('id');
        Lead l = [select id,name,dhr__alert_once__c from Lead where id=:id];
        l.dhr__alert_once__c = True;
        update l;
    }

}