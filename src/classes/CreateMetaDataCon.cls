public with sharing class CreateMetaDataCon {

    //Getting Session Id
    public MetadataService.MetadataPort GenerateSessionId(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    //Creating Custom Field on Test Object
    public void CreateCustomField(){
        
        MetadataService.MetadataPort service = GenerateSessionId();
        
        string field1 = 'Field1';
        MetadataService.CustomField customfield = new MetadataService.CustomField();
        customfield.fullName = 'Test__c.'+field1+'__c';
        customfield.label = field1;
        customfield.type_x = 'Text';
        customfield.length = 20;
        customfield.profilesets = new MetadataService.Profile();
        customfield.profilesets.type = 'Profile';
        customfield.profilesets.fullName = 'Admin';
        customfield.profilesets.fieldPermissions = new List<MetadataService.ProfileFieldLevelSecurity>();
        customfield.profilesets.fieldPermissions[0].editable = true;
        customfield.profilesets.fieldPermissions[0].field = customfield.fullName;
        customfield.profilesets.fieldPermissions[0].readable = true;
        

        List<MetadataService.SaveResult> results =      
                service.createMetadata(
                    new MetadataService.Metadata[] { customfield });

        
        
    }
    
    public void ApplyFieldLevelSecurity(){
        
        MetadataService.MetadataPort service = GenerateSessionId();
        
        String field1 = 'Field1';
        MetadataService.ProfileFieldLevelSecurity pfs = new MetadataService.ProfileFieldLevelSecurity();
        pfs.editable = true;
        pfs.field = 'Test__c.'+field1+'__c';
        pfs.readable = true;
        
        List<MetadataService.ProfileFieldLevelSecurity> pfss = new List<MetadataService.ProfileFieldLevelSecurity>();
        pfss.add(pfs);
         
        
        MetadataService.Profile pf = new MetadataService.Profile();
        pf.fieldPermissions = pfss;
        pf.type = 'Profile';
        pf.fullName = 'Admin';
            
            
        List<MetadataService.SaveResult> rs = service.updateMetadata(new MetadataService.Metadata[] { pf });
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            /****
            Field Creations and Profile Access
        ****/   
        /*
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();

        string field1 = 'Field1';
        MetadataService.CustomField customfield = new MetadataService.CustomField();
        customfield.fullName = 'Test__c.'+field1+'__c';
        customfield.label = field1;
        customfield.type_x = 'Text';
        customfield.length = 20;
        customfield.

        MetadataService.ProfileFieldLevelSecurity pfs = new MetadataService.ProfileFieldLevelSecurity();
        pfs.editable = true;
        pfs.field = 'Test__c.'+field1+'__c';
        pfs.readable = true;
        
        List<MetadataService.SaveResult> results =      
                service.createMetadata(
                    new MetadataService.Metadata[] { customfield });

        List<MetadataService.ProfileFieldLevelSecurity> pfss = new List<MetadataService.ProfileFieldLevelSecurity>();
        pfss.add(pfs);
            
        MetadataService.Profile pf = new MetadataService.Profile();
        pf.fieldPermissions = pfss;
        pf.type = 'Profile';
        pf.fullName = 'Admin';
            
            
        List<MetadataService.SaveResult> rs = service.updateMetadata(new MetadataService.Metadata[] { pf });
        */

        /****
            Field Deletion
        ****/
        /*
        String delfield = 'Field1';
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();

        String delfield1 = 'Test__c.'+delfield+'__c';
        String[] fullNamess = new String[]{delfield1};
        String type_x = 'CustomField';

        List<MetadataService.DeleteResult> results =     
                     service.deleteMetadata('CustomField',fullnamess);   
                     system.debug('@@@'+results);
        */
        /****
            Field Update
        *****/
        /*
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();      
            
        MetadataService.CustomField customfield = new MetadataService.CustomField();
        customfield.fullName = 'Test__c.FieldNew1__c';
        customfield.label = 'FieldNew4';
        customfield.type_x = 'Text';
        customfield.length = 20;

        List<MetadataService.SaveResult> results =     
                     service.updateMetadata(new MetadataService.Metadata[] { customfield });   
                     system.debug('@@@'+results);

        for(MetadataService.SaveResult res : results){
            if(res.Success)
            system.debug('Success Result ::'+res.fullName);
            else
                system.debug('Error Result ::'+res.fullName);
        }
        */

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}