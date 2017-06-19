public class DeleteContacts{

  @InvocableMethod(label='Get Brass Cases Names' description='Returns the list of Brass Cases corresponding to the specified Brass Cases IDs.')
  public static void deleteAccountContacts(List<Id> AccountIds)
    {
        List<Contact> contacts =[SELECT Id FROM Contact WHERE AccountId=:AccountIds];
 
        delete contacts;
    }
}