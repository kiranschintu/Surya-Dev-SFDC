public with sharing class P3_WorkProduct_Controller 
{
  //Variables
  private Id requestId {get; set;}
  private String accessType {get; set;}
  public Boolean initComplete {get; set;}
  
  public Work_Product__c wpObject {get; set;}
  public List<Schema.FieldSetMember> fieldSetMemberList{get;set;}
  
  public P3_WorkProduct_Controller()
  {
    initComplete = false;
    getURLParameters();
    
    if(initComplete)
    {
      getFieldSetMemberList('Default');
      getWpObject();
    }
    getURLParameters();
    getWpObject();
    system.debug('WPObject>>'+wpObject);
    System.debug('3');
  }
  
  private void getURLParameters()
  {
    try
    {
      requestId = ApexPages.currentPage().getParameters().get('id');
      accessType = ApexPages.currentPage().getParameters().get('access');
      
      if(String.isEmpty(accessType))
      {
        accessType = 'view';  
      }
      
      initComplete = true;
    }
    catch(Exception e)
    {
      initComplete = false;
      System.debug('4');
    }
  }
  
  private List<Schema.FieldSetMember> getFieldSetMemberList(String selectedRecordTypeName)
  {
    try
    {
      System.debug('0.1');
      Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
      System.debug('0.2'); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get('Work_Product__c');
        System.debug('0.3');
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        System.debug('0.4');
        
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(selectedRecordTypeName);
        System.debug('0.5');
        fieldSetMemberList = fieldSetObj.getFields();
        System.debug('0.6'); 
    }
    catch(Exception e)
    {
      System.debug('1');
    }
    
    return fieldSetMemberList;
  }
  
  private void getWpObject()
  {
    try
    {
      if(requestId!=null)
            {
                String query = 'Select ';
                /*for(Schema.FieldSetMember fieldSetMember : fieldSetMemberList)
                {
                     query += fieldSetMember.getFieldPath() + ', ';
                }
                query += 'r.Id,r.Name,r.Status__c, Related_Matter__c, r.LastModifiedDate, r.LastModifiedById, r.LastModifiedBy.Name, r.CreatedDate, r.CreatedById,r.CreatedBy.Name From Work_Product__c r WHERE r.Id= :requestId';
                
                System.debug('1.1');
                
                wpObject = Database.query(query);
                
                System.debug('1.2');*/
                wpObject = [select id,name,(select id,name,Document_Name__c from dhr__Concourse_Documents__r )  from Work_Product__c where id=:requestId];
            }
            else
            {
                wpObject = null;
            }  
    }
    catch(Exception e)
    {
      System.debug(e.getMessage());
    }
  }
  
  /*public PageReference back2List()
  {
    if(requestId!=null)
    {
      PageReference ref = new Pag
    }
  }*/
}