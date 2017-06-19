public with sharing class AttachedDocumentsCOn{
    public List<Concourse_Document__c> concDocs{get;set;}
    public String workProductId{get;set;}//work product id
    public Boolean docStatus{get;set;}
    public string ConcDocGUID{get;set;}
    
    public void getInit(){
        if(workProductId!=null){
            try{
                concDocs = [select id,name,Concourse_Doc_GUID__c,Document_Name__c,CreatedDate  from Concourse_Document__c where Related_Work_Product__c =:workProductId];//a0i90000003IGJW
            }catch(Exception e){
                system.debug('Error :'+e.getMessage());
            }
            if(concDocs.isEmpty()){
                docStatus=true;
            }else{
                docStatus=false;
            }
        }
    }
    
    public PageReference doAction(){
        if(ConcDocGUID!=null){
            try{
                //retrieving custom settings
                Dev_Configuration__c oc = Dev_Configuration__c.getInstance('Concourse Development URL');
                if(oc!=null && oc.Concourse_Server_URL__c!=null){        
                    PageReference pg = new PageReference(oc.Concourse_Server_URL__c+'/MatterRoom/DocumentView/#Document/a08d8c40bf6c4728aa5ebda8c4807aca?documentId='+ConcDocGUID+'&containerType=Matter');
                    //PageReference pg = new PageReference('https://www.google.com');
                    pg.setRedirect(true);
                    return pg;
                }else{
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Custom Setting Values Not found');
                    ApexPages.addMessage(msg);
                    
                    return null;
                }
            }catch(Exception e){
                system.debug('Error :'+e.getMessage());
                return null;
            }
        }else{
            return null;
            }
    }
    
}