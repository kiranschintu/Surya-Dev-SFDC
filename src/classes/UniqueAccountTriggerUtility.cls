public class UniqueAccountTriggerUtility{
    public static boolean isRecursive=false;
    public static void callStratagies(List<sObject> newRecords,List<sObject> oldRecords,Map<id,sObject> newRecordsMap,Map<id,sObject> oldRecordsMap,Boolean isInsert,Boolean isUpdate,Boolean isDelete,Boolean isUndelete,Boolean isBefore,Boolean isAfter){
        //excuting before actions
        if(isBefore){
            UpdateContacts.beforeActions(newRecords);
        }
        //executing after actions
        if(isAfter){
            isRecursive=true;
            UpdateContacts1.afterActions(newRecords);
        }
        
    }
}