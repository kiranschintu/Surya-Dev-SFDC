@RestResource(urlMapping='/P3_AccessMatter/*')
global with sharing class P3_AccessMatter
{
  
  @HttpPOST
  global static void RetrieveMatter(MatterContext matters)
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    
    WorkProducts RResponse = new  WorkProducts();
    Integer StatusCode = 200;
    String ResponseMessage = 'OK';
    
    try{
        //calling retrieveData method to retrieve the matterName, ConcourseMatterId and RequestName
        RResponse = retrieveData(matters);
        
        StatusCode = 200;
        if(RResponse!=null){
            ResponseMessage = JSON.serialize(RResponse);
        }else{
            ResponseMessage = 'null';
        }
    }catch(Exception e){
        StatusCode = 500;
        ResponseMessage = e.getMessage();
    }
    RestContext.response.StatusCode = StatusCode;
    RestContext.response.responseBody = Blob.valueOf(ResponseMessage);   //Blob.valueOf(JSON.serialize(RResponse));   
  }
  
  private static WorkProducts retrieveData(MatterContext matrcontext)
  {
    Boolean isExist;
    Matter__c matter;
    if(matrcontext.ConcourseMatterId!=null && matrcontext.ConcourseMatterId!=''){
    try{
        //retrieving the matters based on concourse matter id
        matter =[Select Id,Matter_Name__c,ConcourseMatterId__c From Matter__c where ConcourseMatterId__c =:matrcontext.ConcourseMatterId limit 1];
        if(matter!=null){
            isExist = true;
        }
    }catch(Exception e){
        isExist = false;
    }
    
    WorkProducts wpr = new WorkProducts();
    
    if(isExist==true){
        //Create work product and return response, if Matter exist
        Work_Product__c wp = new Work_Product__c();
        wp.Related_Matter__c = matter.Id;
        wp.Work_Product_Name__c = matrcontext.RequestName;
        insert wp;
        
        wpr.workproductId = wp.id;
        wpr.WorkProductName = wp.Work_Product_Name__c;
        wpr.RelatedConcourseMatterId = wp.Related_Matter__r.ConcourseMatterId__c;
        
    }else{
        //Create Matter and create Work product and return response, if Matter does not exist
        //Creating Matter
        Matter__c mat = new Matter__c();
        mat.Matter_Name__c= matrcontext.matterName;
        mat.ConcourseMatterId__c = matrcontext.ConcourseMatterId;
        insert mat;
        
        //Creating Work Product
        Work_Product__c wp = new Work_Product__c();
        wp.Related_Matter__c = mat.Id;
        wp.Work_Product_Name__c = matrcontext.RequestName;
        insert wp;
        
        wpr.workproductId = wp.id;
        wpr.WorkProductName = wp.Work_Product_Name__c;
        wpr.RelatedConcourseMatterId = wp.Related_Matter__r.ConcourseMatterId__c;
        
    }
    return wpr;
    }else{
        return null;
    }
}
  //class to hold the request body
  global class MatterContext
  {
    public String matterName;
    public String ConcourseMatterId;
    public String RequestName;
    public String errors;
  }
  //class to hold the response body
  global class WorkProducts
  {
    public String workproductId;
    public String WorkProductName;
    public String RelatedConcourseMatterId;
    public String errors;
  }
}