trigger AccountTriggerFactory on Account (after delete, after insert, after update, before delete, before insert, before update)
{
    system.debug('Factory method');
    TriggerFactory.createHandler(Account.sObjectType);
}