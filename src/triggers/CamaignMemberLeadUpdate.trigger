trigger CamaignMemberLeadUpdate on CampaignMember (after insert,after Update) {

for (CampaignMember camp: Trigger.new) {
 camp = [select id,status,leadid,Campaignid,Campaign.name from CampaignMember where id=:camp.id];
 List<Lead> led = [select id,name from Lead where id =:camp.LeadId]; 
 for(Lead l:led){
 l.Latest_Campaign__c =camp.Campaign.name;
 l.latest_Campaign_Id__c = camp.Campaignid;
 }
 update led;  
}
}