@RestResource(urlMapping='/Matternotes/*')
global class MatterNotes
{
  //Retrieve Notes from Work Product object by passing Matter id
  @HttpPost
  global static string displayNotes(List<LstMatter> lstmatrs,Integer count)
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    Integer StatusCode = 200;
    String ResponseMessage = 'OK';
    
    Set<String> matterids = new Set<String>();
    try{
    for(LstMatter l:lstmatrs){
        matterids.add(l.matterId);
    }
    Integer countt =0;
    countt = count;
    
    List<dhr__Matter__c> matters = [select id,dhr__ConcourseMatterId__c from dhr__Matter__c where dhr__ConcourseMatterId__c in:matterids and OwnerId=:UserInfo.getUserId() ];
    
    List<MatNotes> RResponse = new  List<MatNotes>();
    Map<String,dhr__Work_Product__c> wproducts = new Map<String,dhr__Work_Product__c>([select id,Work_Product_Name__c,Concourse_MatterId__c,Related_Matter__r.ConcourseMatterId__c from dhr__Work_Product__c where dhr__Related_Matter__c in:matters]);
    if(!wproducts.isEmpty()){
        for(Note n: [select id,Title,Body,CreatedDate,ParentId from Note where ParentId in:wproducts.keySet() order by Createddate DESC limit :countt ]){
            MatNotes mNote = new MatNotes();
            mNote.title = n.title;
            mNote.body = n.body;
            mNote.RequestName = wproducts.get(n.ParentId).Work_Product_Name__c;
            mNote.RequestConcourseId = wproducts.get(n.ParentId).Concourse_MatterId__c;
            mNote.MatterCouncourseId = wproducts.get(n.ParentId).Related_Matter__r.ConcourseMatterId__c;
            
            RResponse.add(mNote);
        }
    }
    if(!RResponse.isEmpty()){
        StatusCode = 200;
        ResponseMessage = JSON.serialize(RResponse);
    }else{
    
    }
    
    }catch(Exception e){
        system.debug('Error Occured :'+e.getMessage());
        StatusCode = 500;
        ResponseMessage = e.getMessage();
    }
    RestContext.response.StatusCode = StatusCode;
    RestContext.response.responseBody = Blob.valueOf(ResponseMessage);
      return 'Hello';
  }
  
  global class LstMatter
  {
    public String matterId;
  }
  
  global class MatNotes
  {
      public String title;
      public String body;
      public String RequestName;
      public String RequestConcourseId;
      public String MatterCouncourseId;
  }
  }