@isTest
private class P3TestAccessMatter{
    
    @testSetup static void setupData(){
        Matter__c  mat = new Matter__c();
        mat.ConcourseMatterId__c = '123456T';
        mat.Matter_Name__c = 'Test';
        insert mat;
        
        Matter__c  mat1 = new Matter__c();
        mat1.ConcourseMatterId__c = '123456';
        mat1.Matter_Name__c = 'Test';
        insert mat1;
    }
    
    @isTest static void accessMatTst(){
        
        Matter__c mats = [select id,name from Matter__c where Matter_Name__c='Test' limit 1];
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://ap1.salesforce.com/services/apexrest/AccessMatter';  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        P3_AccessMatter.MatterContext ami = new P3_AccessMatter.MatterContext();
        ami.matterName = 'Test';
        ami.ConcourseMatterId = '123456T';
        ami.RequestName = 'Test';
        P3_AccessMatter.RetrieveMatter(ami);
        
        //else conditon
        P3_AccessMatter.MatterContext ami1 = new P3_AccessMatter.MatterContext();
        ami1.matterName = 'Test';
        ami1.ConcourseMatterId = '123875';
        ami1.RequestName = 'Test';
        P3_AccessMatter.RetrieveMatter(ami1);
        
    }
}