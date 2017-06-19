/* Job notification mails*/
Public class BatchNotifications{
    Public static void emailNotifications(database.batchableContext BC, string oppType,String batchClassName,Map<String,String> failedRecordIds){
        //AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()]; 
        if(failedRecordIds.size()>0){           
            string header ='Record Id '+','+'Status Message'+'\n';
            String finalstr = header;
            for(String recId:failedRecordIds.keySet()){
                String Recordstring = recId+','+failedRecordIds.get(recid)+'\n';
                finalstr = finalstr+Recordstring;
            }        
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            blob excel = blob.valueOf(finalstr);
             
            attach.setBody(excel);
            attach.setFileName('FailedRecords.csv');
            String subject = 'Failed Records in : '+batchClassName;
            String  body = 'This file is generated using Records failed in Batch';        
            
            // Send an email to the Apex job's submitter notifying of job completion. 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            List<String> toAddresses = new List<String>();
            List<Batchnotificationemails__c> bnotemails = Batchnotificationemails__c.getall().values();
            for(Batchnotificationemails__c bne:bnotemails){
                if(bne.Email__c!=null && oppType == 'PSS' && bne.Is_PSS__c == true){
                    toAddresses.add(bne.Email__c);
                }else if(bne.Email__c!=null && oppType == 'Sales' && bne.Is_Sales__c == true){
                    toAddresses.add(bne.Email__c);
                }else if(bne.Email__c!=null && oppType == 'UW' && bne.Is_UW__c == true){
                    toAddresses.add(bne.Email__c);
                }else if(bne.Email__c!=null && oppType == 'All'){
                    toAddresses.add(bne.Email__c);
                }
                
            }
            mail.setToAddresses(toAddresses); 
            mail.setSubject(subject);
            mail.setPlainTextBody(body);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
    Public static Map<String,String> fetchSaveResults(Database.SaveResult[] saveResults){
        Map<String,String> recMap = new Map<String,String>();
        System.debug('Save results******'+saveResults);
        for (Database.SaveResult savRslt : saveResults){
            if(!savRslt.isSuccess()){//only look at failures, or NOT Successes
              system.debug(savRslt.getErrors());
              // Failed
                for(Database.Error error : savRslt.getErrors()){
                    System.debug('Something went wrong with the record ID ' + savRslt.getId() + ' : ' + error.getStatusCode() + ' - ' + error.getMessage());
                   recMap.put(savRslt.getId(),error.getStatusCode() + ' - ' + error.getMessage());  
                }
            }
        }
        return recMap;
    }
   Public static Map<String,String> fetchDeleteResults(Database.DeleteResult[] deleteResults){
        Map<String,String> recMap = new Map<String,String>();
        for (Database.DeleteResult delRslt : deleteResults){
            if(!delRslt.isSuccess()){//only look at failures, or NOT Successes
              system.debug(delRslt.getErrors());
              // Failed
                for(Database.Error error : delRslt.getErrors()){
                    System.debug('Something went wrong with the record ID ' + delRslt.getId() + ' : ' + error.getStatusCode() + ' - ' + error.getMessage());
                   recMap.put(delRslt.getId(),error.getStatusCode() + ' - ' + error.getMessage());  
                }
            }
        }
        return recMap;
    }    
}