public interface AccountTriggerActions{
    void beforeActions(List<sObject> sObjeRecords);
    void afterActions(List<sObject> sObjeRecords);
}