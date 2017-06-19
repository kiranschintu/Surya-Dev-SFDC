trigger opprole on Opportunity (after update) {
for (Opportunity acc : Trigger.New) {
    //Call future method to update account
    //with data from external server.
    //This is a async calls, it returns right away, after
    //enqueuing the request.
    VfOppContactRoleControllers.updatePrimaryContact(acc.Id);
    
  }
}