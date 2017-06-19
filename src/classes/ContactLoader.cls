public class ContactLoader
{
    //It holdes the Content of the CSV File which you have uploaded.
    public transient String nameFile{get;set;}

    //Rendering pageblocks
    public boolean display{get;set;}
    public boolean records{get;set;}

    //Retrieve Content from the CSV File
    public Blob csvFile{get;set;}

    //Read Lines from the CSV File
    String[] filelines = new String[]{};

    //It hold List of Contact Records
    List<Account> contactInsert=new List<Account>();

    public ContactLoader()
    {
    display=true;
    records=false;
    }
    public Pagereference ReadFile()
    {
   
       display=false;
       records=true;
  
        if(csvFile!=null)
        {
        // Convert the Blob content to String
       nameFile=csvFile.toString();
       
       //Read the CSV Rows using split method
        filelines = nameFile.split('\n');
        }
        else
        {
        ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Please select a record to upload...!');
            ApexPages.addMessage(errormsg);
        }
   
      try
        {
      for (Integer i=1;i<filelines.size();i++)
        {
               
            String[] inputvalues = new String[]{};
        
            //Read multiple column values within the same row using split method
            inputvalues = filelines[i].split(',');
            Account cnt= new Account();
       
           // inputvalues[0] to inputvalues[3] holdes the index of the CSV file,Read and Map Field from CSV to Salesforce.
      
         //Note : If you want to insert Extra fields map those fields below and in your CSV file
      
            cnt.Name= inputvalues[0];
            //cnt.Description = inputvalues[1];
       
            //Add uploaded values into List
            contactInsert.add(cnt);
        }
   
        //insert your Contact Records into Salesforce
        insert contactInsert;
        }
        catch (Exception e)
        {
            //throw Error if user choosen invalid template
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Invalid template or file while processing your records...!');
            ApexPages.addMessage(errormsg);
        }
        return null;
    }

    public List<Account> getuploadedContacts()
    {

        //Below function return the inserted records in pageblock table
        set<id> recordid= new set<id>();
        for(Account ct:contactInsert)
        {
        recordid.add(ct.id);
        }
        list<Account> ctctlist=new list <Account>();
        ctctlist=[select Name,Id,Description from Account where id IN: recordid ];
        if (contactInsert!= NULL)
        {
            if (contactInsert.size() > 0)
                return ctctlist;

            else
                return null;
        }            
        else
        {
            return null;
        }
    }
    public pageReference refresh()
    {
       //redirect after pressed Go Back button
       PageReference pageRef= new PageReference('/apex/UploadContacts');
       pageRef.setRedirect(true);
       return pageRef;
     }
}