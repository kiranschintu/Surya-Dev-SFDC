public class CheckListsSetsMaps{
    public static void Checking(){
    	List<Integer> mylist=New List<Integer>();
        mylist.add(1);
        mylist.add(2);
        mylist.add(3);
        
        mylist.clone();
        list<String> lstPickvals= new list<string>();
        //Schema.SObjectType targetType = Schema.getGlobalDescribe().get('Account');//From the Object Api name retrieving the SObject
    	//Sobject Object_name = targetType.newSObject();
  		Schema.sObjectType sobject_type = Account.getSObjectType(); //grab the sobject that was passed
    	Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
   		Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();
         List<Schema.PicklistEntry> pick_list_values = field_map.get('Type').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
    	for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
      	lstPickvals.add(a.getValue());//add the value  to our final list
        }
        /*Map<Integer,String> mymap=New Map<Integer,String>();
        mymap.add(1,'entry');
        mymap.add(2,'entry');
        mymap.add(3,'entry');
        mymap.clone();*/
      }
}