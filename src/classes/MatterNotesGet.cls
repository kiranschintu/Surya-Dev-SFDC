@RestResource(urlMapping='/MatternotesGet/*')
global class MatterNotesGet
{
  @HttpGet
  
  global static void displayNotes()
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    
    String matid = RestContext.request.params.get('matterid');
    String Count = RestContext.request.params.get('count');
    
    system.debug('MatId>>>'+matid);
    system.debug('Count>>>'+Count);
    
    List<String> matidl = new List<String>();
    if(matid!= null && matid != ''){
        matidl = matid.split(',');
    }
    system.debug('matidl>>>'+matidl);
    Set<String> matids = new Set<String>();
    if(!matidl.isEmpty()){
    matids.addAll(matidl);
    }
    system.debug('matids>>>'+matids);
    if(matids.contains('')){
        matids.remove('');
    }
    system.debug('matids>>>'+matids);
    
    Integer countt =0;
    if(count!= null & count!='')
    countt = Integer.valueOf(count);
    
    if(!matids.isEmpty()){
    List<dhr__Matter__c> mats = [select id,dhr__ConcourseMatterId__c from dhr__Matter__c where dhr__ConcourseMatterId__c in:matids and OwnerId=:UserInfo.getUserId() ];
    system.debug('mats>>>'+mats);
    List<MatNotes> RResponse = new  List<MatNotes>();
    Map<String,dhr__Work_Product__c> wprods = new Map<String,dhr__Work_Product__c>([select id,Work_Product_Name__c,Concourse_MatterId__c,Related_Matter__r.ConcourseMatterId__c from dhr__Work_Product__c where dhr__Related_Matter__c in:mats]);
    system.debug('wprods>>>'+wprods);
    if(!wprods.isEmpty()){
    for(Note n: [select id,Title,Body,CreatedDate,ParentId from Note where ParentId in:wprods.keySet() order by Createddate DESC limit :countt ]){
        MatNotes man = new MatNotes();
        man.title = n.title;
        man.body = n.body;
        man.RequestName = wprods.get(n.ParentId).Work_Product_Name__c;
        man.RequestConcourseId = wprods.get(n.ParentId).Concourse_MatterId__c;
        man.MatterCouncourseId = wprods.get(n.ParentId).Related_Matter__r.ConcourseMatterId__c;
        
        RResponse.add(man);
    }
    system.debug('Response>>>'+rresponse);
    }
    
    try{
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(RResponse));
    }catch(Exception e){
        system.debug('Error Occured :'+e.getMessage());
    }
    }
    
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