/**********************************************************************************
* Name  : AEXP_DynamicEnrollmentPage_Controller
* Author : Kranthi Nirmala
* Desc  : gets the response from ICON, massage it and sends response to page
*
* Modification Log:
* ----------------------------------------------------------------------
* Developer                         Date                 Description
* ----------------------------------------------------------------------
* Kranthi Nirmala                   11/16/2015            Original Version
* Nghia Tran                        11/16/2015            Updated methods
* Anshul Jain                       11/18/2015            Updated getFieldsWrapper method 
* Nghia Tran                        11/20/2015            Updated code following by coding standard
* Anshul Jain                       01/12/2015            Updated code for accomodating changed JSON Response 
* Kranthi Nirmala                   31/12/2015            Updated code to replace utility with ICON 1st service 
* Kranthi Nirmala                   1/6/2016              Added code for saving attachments
* Nghia Tran                        1/20/2016             Added code for Save and open EchoSign page
* Kranthi Nirmala                   2/2/2016              Replaced the custom labels with custom settings in submit service 
* Kranthi Nirmala                   2/3/2016              Implemented Encryption for cliend id and secret key using 'AES128' algorithm
* Shruti Garg                       2/5/2016              Updated code for Prepopulation
* Shraddha Vidhate                  2/25/2016             added isSubmitreq for US393778
* Chiranjeevi Addela        4/12/2016        Modified system.debug for code refracting
**********************************************************************************/

