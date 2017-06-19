public with sharing class MassContactController {
    
    public List<Contact> Contacts { get; set; }
    public List<Contact> ContactsToInsert { get; set; }
    
    public MassContactController() {
        contacts = new List<Contact>();
        
        for (integer i = 0; i < 5; i++)
        {
            Contact newContact = new Contact();
            contacts.add(newContact);
        }
    }
    
    public PageReference Save() {
    
        for (Contact c : Contacts)
        {
            if (isValid(c))
                ContactsToInsert.add(c);
        }
        
        if (ContactsToInsert.size() > 0)
            insert ContactsToInsert;
        
        return null;
    }
    
    public boolean isValid(Contact c) {
        boolean retVal = false;
        
        if (c.LastName != null && c.Phone != null)
            retVal = true;
        
        return retVal;
    }

}