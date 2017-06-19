trigger Sendpassword on Contact (before update, before insert) {

string tokenM;
//if(trigger.isUpdate){

//for(Contact conn:Trigger.old){


for (Contact tpwd : Trigger.new) {
//Contact contacts = [select id,Accountid,leadsource,description from Contact where id in :connId];

if(tpwd.LeadSource=='Other' && tpwd.LeadSource !=Trigger.oldMap.get(tpwd.Id).LeadSource)
tpwd.Description ='Dhruvsoft.com';
if(tpwd.LeadSource=='Other' && tpwd.LeadSource ==Trigger.oldMap.get(tpwd.Id).LeadSource )
tpwd.Description ='Hello';
/*else
tpwd.Description ='Hii';*/
//newOpp.Title ='Senior Programmer'; 
//update newOpp;
}}