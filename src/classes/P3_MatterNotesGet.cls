@RestResource(urlMapping='/P3_Matternotesget/*')
global class P3_MatterNotesGet
{
  //Retrieve Notes from Work Product object by passing Matter id
  @HttpGet
  global static void displayNotes()
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    
    //Retrieving URL parameters
    String matid = RestContext.request.params.get('matterid');
    String Count = RestContext.request.params.get('count');
    Integer StatusCode = 200;
    String ResponseMessage = 'OK';
    
    List<String> materidslst = new List<String>();
    
    try{
        if(matid!= null && matid != ''){
            //splitting matter ids
            materidslst = matid.split(',');
        }
        //declaring set to store matter ids to prevent the duplicates
        Set<String> materidsst = new Set<String>();
        if(!materidslst.isEmpty()){
            materidsst.addAll(materidslst);
        }
        if(materidsst.contains('')){
            //removing empty element from set
            materidsst.remove('');
        }
        
        Integer countt =0;
        if(count!= null & count!=''){
            //converting string parameter into number
            countt = Integer.valueOf(count);
        }
        
        if(!materidsst.isEmpty()){
            //Retrieving Matter records based on matter ids and owner ship
            List<dhr__Matter__c> mats = [select id,dhr__ConcourseMatterId__c from dhr__Matter__c where dhr__ConcourseMatterId__c in:materidsst and OwnerId=:UserInfo.getUserId() ];
            List<MaterNotes> RResponse = new  List<MaterNotes>();
            //Retrieving Work Products related to Matters 
            Map<String,dhr__Work_Product__c> wprods = new Map<String,dhr__Work_Product__c>([select id,Work_Product_Name__c,Concourse_MatterId__c,Related_Matter__r.ConcourseMatterId__c from dhr__Work_Product__c where dhr__Related_Matter__c in:mats]);
            if(!wprods.isEmpty()){
                //Retrieving Notes related to Work Products order by created date and set the Limit
                for(Note n: [select id,Title,Body,CreatedDate,ParentId from Note where ParentId in:wprods.keySet() order by Createddate DESC limit :countt ]){
                    //Preparing Response body
                    MaterNotes mNote = new MaterNotes();
                    mNote.title = n.title;
                    mNote.body = n.body;
                    mNote.RequestName = wprods.get(n.ParentId).Work_Product_Name__c;
                    mNote.RequestConcourseId = wprods.get(n.ParentId).Concourse_MatterId__c;
                    mNote.MatterCouncourseId = wprods.get(n.ParentId).Related_Matter__r.ConcourseMatterId__c;
                    
                    RResponse.add(mNote);
                }
            }
            ResponseMessage = JSON.serialize(RResponse);
            StatusCode = 200;
        }
    }catch(Exception e){
        StatusCode = 500;
        ResponseMessage = e.getMessage();
    }
    RestContext.response.StatusCode = StatusCode;
    RestContext.response.responseBody = Blob.valueOf(ResponseMessage);
  }
  
  //Class to hold response body
  global class MaterNotes
  {
      public String title;
      public String body;
      public String RequestName;
      public String RequestConcourseId;
      public String MatterCouncourseId;
  }
  }