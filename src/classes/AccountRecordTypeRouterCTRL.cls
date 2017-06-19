public class AccountRecordTypeRouterCTRL {

    public AccountRecordTypeRouterCTRL(ApexPages.StandardController controller) {

    }
    @RemoteAction
    public static string navigate(string recordTypId){
    string Url;
    
       // String recordTypId = ApexPages.currentPage().getParameters().get('RecordType');
        if(recordTypId=='01290000000kSIC'){
           // Url = '/001/e?retURL=%2F001%2Fo&RecordType=01290000000kSIC&ent=Account&nooverride=1';
            Url = '/001/e?retURL=%2F001%2Fo&RecordType=01290000000kSIC&ent=Account&nooverride=1';
        }else if(recordTypId=='01290000000kSIH'){
            Url = '/apex/insertaccount?RecordType=01290000000kSIH';
        }
        
        return Url;
    }
    
   
}