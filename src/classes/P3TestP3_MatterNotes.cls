@isTest
private class P3TestP3_MatterNotes{
    private static testmethod void P3_Custom_URLTst(){
        
        Matter__c  mat = new Matter__c();
        mat.ConcourseMatterId__c = '123456T';
        mat.Matter_Name__c = 'Test';
        insert mat;
        
        Work_Product__c wp = new Work_Product__c();
        wp.Related_Matter__c = mat.id;
        wp.Concourse_MatterId__c = '99999';
        insert wp;
        
        Note nt = new Note();
        nt.Title = 'Test';
        nt.ParentId = wp.id;
        insert nt;
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/P3_Matternotes';  
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        
        List<P3_MatterNotes.LstMatter> amis = new List<P3_MatterNotes.LstMatter>();
        
        P3_MatterNotes.LstMatter ami = new P3_MatterNotes.LstMatter();
        ami.matterId= '123456T';
        amis.add(ami);
        
        P3_MatterNotes.displayNotes(amis,2);
    }
}