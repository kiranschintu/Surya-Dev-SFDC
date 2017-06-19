global class BriteVerifyEmailServicefrmPage{
    webservice static string doCallout(String rid, String email, String ObjectName){
        BriteVerifyService ob = new BriteVerifyEmailServiceImpl();
       
        BriteVerifyServiceResponse  result = ob.getEmailVerificationStatus(email);
        
        //updating existing record
        sObject sObj = Schema.getGlobalDescribe().get(ObjectName).newSObject() ;  
        sObj.put('id', rid);
        sObj.put('Email_Verification_Result__c',result.procesStatus(result.status));
        sObj.put('Email_Is_Disposable__c', result.disposable == true ? true : false);
        sObj.put('Email_Is_Role_Address__c',  result.role_address == true ? true : false);
        sObj.put('Email_Verification_Date__c', System.now());
        update sObj;
        return 'Verification Success. Email ';//+result.status;
    }
}