public with sharing class oppoconn {
    public Opportunity oppr{get;set;}
    public string strng{get;set;}
    public oppoconn(ApexPages.StandardController controller) {
        oppr = (Opportunity)controller.getRecord();
    }
    public  void docheck(){
        strng=oppr.name;
    }

}