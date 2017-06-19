public with sharing class businesshours1 {
public string values{get;set;}
public List<selectOption> options{get;set;}
public List<string> timezones{get;set;}
public businesshours1(){
    dotest();
}public void dotest(){
    options = new List<selectOption>();
    timezones = new List<String>();
    /*Schema.sObjectType sobject_type = BusinessHours.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get('TimeZoneSidKey').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            options.add(new selectOption(a.getLabel(), a.getValue()));  //add the value and label to our final list
        }*/
        Schema.DescribeFieldResult F = Schema.SObjectType.BusinessHours.fields.TimeZoneSidKey; 
        List<schema.picklistentry> p=f.getpicklistvalues();
        for (Schema.PicklistEntry a : p) { //for all values in the picklist list
            options.add(new selectOption(a.getLabel(), a.getValue()));  //add the value and label to our final list
            timezones.add(a.getValue());
        }
    //Schema.describeFieldResult fr = BusinessHours.TimeZoneSidKey.getDescribe();
    //List<schema.picklistentry> p = fr.getpicklistvalues();
}
}