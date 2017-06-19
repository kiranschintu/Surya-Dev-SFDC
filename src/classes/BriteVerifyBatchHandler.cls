global class BriteVerifyBatchHandler implements Database.batchable<sObject>,Database.allowsCallouts{
    global final String objectName;
    global Briteverify__c obs;
    
    global BriteVerifyBatchHandler(String objectName){
        this.objectName = objectName;
        //retrieving time period from custom setting
        obs = Briteverify__c.getInstance('BriteEndPoint');
    }
    
    global Database.queryLocator start(Database.batchableContext bc){
        String Query;
        Integer timePeriodLmt = obs!=null && obs.Time_Out__c!=null ? Integer.valueOf(obs.Time_Out__c) : 0;
        DateTime timePeriod = system.now().addDays(-timePeriodLmt);
        if(objectName=='Contact'){
            Query = 'Select id,name,Email,Email_Verification_Result__c,Email_Is_Disposable__c,Email_Is_Role_Address__c,Email_Verification_Date__c from Contact where Email!=null AND (Email_Verification_Date__c <=: timePeriod OR Email_Verification_Date__c=null) AND id=\'0039000001hheDG\'';
        }
        
        return database.getQueryLocator(Query);
    }
    
    global void execute(Database.batchableContext bc,List<sObject> scope){
        List<sObject> updsObjects = new List<sObject>();
        for(sobject s : scope){
            system.debug('Email:'+s.get('Email'));
            if(s.get('Email')!=null){
                BriteVerifyService ob = new BriteVerifyEmailServiceImpl();
                BriteVerifyServiceResponse  result = ob.getEmailVerificationStatus(string.valueOf(s.get('Email')));
                
                //updating existing record
                s.put('Email_Verification_Result__c',result.procesStatus(result.status));
                s.put('Email_Is_Disposable__c', result.disposable == true ? true : false);
                s.put('Email_Is_Role_Address__c',  result.role_address == true ? true : false);
                s.put('Email_Verification_Date__c', System.now());
                
                updsObjects.add(s);
            }
        }
        if(!updsObjects.isEmpty()){
            update updsObjects;
        }
        
    }
    
    global void finish(Database.batchableContext bc){
    
    }
}