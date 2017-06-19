public with sharing class jsvariblefromApex1con {

    public List<WrapperFileStatus> lstFileStatus{get;set;}//Used to display the status of Price List preparation
    public List<WrapperFileStatus> lstOutput{get;set;}//Used to display the status of output file
    public List<WrapperFileStatus> lstOutputfinal{get;set;}//Used to display the status of output file
    //public boolean outputRendered{get;set;}//Used to render the proceed to next button in USGD Shipment pageblock
    //public boolean foutputRendered{get;set;}//Used to render the proceed to next button in LAPL Include pageblock
    
    public String filename{get;set;}//Used to get the file name
    public String FileData{get;set;}//Used to get the file data
    
    public Boolean isVsbPopup { get; set; }
    public Boolean isPoller { get; set; }
    public string selectedFile{get;set;}
    public Boolean loading{get;set;}
    
    public jsvariblefromApex1con ()
    {
        getStatuses();
    }
    
    public void getStatuses()
    {
        lstOutput=new List<WrapperFileStatus>();
        lstOutputfinal=new List<WrapperFileStatus>();
                    lstOutput.add(new WrapperFileStatus('Import of USGD Shipment File','Not yet Started','csv','',system.today()));
     
        
        
        
    }
    //used to display the data in page. 
    public class WrapperFileStatus
    {
        public string fileName{get;set;}
        public string fileStatus{get;set;}
        public string fileMsg{get;set;}
        public string fName{get;set;}
        public datetime fcreateddate{get;set;}
        public WrapperFileStatus(string fName1,string fst,string fnm,string fm,datetime fd)
        {
            fileName=fName1;
            fileStatus=fst;
            fName=fnm;
            fileMsg=fm;
            fcreateddate=fd;
            system.debug('fName##'+fName+'@@@'+fileName);
        }
    }
    
    public Pagereference importFiles()
    {
        isVsbPopup =true;
        //loading=true;
        return null;
    }
    public pagereference closePopup(){
        isVsbPopup =false;
        return null;
    }
    //Passing csv file data to batch class
    public pagereference executebatch(){
        //loading=true;
        system.debug('selectedFile@@'+selectedFile+'filename@@'+filename+'isVsbPopup$$'+isVsbPopup);
        if(selectedFile=='Import of USGD Shipment File')
        {
            
        }
        else if(selectedFile=='Import of LAPL Include File')
        {
            
        }
        
        isVsbPopup =false;
        isPoller=true;
        FileData='';
        return null;
    }
    public pagereference pollerMethod(){ 
        isPoller=true;
        system.debug('selectedFile@@'+selectedFile);
        system.debug('isPoller@@@'+isPoller);
        if(selectedFile=='Import of LAPL Include File')
        {
            Integer j,k;
            for(j = 0; j < lstFileStatus.size(); j++){
                k=j;
               if(lstFileStatus.get(j).fileName == 'Import of LAPL Include File'){
                    lstFileStatus.remove(j);
                    break;
               }
            }
            
                isPoller=false;
        }
        else if(selectedFile=='Import of USGD Shipment File')
        {               
            Integer j,k;
            for(j = 0; j < lstOutputfinal.size(); j++){
                k=j;
               if(lstOutputfinal.get(j).fileName == 'Import of USGD Shipment File'){
                    lstOutputfinal.remove(j);
                    break;
               }
            }
            
                isPoller=false;
        }
        return null;
    }
}