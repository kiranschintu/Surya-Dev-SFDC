public class SortingController{
    
    // The list of all our accounts has a custom getter to sort immediately
    public List<Account> accounts { get {return sortList(accounts);} set; }
    
    // The string containing the column to filter by
    public String sortBy { get; set; }
    
    // The string containing the direction (ASC, DESC)
    public String sortDir { get; set; }
    
    // In the constructor we just define an initial list of accounts
    public SortingController()
    {
    accounts = [Select Id, Name, Site, BillingState, Phone, Type From Account limit 100];
    }
    
    public PageReference empty() { return null; }
    
    // The sorting function works on all SObjects sorting on all fields
    private List<SObject> sortList(List<SObject> cleanList)
    {
        // return the clean list if we don't have a sort field defined
        if (sortBy == null) { return cleanList; }
    
        // create an empty result List
        List<SObject> resultList = new List<SObject>();
    
        // and an object map which will be sorted
        Map<Object, List<SObject>> objectMap = new Map<Object, List<SObject>>();
    
        // now loop through the clean list and create the object map
        for (SObject item : cleanList) {
        if (objectMap.get(item.get(sortBy)) == null) {
            objectMap.put(item.get(sortBy), new List<SObject>());
        }
        objectMap.get(item.get(sortBy)).add(item);
        }
    
        // get all the keys from the object map and sort them
        List<Object> keys = new List<Object>(objectMap.keySet());
        keys.sort();
        
        // now create a result list by adding all objects from the object map
        // in the sorted order
        for(Object key : keys) {
        resultList.addAll(objectMap.get(key));
        }
    
        // clear the clean list
        cleanList.clear();
        // depending on the direction add the items in the correct sorting to the clean list
        if (sortDir == 'ASC') {
            for (SObject item : resultList) {
            cleanList.add(item);
            }
        } else {
        for (Integer i = resultList.size()-1; i >= 0; i--) {
        cleanList.add(resultList[i]);
        }
    }
    // return the clean and now sorted list
    return cleanList;
    }
    }