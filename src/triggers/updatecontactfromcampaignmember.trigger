trigger updatecontactfromcampaignmember on CampaignMember (after insert,after update) {

Set<Id> cmIds = new Set<Id>();

List<CampaignMember> cmm= trigger.new;
for(CampaignMember cm:cmm){


   cmIds.add(cm.ContactId);
    
}
List<contact> con = [select id,Is_New_as_Latest_Campaign_Member__c from contact where id IN :cmIds];

for(CampaignMember cm:cmm){
for(Contact conn:con){
if(cm.status == 'Sent'){
conn.Is_New_as_Latest_Campaign_Member__c = true;
}

}
}
update con;


}