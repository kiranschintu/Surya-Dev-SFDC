public class AccountSharing {
    public static boolean manualShareRead(){
        //Create new sharing object for the custom object Job.
        Account acc = [select id,name from Account where id='0019000000CJMV1'];
        AccountShare jobShr = new AccountShare();
        jobShr.AccountId=acc.id;
        //Set the portal user Id to share the accounts with
        jobShr.UserOrGroupId='00590000003iVAf';
        jobShr.AccountAccessLevel='Read';
        jobShr.OpportunityAccessLevel='Read';
        jobShr.CaseAccessLevel='Read';
        
        insert jobShr;
        return true;
    }
}