public class overridingcon {
    public overriding__c over;
    
    public overridingcon(ApexPages.StandardController controller) {
         this.over = (overriding__c)controller.getRecord();
    }

}