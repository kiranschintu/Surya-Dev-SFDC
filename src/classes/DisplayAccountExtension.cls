public class DisplayAccountExtension {
    Account acc;
    public DisplayAccountExtension(ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
    }
    
    public pageReference findUser(){
        String lastName = Userinfo.getLastName();
        if(lastName!='chintu'){
            PageReference pg = new PageReference('/apex/AccountDetail?id='+acc.id);
            return pg;
        }else{
            PageReference pg = new PageReference('/apex/disp');
            return pg;
        }
    }

}