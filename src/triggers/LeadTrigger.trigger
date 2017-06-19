trigger LeadTrigger on Lead (after insert) {
    for(Lead led : trigger.new){
        List<CampaignMember> campMembs = [select id from CampaignMember where LeadId=:led.id];
        system.debug('campMembs>>>>'+campMembs);
    }
}