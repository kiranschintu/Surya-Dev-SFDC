public class AddPiclistDyanmicCon {

public String city{get; set;}
private final Book__c book;

public AddPiclistDyanmicCon(){
    book = [SELECT Id, Name from Book__c 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
}

public Book__c getbooks() {
        return book;
    }

public List<SelectOption> getcitynames()
{
  List<SelectOption> options = new List<SelectOption>();
  List<DynamicPicklist__c> citylist = new List<DynamicPicklist__c>();
  citylist = [Select Id, PickListValue__c FROM DynamicPicklist__c order by PickListValue__c ];
  options.add(new SelectOption('--None--','--None--'));
  for (Integer j=0;j<citylist.size();j++)
  {
      options.add(new SelectOption(citylist[j].PickListValue__c,citylist[j].PickListValue__c));
  }
  return options;
}
public String newpicklistvalue{get; set;}

public void saverec()
{
  DynamicPicklist__c newrec = new DynamicPicklist__c(PickListValue__c=newpicklistvalue);
  insert newrec;
  newpicklistvalue=NULL;
}

}