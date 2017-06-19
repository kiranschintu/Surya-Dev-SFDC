public class idmeVerificationController{

    private ApexPages.StandardController stdController {get; set;}
    public Flow.Interview.ID_me_Verification myVerify {get; set;}

    public idmeVerificationController (ApexPages.StandardController std){
        stdController = std;
        Contact cont = [select name,AccountId from contact where id = :stdController.getID() limit 1];
        String fName = cont.Name.substring(0, cont.name.indexof(' '));
        String lName = cont.Name.substring(cont.name.indexof(' ')+1);
        
        Map<String, Object> myMap = new Map<String, Object>();
        myMap.put('cFirstName', fName);
        myMap.put('cLastName', lName);
        myMap.put('contactID', cont.Id);
        myMap.put('AccountID',cont.AccountId);
        System.debug(myMap);
        myVerify = new Flow.Interview.ID_me_Verification(myMap);
    }

        
    public PageReference getFinishPage(){
        System.debug('contact id: ' + stdController.getID());
        return new PageReference('/' + stdController.getID());
    }
}