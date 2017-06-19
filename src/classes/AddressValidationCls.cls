public with sharing class AddressValidationCls {
    public Account account;
    public static boolean isRecursiveStop=true;//to stop recursive triggers
    public boolean refreshPage{get;set;}
    
    public AddressValidationCls(ApexPages.StandardController controller) {
        account = (Account)controller.getRecord();
        refreshPage=false;
        account = [select id,ShippingStreet,ShippingCity,ShippingState,ShippingPostalcode,BillingStreet,BillingCity,BillingState,BillingPostalCode,USPS_Shipping_Address_Validated__c from Account where id=:account.id];
    }
    
    public PageReference DoCallout(){
        System.debug('AccuntID>>>'+account.Id);
        String accountIdparm = ApexPages.currentPage().getParameters().get('id');
        System.debug('accountIdparm $$$'+accountIdparm);
        /*if(accountIdparm!=null){
        account = [select id,ShippingStreet,ShippingCity,ShippingState,ShippingPostalcode,BillingStreet,BillingCity,BillingState,BillingPostalCode,USPS_Shipping_Address_Validated__c from Account where id=:accountIdparm];
        }*/
        if(account.Id!=null){
            List<USPSAddressResponse> USPSAddressResp = new List<USPSAddressResponse>();
            if((account.ShippingStreet!=null && account.ShippingStreet!='') || (account.ShippingCity!=null && account.ShippingCity!='') || (account.ShippingState!=null && account.ShippingState!='') || (account.ShippingPostalcode!=null && account.ShippingPostalcode!='') || (account.BillingStreet!=null && account.BillingStreet!='') || (account.BillingCity!=null && account.BillingCity!='') || (account.BillingState!=null && account.BillingState!='') || (account.BillingPostalCode!=null && account.BillingPostalCode!='')){
                USPSAddressResp = USPSAddressCallout.MakeCallout(account);  
            }
            if(!USPSAddressResp.isEmpty()){
                for(USPSAddressResponse uspsAdd : USPSAddressResp){
                    if(uspsAdd.addressType=='Service'){
                        if(uspsAdd.isNotValid==true){
                            account.USPS_Shipping_Address_Validated__c = false;
                        }else{
                            account.USPS_Shipping_Address_Validated__c = true;
                            account.ShippingStreet = uspsAdd.USPSAddress.street;
                            account.ShippingCity = uspsAdd.USPSAddress.city;
                            account.ShippingState = uspsAdd.USPSAddress.state;
                            account.ShippingPostalcode = uspsAdd.USPSAddress.zip5;
                        }
                    }else if(uspsAdd.addressType=='Billing'){
                        if(uspsAdd.isNotValid==true){
                            account.USPS_Billing_Address_Validated__c = false;
                        }else{
                            account.USPS_Billing_Address_Validated__c = true;
                            account.BillingStreet = uspsAdd.USPSAddress.street;
                            account.BillingCity = uspsAdd.USPSAddress.city;
                            account.BillingState = uspsAdd.USPSAddress.state;
                            account.BillingPostalCode = uspsAdd.USPSAddress.zip5;
                        }
                    }
                }
                Update account;
            }
        }
        /*system.debug('Hello stopReload');
        ReloadOnce__c reld = ReloadOnce__c.getOrgDefaults();
        if(reld.dhr__ISReload__c!=true){
            reld.dhr__ISReload__c=true;
            upsert reld;
        }*/
        //Update account;
        
        /*PageReference pg = new PageReference('/apex/TermsAndConditionsResult');//new ApexPages.StandardController(account).view();
        pg.setRedirect(true);
            
        String mainURL = controller.view().getUrl();
        String mainURL1 = ApexPages.currentPage().getHeaders().get('referer');
        system.debug('Main URL>>>'+mainURL+'@@@'+mainURL1);
        system.debug('onTimeRefresh>>>'+onTimeRefresh);
        if(mainURL1!=null){
            return null;    
        }else{
            return pg;
        }*/
        //ReloadFuture.dosome();
        refreshPage=true;
        return null;
        
    }
    
    public void stopReload(){
        system.debug('Hello stopReload');
        ReloadOnce__c reld = ReloadOnce__c.getOrgDefaults();
        if(reld.dhr__ISReload__c!=true){
            reld.dhr__ISReload__c=true;
            upsert reld;
        }
        ReloadFuture.dosome();
    }
    
    public void changeHSetting(){
        ReloadFuture.dosome();
    }
    
    @future(callout=true)
    public static void DoCalloutFrmTrig(Set<id> accIds){
        List<Account> accounts = [select id,ShippingStreet,ShippingCity,ShippingState,ShippingPostalcode,BillingStreet,BillingCity,BillingState,BillingPostalCode,USPS_Shipping_Address_Validated__c from Account where id IN:accIds];
        List<Account> accountsToUpdate = new List<Account>();
        try{
            for(Account acc : accounts ){
                List<USPSAddressResponse> USPSAddressResp = new List<USPSAddressResponse>();
                Account oldAccount = new Account();
                //make the callout
                USPSAddressResp = USPSAddressCallout.MakeCallout(acc);  
                
                if(!USPSAddressResp.isEmpty()){
                    for(USPSAddressResponse uspsAdd : USPSAddressResp){
                        //assign original(callout) address to account record address
                        if(uspsAdd.addressType=='Service'){
                            if(uspsAdd.isNotValid==true){
                                acc.USPS_Shipping_Address_Validated__c = false;
                            }else{
                                acc.USPS_Shipping_Address_Validated__c = true;
                                acc.ShippingStreet = uspsAdd.USPSAddress.street;
                                acc.ShippingCity = uspsAdd.USPSAddress.city;
                                acc.ShippingState = uspsAdd.USPSAddress.state;
                                acc.ShippingPostalcode = uspsAdd.USPSAddress.zip5;
                            }
                        }else if(uspsAdd.addressType=='Billing'){
                            if(uspsAdd.isNotValid==true){
                                acc.USPS_Billing_Address_Validated__c = false;
                            }else{
                                acc.USPS_Billing_Address_Validated__c = true;
                                acc.BillingStreet = uspsAdd.USPSAddress.street;
                                acc.BillingCity = uspsAdd.USPSAddress.city;
                                acc.BillingState = uspsAdd.USPSAddress.state;
                                acc.BillingPostalCode = uspsAdd.USPSAddress.zip5;
                            }
                        }
                    }
                    accountsToUpdate.add(acc);
                }
            }
            if(!accountsToUpdate.isEmpty()){
                isRecursiveStop=false;//stopping recursive trigger
                //updating accounts with callout address received by USPS
                update accountsToUpdate;
            }
        }catch(Exception e){
            system.debug('Error :'+e.getMessage());
        }
    }
    
    /*
        @ For Existing Records - Identifying the Account records whose Service or Biling Address fields are changed
        @ For New Records - At least one address fields has to be fill
    */ 
    public static void isAddressChanged(Map<Id,Account> newAccs,Map<Id,Account> oldAccs,boolean isInsert,boolean isUpdate){
        Set<Id> calloutAccIds = new Set<Id>();
        if(!newAccs.isEmpty()){
            for(Account acc:newAccs.values()){
                Account oldAccount = new Account();
                oldAccount = oldAccs.containsKey(acc.id) ? oldAccs.get(acc.id) : new Account();
                //checking for atleast one address field in service address and billing address
                if((acc.ShippingStreet!=null && acc.ShippingStreet!='') || (acc.ShippingCity!=null && acc.ShippingCity!='') || (acc.ShippingState!=null && acc.ShippingState!='') || (acc.ShippingPostalcode!=null && acc.ShippingPostalcode!='') || (acc.BillingStreet!=null && acc.BillingStreet!='') || (acc.BillingCity!=null && acc.BillingCity!='') || (acc.BillingState!=null && acc.BillingState!='') || (acc.BillingPostalCode!=null && acc.BillingPostalCode!='')){
                    //checking, if service address is changed or not - only for existing records
                    if(isInsert!=true && isUpdate==true){
                        if( ( acc.ShippingStreet!=oldAccount.ShippingStreet || acc.ShippingCity!=oldAccount.ShippingCity || acc.ShippingState!=oldAccount.ShippingState || acc.ShippingPostalcode!=oldAccount.ShippingPostalcode ) || ( acc.BillingStreet!=oldAccount.BillingStreet || acc.BillingCity!=oldAccount.BillingCity || acc.BillingState!=oldAccount.BillingState || acc.BillingPostalCode!=oldAccount.BillingPostalCode )){
                            calloutAccIds.add(acc.id);
                        }
                    }else{
                        //for newly created records
                        calloutAccIds.add(acc.id);
                    }
                }
            }
        }
        
        if(!calloutAccIds.isEmpty()){
            //Passing only address changed account for address validation
            MakingLimitedCallouts(calloutAccIds);
        }
    }
    
    //To avoid To Many Callouts Excepion - Number callouts is 100 per transaction as of now Spring 15
    public static void MakingLimitedCallouts(Set<Id> calloutAccIds){
        Integer numOfRecords = calloutAccIds.isEmpty() ? 0 : calloutAccIds.size();
        if(numOfRecords!=0 && numOfRecords<100){
            Set<Id> calloutNewAccIds = new Set<Id>(); 
            Integer i=0;
            Integer j=0;
            for(Id aId :calloutAccIds){
                i++;
                j++;
                calloutNewAccIds.add(aId);
                if( ( i==100 || j==numOfRecords ) && ( Limits.getLimitFutureCalls() > Limits.getFutureCalls()) ){
                    DoCalloutFrmTrig(calloutAccIds);
                    calloutNewAccIds.clear();
                    i=0;
                }
            }
        }
    }
}