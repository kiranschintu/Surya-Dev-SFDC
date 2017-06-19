public class AEXP_EnrollmentDocuments_TestCTRL {
    public static string strOpportunityId{get;set;}
    
    public AEXP_EnrollmentDocuments_TestCTRL(){
        strOpportunityId = '0069000000bBDWC';
    }
    
    @RemoteAction
    public static String getEnrollmentList(String opId){
        //strOpportunityId = ApexPages.currentPage().getParameters().get('oppId');
        strOpportunityId = '0069000000bBDWC';
        
        List<Attachment> lstDocuments = new List<Attachment>();
        lstDocuments = [Select id,name,CreatedBy.Name from Attachment where ParentId=:strOpportunityId]; 
        
        return Json.serializePretty(lstDocuments);
    }
    
    /* Method Name: sortEnrollmentList
    * Author Name: Kranthi Nirmala
    * Description: gets list of enrollments to be displayed on dashboard after sorting
    * Returns: sorted and Serialised Dashboard List
    */
    
    /*@RemoteAction
    public static String sortEnrollmentList(String lstEnrollment, String strSortListBy, String sortType){
        
        List<AEXP_DashboardWrapper> lstEnrollmentDashboard = new List<AEXP_DashboardWrapper>();
        lstEnrollmentDashboard = (List<AEXP_DashboardWrapper>)JSON.deserialize(lstEnrollment, List<AEXP_DashboardWrapper>.class);
        if(strSortListBy == 'strType')
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.strType;
        else if(strSortListBy == 'strProduct')
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.strProduct;
        else if(strSortListBy == 'strAnnualSpend')
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.strAnnualSpend;
        else if(strSortListBy == 'strIndustry')
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.strIndustry;
        else if(strSortListBy == 'strContact')
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.strContact;
        else if(strSortListBy == 'strStatus')
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.strStatus;
        else
        AEXP_DashboardWrapper.objSortBy = AEXP_DashboardWrapper.strSortBy.stropportunityName;
        AEXP_DashboardWrapper.strSortType = sortType;
        lstEnrollmentDashboard.sort();
        
        system.debug('Dashboard list after sorting: '+ lstEnrollmentDashboard);
        return JSON.serializePretty(lstEnrollmentDashboard);
    } */
}