public with sharing class AEXP_DynamicEnrollmentPage_Controller{
    public static string strEnrollmentId{get;set;} 
    public static string strOpportunityId{get;set;} 
    public static boolean isSubmitreq{get;set;} 
    //public static List<AEXP_Dynamic_Data_Capture__c> lstDynamicData{get;set;}
    //public static AEXP_Response objResponse{get;set;}
    //public static boolean boolExisting{get;set;}  
    public static integer counterForErrormsg{get;set;}
    
    public static boolean isManualSubmit{get;set;} 
    //CustomSetting for Storing ElementId and corresponding Element Label
    //public static Map<String,AEXP_Enrollment_PrePopulationFields__c> mapPrePopulateFieldCS = AEXP_Enrollment_PrePopulationFields__c.getAll();  
    
    
    /* Method Name: getFieldsWrapper
    * Author Name: Nghia Tran
    * Description: a function to get fields from JSON and parse them to AEXP_Response object.
    * Parametter: 
    * Returns    : an AEXP_Response object.
    *
    public static AEXP_Response getFieldsWrapper(String enrollId) {
        
        return AEXP_Enrollment_Response_Utilities.getFieldsWrapper(enrollId);
        
    }*/
    
    
    
    /* Method Name: getFieldsFromWrapper
    * Author Name: Nghia Tran
    * Description: a function to get JSON string.
    * Paramtter: Enrollment Id
    * Returns    : JSON string.
    */
    @RemoteAction
    public static String getFieldsFromWrapper(String enrollId) {
        
        //return JSON.serializepretty(AEXP_Enrollment_Response_Utilities.getFieldsWrapper(enrollId)); 
        return null;
    }
    
    /* Method Name: sendToEchoSign
    * Author Name: Nghia Tran
    * Description: a function to open EchoSign
    * Parameter: Opportunity Id
    * Returns    : a string .
    */
    @RemoteAction 
    public static String sendToEchoSign(string strOppId){
        // open EchoSign
        
        /*AEXP_EchoSignExtension objAEXP_EchoSignExtension = new AEXP_EchoSignExtension(strOppId);
        
        return objAEXP_EchoSignExtension.saveAgreement(strOppId, System.URL.getSalesforceBaseUrl().getHost()); // US387967
        */
        return null;
    }
    
    /* Method Name:  saveDynamicData
    * Author Name: Kranthi Nirmala
    * Description: a function to save Dynamic data to database.
    * Updated By Anshul  --  And validate(Validations only no Mandatory Check) the data. 
    * Returns    : a Pagereference, navigate to the same page
    */
    @RemoteAction 
    public static String saveDynamicData(string strEnrollId, String response){  
    
        //return AEXP_Enrollment_Response_Utilities.saveEnrollment(strEnrollId, response);
        return null;
        
    } 
    
    
    
    
    /* Method Name:  getAgreementStatus
    * Author Name: Nghia Tran
    * Description: a function to get AgreementStatus
    * Paramter: Enrollment Id
    * Returns    : a Agreement Status
    */
    @RemoteAction 
    public static String getAgreementStatus(string strEnrollId){
        /*list<AEXP_Enrollment__c> lstEnrollmentExists = [SELECT Agreement_Status__c,Icon_case_Id__c,Id,Name,Opportunity__c FROM AEXP_Enrollment__c WHERE Id =: strEnrollId];
        
         //   if(lstEnrollmentExists.size() > 0) Minor
         if(!(lstEnrollmentExists.isEmpty()))
        {   
         if(lstEnrollmentExists.get(0).Icon_case_Id__c !='null' && lstEnrollmentExists.get(0).Icon_case_Id__c !=null )
        {        
            isSubmitreq=true;
        }  
              
            return lstEnrollmentExists.get(0).Agreement_Status__c;
        }*/
        return '';
    }
    
 
    
    
    
    
    /* Method Name:  continueDynamicData
    * Author Name: Anshul Jain
    * Description: a function to save and validate(Validations + Mandatory) Dynamic data to database.
    * Returns    : a Pagereference, navigate to the same page
    */
    @RemoteAction 
    public static String continueDynamicData(string strEnrollId, String response){        
        //List<Attachment> lstAttachment = new List<Attachment>();
        //return AEXP_Enrollment_Response_Utilities.continueEnrollment(strEnrollId, response);
        return null;
    } 
    
    
    
    
    
    /******************************************************************
    *Author: Kranthi Nirmala
    *Name : uploadAttachments
    *Description: Upload an attachment to Opportunity object
    *******************************************************************/
    @RemoteAction 
    public static String uploadAttachments(string strEnrollId, String lstAttach){ 
        
        //return AEXP_Enrollment_Response_Utilities.uploadDocuments(strEnrollId, lstAttach);
        return null;
    }
    
    
    
    
    
    
    /* Method Name: ConfirmDynamicData
    * Author Name: Shraddha Vidhate
    * Description: a function to Confirm Dynamic data to ICON.
    * Returns    : Enrollment Id.
    * Anshul Jain : Updated the Method for calling the second ICON service.
    */
    
    @RemoteAction 
    public static String confirmDynamicData(string strEnrollId){ 
        
        /*AEXP_ICON_MetaData objICON_Metadata = new AEXP_ICON_MetaData();
        return objICON_Metadata.parseSubmitService(strEnrollId);
        */
        return null;
        
    } 
    
    
    /* Method Name: ConfirmDynamicData
    * Author Name: Shraddha Vidhate
    * Description: a function to Confirm Dynamic data to ICON.
    * Returns    : Enrollment Id.
    * Anshul Jain : Updated the Method for calling the second ICON service.
    */
    
    @RemoteAction 
    public static String submitToIM(string strImplId){ 
        
        /*AEXP_ICON_MetaData objICON_Metadata = new AEXP_ICON_MetaData();
        return objICON_Metadata.parseSubmitToIM(strImplId);
        */
        return null;
        
    } 
    
    
    
    /* Method Name:  getSecondWebServiceStatus
    * Author Name: Anshul Jain
    * Description: a function to get SecondWebServiceStatus
    * Paramter:     Enrollment Id
    * Returns    : a Second Webservice StatussubmitEnrollment
    */
    @RemoteAction 
    public static String getSecondWebServiceStatus(string strEnrollId){
        
        //return AEXP_Enrollment_Response_Utilities.getEnrollmentCaseId(strEnrollId);
        return null;
        
    }
    
    
    public AEXP_DynamicEnrollmentPage_Controller(ApexPages.StandardController controller) {
        strOpportunityId = ApexPages.currentPage().getParameters().get('oppId');
        counterForErrormsg = 0;
    }
    
    public AEXP_DynamicEnrollmentPage_Controller(){       
    }
    
    public static void initData(){
        /*List<AEXP_Enrollment__c> enrollmentList = new List<AEXP_Enrollment__c>();
        
        try{
            enrollmentList = [SELECT Id,Icon_case_Id__c from AEXP_Enrollment__c where Opportunity__c=: ApexPages.currentPage().getParameters().get('oppId')];  
        }catch(QueryException e){
            system.debug('Exception occurred querying Enrollment Object for given opportunity Id: '+e.getMessage());
        }
        
      //  if(enrollmentList.size()>0)Minor
      
       if(!(enrollmentList.isEmpty()))
      {
            strEnrollmentId = enrollmentList[0].Id;
            if(enrollmentList[0].Icon_case_Id__c !='null' && enrollmentList[0].Icon_case_Id__c !=null )
        {        
            isSubmitreq=true;
        }
            system.debug('Icon_case_Id__c====='+ enrollmentList[0].Icon_case_Id__c); 
            
        }else{
            AEXP_Enrollment__c enrollment = new AEXP_Enrollment__c();
            enrollment.Opportunity__c = ApexPages.currentPage().getParameters().get('oppId');
            
            try{
                Database.insert(enrollment);
                strEnrollmentId = enrollment.Id;
            }catch(DMLException e){
                system.debug('Exception occurred inserting an enrollment record : '+e.getMessage());
                
            }
            
            
        }*/
    }
    
    /* Method Name: getEnrollmentId
    * Author Name: Nghia Tran
    * Description: a function to get Enrollment Id.
    * Returns    : Enrollment Id.
    */
    @RemoteAction
    public static string getEnrollmentId(){
        /*List<AEXP_Enrollment__c> lstEnrollments = new List<AEXP_Enrollment__c>();
        
        try{
            lstEnrollments = [SELECT Id from AEXP_Enrollment__c where Opportunity__c=:ApexPages.currentPage().getParameters().get('oppId')];  
        }catch(QueryException e){
            system.debug('Exception occurred while Querying lstEnrollments'+e);
        }   
        
        //if(lstEnrollments.size()>0)Minor
        if(!(lstEnrollments.isEmpty())) {
            strEnrollmentId= lstEnrollments[0].Id;
            
        }else{
            AEXP_Enrollment__c objEnrollment = new AEXP_Enrollment__c();
            objEnrollment.Opportunity__c = ApexPages.currentPage().getParameters().get('oppId');
            
            try{
                Database.insert(objEnrollment);
                strEnrollmentId = objEnrollment.Id;
            }catch(DMLException e){
                system.debug('Exception: '+e);
                
            }
            
        }*/
        return strEnrollmentId;
    }
        
    /* Method Name: getDocUploadParameters
    * Author Name: Kranthi Nirmala
    * Description: a function to get Doc Upload parameters.
    * Returns    : parameters to pass to Doc Upload.
    */
    /*************Commenting out for deployment--March 15*****************

    @RemoteAction
    public static string getDocUploadParameters(String strEnrollId){
        return AEXP_AppCapture_DocUpload_Utility.getDocUploadParameters(strEnrollId);
        
    }    
    ******************************************************************/
   
}