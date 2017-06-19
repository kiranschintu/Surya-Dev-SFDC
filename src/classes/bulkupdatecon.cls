public with sharing class bulkupdatecon {

    public bulkupdatecon(ApexPages.StandardController controller) {

    }


    public List<Account> leads{get;set;}
    public bulkupdatecon(ApexPages.StandardSetController controller) {
    leads = (List<Account>)controller.getrecords();
    }

}