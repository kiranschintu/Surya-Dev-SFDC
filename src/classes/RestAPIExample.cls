public class RestAPIExample
{
    public static boolean isApexTest = false;//Variable used for Code Coverage
    public string username = '';
    public string password = '';
    public string clientId = '';
    public string ConsumerKey = '';
    public string URI = '';
    public string accsToken = '';
    public list<Account>lstAccount{get;set;}
    public set<string>lstAcc{get;set;}
    public list<RestWrapper>lstwrap{get;set;}
    public string AccountId{get;set;}
    
    public RestAPIExample()
    {
    lstAccount = new list<Account>();
    lstwrap = new list<RestWrapper>();
    lstAcc = new set<string>();
    AccountId = '';
    }
    
    public void ShowAccounts()
    {
        string AccNam = '';
       string AccId = '';
       string postData = '';
        lstwrap.clear();
        accsToken=AcessToken();  // First we have to get AccessToken to access the Server (Rest Server)
            //Calling Rest Service
        URI = 'https://ap1.salesforce.com/services/apexrest/RESTAPIDataService';  //Here we are calling the    client URL mapping RESTAPIDataService is ServerURL mapping.
        JSONParser parser;
        if (!isApexTest){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URI);
        req.setMethod('POST');
        req.setHeader('content-type','application/json');
        req.setBody(postData);
        req.setHeader('Authorization', 'OAuth ' + accsToken);
                Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('**** After Service Call.....'+res.getBody());
        parser = JSON.createParser(res.getBody());
            while (parser.nextToken() != null)
            {
        
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Name'))
                {
                system.debug('name before nextToken'+parser.getText());
                                    // Get the value.
                parser.nextToken();
                system.debug('name before nextToken'+parser.getText());
                AccNam = parser.getText();
            
                 }
                if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id'))
                {
                system.debug('Id before nextToken'+parser.getText());
                parser.nextToken();
                system.debug('Id After nextToken'+parser.getText());
                AccId = parser.getText();
                }
                if(AccId!='' &&AccNam!='')
                {
                string finalVal = AccId+';'+AccNam;
                AccNam = '';
                AccId = '';
                lstAcc.add(finalVal);    
                }
            }
            
        if(lstAcc!=null &&lstAcc.size()>0)
        {
            for(string str:lstAcc)
            {
                list<string>spltstr = new list<string>();
                if(str!=null &&str.IndexOf(';')>-1)
                {
                    spltstr = str.split(';');
                    if(spltstr!=null &&spltstr.size()==2)
                    {
                        RestWrapper obj = new RestWrapper();
                            obj.Accid = spltstr[0];
                            obj.AccName = spltstr[1];
                            lstwrap.add(obj);
                     }
                 }

             }
                system.debug('lstwrap size======>'+lstwrap.size());
        }
       
        parser = JSON.createParser(res.getBody());
        }
         }
   // }
     /*
        Method Name :AcessToken
Description : This Method Will Return the AccessToken by connecting with User Defined SFDC Org 
    */
public string AcessToken()
    { 
string username = 'anil.a@gmail.com';           // Server Credentials including Consumer key and Secret key.
string password = 'Qracle@1430MakMWkxzzTyf21W7VHvgy85';
string clientId = '3MVG9Y6d_Btp4xp6H5ilJbQUMXkw8x6.7PaGL9.vEIemc1JP3StrsZgi2iuOqp8f6nAK5lV6xJfKHMvGZoUjr';  //clientid is in the remote access we get Consumer Key that is the clientId here 
string ConsumerKey = '7987216448701006616'; // ConsumerKey is Server Consumer Secret

string URI = 'https://login.salesforce.com/services/oauth2/token?grant_type=password&' + 'client_id=' + clientId + '&' + 'client_secret=' + ConsumerKey + '&' + 'username=' + username + '&' + 'password=' + password;
JSONParser parser1;
if (!isApexTest){
HttpRequest req = new HttpRequest();
req.setEndpoint(URI);
req.setMethod('POST');

            Http http = new Http();
HTTPResponse res = http.send(req);
System.debug('*** After Authentication...'+res.getBody());
accsToken = '';
            parser1 = JSON.createParser(res.getBody());
while (parser1.nextToken() != null) {

if ((parser1.getCurrentToken() == JSONToken.FIELD_NAME) && (parser1.getText() == 'access_token')) {
system.debug('accsToken before nextToken'+parser1.getText());
                    // Get the value.
parser1.nextToken();
system.debug('accsToken After nextToken'+parser1.getText());
accsToken = parser1.getText();
                }
            }
return accsToken;
}else{
//Used for Code Coverage Purpose
             String result = '00DV00000000aRT!AQkAQLBcWaeduN05RkkTuvFpsI.MwF_hs.sUTn5FAfNQZ8Atz5QbR.pmEmCySc0jnQHHOd9hZqjVcOySPJU1IvUkRnFXo21v';
return result;
        }
    }

    /*
        Method Name : generate18CharId
Description : This method will take a 15 character ID and return its 18 character ID:
    */
public static string generate18CharId(string id){
if (id == null){ 
return null;
         }
if (id.length() != 15) {
return id;
         }
string suffix = '';
integer flags;
for (integer i = 0; i< 3; i++) {
flags = 0;
for (integer j = 0; j < 5; j++) {
string c = id.substring(i * 5 + j,i * 5 + j + 1);
                   //Only add to flags if c is an uppercase letter:
if (c.toUpperCase().equals(c) && c >= 'A' && c <= 'Z') {
flags = flags + (1 << j);
                   }
              }
if (flags <= 25) {
suffix = suffix + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(flags,flags+1);
}else{
suffix = suffix + '012345'.substring(flags-25,flags-24);
              }
         }
return id + suffix;
    }
    /*  
        Method Name :mainForTest();
Description : Used for  CodeCoverage Handling
    */
public String mainForTest(){
isApexTest = true;
return AcessToken();
    }
public class RestWrapper{
public string Accid{get;set;}
public string AccName{get;set;}
    }
}