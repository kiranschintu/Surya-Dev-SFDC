trigger CaseTrigger on Case (after insert,after update) {
    if(trigger.isInsert){
        List<Task> tasksToInsert = new List<Task>();
        for(Case ca:[select id,OwnerId,Owner.Type from Case where id IN:trigger.newMap.keySet()]){
            if(ca.Owner.Type=='User'){
                Task act = new Task();
                String subject = 'New Task';
                act.Subject =  subject;
                String description = subject + '. Click Related To link to view case details.';               
                //act.Description = description;
                act.ownerId = ca.ownerID;
                act.Status = 'Not Started';
                act.whatId = ca.id;
                
                tasksToInsert.add(act);
            }
        }
        if(!tasksToInsert.isEmpty()){
            insert tasksToInsert;
        }
    }
    if(trigger.isUpdate){
        List<Task> tasksToUpsert = new List<Task>();
        Map<Id,Case> caseIdsMap = new Map<Id,Case>();
        Map<Id,Task> caseIdsTaskMap = new Map<Id,Task>();//Storing case id's which contains tasks
        
        List<Case> cases = [select id,OwnerId,Owner.Type from Case where id IN:trigger.newMap.keySet()]; 
        //Checking whether Case ownerId is changed or not
        for(Case ca:cases){
            if(ca.Owner.Type=='User' && ca.OwnerId!=trigger.oldMap.get(ca.id).OwnerId){
                caseIdsMap.put(ca.id,ca);
            }
        }
        system.debug('caseIdsMap>>>'+caseIdsMap);
        if(!caseIdsMap.isEmpty()){
            for(Task tas:[Select id,OwnerId,WhatId from Task where Status!='Completed' AND What.Type='Case' AND WhatId IN:caseIdsMap.keySet() order by CreatedDate]){
                caseIdsTaskMap.put(tas.WhatId,tas);  
            }
            system.debug('caseIdsTaskMap>>>'+caseIdsTaskMap);
        
            for(Case ca:cases){
                if(caseIdsTaskMap.containsKey(ca.id)){
                    Task tas = caseIdsTaskMap.get(ca.id);
                    tas.OwnerId = ca.OwnerId;
                    tasksToUpsert.add(tas);
                }else{
                    Task act = new Task();
                    String subject = 'New Task';
                    act.Subject =  subject;
                    String description = subject + '. Click Related To link to view case details.';               
                    //act.Description = description;
                    act.ownerId = ca.ownerID;
                    act.Status = 'Not Started';
                    act.whatId = ca.id;
                    
                    tasksToUpsert.add(act);
                }
            }
            
            system.debug('tasksToUpsert>>>'+tasksToUpsert);
        
            if(!tasksToUpsert.isEmpty()){
                upsert tasksToUpsert;
            }
        }
    }
}