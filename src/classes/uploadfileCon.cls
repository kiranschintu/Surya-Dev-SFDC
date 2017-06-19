public with sharing class uploadfileCon {
    public String FileData{get;set;}//Used to get the file data
    public void executebatch(){
        //call the batch apex
        system.debug('File Data>>'+FileData);
        if(FileData!=null){
            CustomIterableBatchForAccount ob=new CustomIterableBatchForAccount(FileData);
            Database.executeBatch(ob);
            //clear the data to avoid the view state error
            FileData=null;
        }
    }
}