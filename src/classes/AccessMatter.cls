/*******
Access Matter....
*******/
@RestResource(urlMapping='/AccessMatter1/*')
global with sharing class AccessMatter
{
  @HttpPOST
  
  global static void RetrieveMatter(MatterContext matters)
  {
    
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    
    WorkProducts RResponse = new  WorkProducts();
    RResponse = retrieveData(matters);
    RestContext.response.responseBody = Blob.valueOf(JSON.serialize(RResponse));   
  }
  
  private static WorkProducts retrieveData(MatterContext matcontext)
  {
    Boolean isExist;
    Matter__c mats;
    try{
        mats =[Select Id,Matter_Name__c,ConcourseMatterId__c From Matter__c where ConcourseMatterId__c =:matcontext.ConcourseMatterId];
        if(mats!=null){
            isExist = true;
        }
    }catch(Exception e){
        isExist = false;
    }
    
    WorkProducts wpr = new WorkProducts();
    
    if(isExist==true){
        Work_Product__c wp = new Work_Product__c();
        wp.Related_Matter__c = mats.Id;
        wp.Work_Product_Name__c = matcontext.RequestName;
        insert wp;
        
        wpr.workproductId = wp.id;
        wpr.WorkProductName = wp.Work_Product_Name__c;
        wpr.RelatedConcourseMatterId = wp.Related_Matter__r.ConcourseMatterId__c;
        
    }else{
        Matter__c mat = new Matter__c();
        mat.Matter_Name__c= matcontext.matterName;
        mat.ConcourseMatterId__c = matcontext.ConcourseMatterId;
        insert mat;
        
        Work_Product__c wp = new Work_Product__c();
        wp.Related_Matter__c = mat.Id;
        wp.Work_Product_Name__c = matcontext.RequestName;
        insert wp;
        
        wpr.workproductId = wp.id;
        wpr.WorkProductName = wp.Work_Product_Name__c;
        wpr.RelatedConcourseMatterId = wp.Related_Matter__r.ConcourseMatterId__c;
        
    }
    return wpr;
}
    
  global class MatterContext
  {
    public String matterName;
    public String ConcourseMatterId;
    public String RequestName;
    public String errors;
  }
  global class WorkProducts
  {
    public String workproductId;
    public String WorkProductName;
    public String RelatedConcourseMatterId;
    public String errors;
  }
}