/*
    Handle Brite Verify Response
*/
public class BriteVerifyServiceResponse{
    public String address;
    public String account;
    public String domain;
    public String status;
    public String connected;
    public Boolean disposable;
    public Boolean role_address;
    public String error_code;
    public String error;
    public String duration;
    
    public String procesStatus(String status){
        String finalStatus;
        if(status=='valid'){
            finalStatus = 'Valid';
        }else if(status=='invalid'){
            finalStatus = 'Invalid';
        }else if(status=='accept_all'){
            finalStatus = 'Accept All';
        }else if(status=='unknown'){
            finalStatus = 'Unknown';
        }
        return finalStatus;
    }
}