global with sharing class FieldAccessChecking{
    public static void checkingfieldstatus(){
    	Schema.DescribeFieldResult fr = Account.Name.getDescribe();
        Schema.DescribeFieldResult frImage = Account.Image__c.getDescribe();
        system.debug('Field Access Status :'+fr.isAccessible());
        system.debug('Field Type(Standard/Custom) status:'+frImage.isCustom());
        system.debug('Field Permission Checking :'+frImage.isPermissionable());
        
        Boolean fieldst = False;
        if(schema.sobjectType.Account.fields.NAME.isUpdateable()){
        fieldst = True;
        }
        system.debug('Field Access Checking :'+fieldst);
        
    }
}