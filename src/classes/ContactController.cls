public class ContactController {
@AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts = 
                [SELECT Id, Name, MailingStreet, Phone, Email,dhr__Level__c FROM Contact];
        return contacts;
    }
    
    @AuraEnabled
    // Retrieve all primary contacts
    public static List<Contact> getPrimary() {
        List<Contact> primaryContacts = 
             [SELECT Id, Name, MailingStreet, Phone, Email,dhr__Level__c FROM Contact where dhr__Level__c='Primary'];
        return primaryContacts;
    }
}