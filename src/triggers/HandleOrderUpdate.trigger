trigger HandleOrderUpdate on Invoice_Statement__c (after update) {
Map<ID, Invoice_Statement__c> oldMap = new Map<ID,
Invoice_Statement__c>(Trigger.old);
// Make a list of invoice IDs to post, so we can do it in one hit
List<Id> invoiceIds = new List<Id>();
for (Invoice_Statement__c invoice: Trigger.new) {
// Only post order when status is changing from not closed to closed
if (invoice.status__c == 'Closed' && oldMap.get(invoice.Id).status__c != 'Closed'){
invoiceIds.add(invoice.Id);
}
}
if (invoiceIds.size() > 0) {
Integration.postOrder(invoiceIds);
}
}