public class BriteVerifyContactHandler{
    public static boolean isRecursive=true;  //Static variable to stop recursive trigger
    /* Prepare the bulk records and pass to future method as chunks
        No of future calls will be limited, So avoiding the transaction using limits.getLimitfuturecallout method
    */      
    public static void prepareCalloutBatches(List<Contact> Contacts,Map<id,Contact> oldMap,boolean isInsert,boolean isUpdate){
        List<Contact> verifyContacts = new List<Contact>();
        List<Contact> resetContacts = new List<Contact>();//to reset briteverify data
        isRecursive=false;
        //For new contact records        
        if(isInsert==true && !Contacts.isEmpty()){
            //for new contacts
            for(Contact con:Contacts){
                if(con.Email!=null){
                    verifyContacts .add(con);
                }
            }
        }
        //For update existing records        
        if(isUpdate==true && !Contacts.isEmpty() && !oldMap.isEmpty()){
            for(Contact con:Contacts){
                system.debug('Email Verify'+con.email);
                
                if(con.Email!=oldMap.get(con.id).Email && con.Email!=null){
                    system.debug('Email Changed'+con.email);
                    verifyContacts.add(con);
                    //reset BriteVerify data for contact before the API Callout
                    Contact resetContact = resetBriteFields(con.id);
                    resetContacts.add(resetContact);
                }else if(con.Email==null){
                    //reset BriteVerify data for contact
                    Contact resetContact = resetBriteFields(con.id);
                    resetContacts.add(resetContact);
                }
            }
        }
        
        if(!resetContacts.isEmpty()){
            resetBriteVerify(resetContacts);
        }
        
        if(!verifyContacts.isEmpty()){
            Integer k=0;
            /* Making future callouts based on limitation(Limits.getLimitFutureCalls())
              For each future call 100 records chunks will be pass
            */            
            for(Integer i=0;i<Limits.getLimitFutureCalls();i++){
                Integer j=Limits.getLimitCallouts()-21;
                Integer m=0;
                    
                List<Contact> verifyContactsChunk = new List<Contact>();
                for(Integer l=k; l<verifyContacts.size();l++){
                    verifyContactsChunk.add(verifyContacts[l]);
                    
                    m++;
                    if(m==j || verifyContacts.size()-1==l){

                        // Serialize the list of contacts and pass to the future method 
                        String verifyContactsStr = JSON.serializePretty(verifyContactsChunk);
                        //Pass 100 per chunk based on callouts limitation
                        doCallout(verifyContactsStr);
                        
                        verifyContactsChunk = new List<Contact>();
                        k=l+1;
                        break;
                    }
                    if(i==verifyContacts.size()){
                        break;
                    }   
                }
            }
        }
    } 

    @future(callout=true)
    public static void doCallout(String verifyContacts){
        //Deserialize the list and cast it to Contact list.
        list<Contact> verifyContactList =  (list<Contact>)JSON.deserializeStrict(verifyContacts, list<Contact>.class);
        if(!verifyContactList.isEmpty()){
            for(contact con : verifyContactList ){
                //calling BriteverifyImplementation class
                BriteVerifyService ob = new BriteVerifyEmailServiceImpl();
                //Verify the email by calling the below webservice method and update the contact fields
                BriteVerifyServiceResponse  result = ob.getEmailVerificationStatus(con.Email);
                //setting valid status
                
                con.Email_Verification_Result__c = result.procesStatus(result.status);
                con.Email_Is_Disposable__c = result.disposable == true ? true : false;
                con.Email_Is_Role_Address__c = result.role_address == true ? true : false;
                con.Email_Verification_Date__c = System.now();  //Maintain the time stamp
                
                system.debug('Web service Response is:'+result);
            }
            update verifyContactList;
        }
    }
    
    public static void resetBriteVerify(List<Contact> resetContacts){
        try{
            update resetContacts;
        }catch(Exception e){
            system.debug('Error :'+e.getmessage());
        }
    }
    
    public static Contact resetBriteFields(id conId){
        Contact updCon = new Contact();
        updCon.id = conId;
        updCon.Email_Verification_Result__c = '';
        updCon.Email_Is_Disposable__c = false;
        updCon.Email_Is_Role_Address__c = false;
        updCon.Email_Verification_Date__c = null;
        return updCon;
    }
}