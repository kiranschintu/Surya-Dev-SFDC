public class DynamicClassroomList {

    private ApexPages.StandardSetController controller;
    private PageReference savePage;
    private Set<String> unSelectedNames;
    private Set<String> selectedNames;
    
    public List<String> selected { get; set; }
    public List<String> unselected { get; set; }
    public String objId { get; set; }
    public List<String> displayObjs {
        get; private set;
    }
    
    boolean idIsSet = false;
    
    public DynamicClassroomList() {
        init();
    }

    public DynamicClassroomList(ApexPages.StandardSetController con) {
        this.controller = con;
        init();
    }

    private void init() {
        savePage = null;
        unSelectedNames = new Set<String>();
        selectedNames = new Set<String>();
         
        if (idIsSet) {
            ApexPages.CurrentPage().getParameters().put('id', objId);
            idIsSet = false;
        }
    }
    
    public PageReference show() {
        savePage = Page.dynVFClassroom;
        savePage.getParameters().put('id', objId);
        return savePage;
    }

    public List<SelectOption> displayObjsList { 
        get {
            List<SelectOption> options = new List<SelectOption>();
            List<Classroom__c> classrooms = [SELECT id, name FROM Classroom__c];
            
            for (Classroom__c c: classrooms) {
                options.add(new SelectOption(c.id, c.name)); 
            }
            
            return options;
       }
    }
    
    public PageReference customize() {
        savePage = ApexPages.CurrentPage();
        savePage.getParameters().put('id', objId);
        
        return Page.dynamicclassroomlist;
    }

    // The methods below are for constructing the select list   
    

    public List<SelectOption> selectedOptions { 
        get {
            List<String> sorted = new List<String>(selectedNames);
            sorted.sort();
            List<SelectOption> options = new List<SelectOption>();
            for (String s: sorted) {
                options.add(new SelectOption(s, s));
            }
            return options;
        }
    }
    
    public List<SelectOption> unSelectedOptions { 
        get {
            Schema.DescribeSObjectResult R = Classroom__c.SObjectType.getDescribe();
            List<Schema.ChildRelationship> C = R.getChildRelationships(); 
            List<SelectOption> options = new List<SelectOption>();
            
            for (Schema.ChildRelationship cr: C) {
                String relName = cr.getRelationshipName();
                // We're only interested in custom relationships 
    
                if (relName != null && relName.contains('__r')) {
                    options.add(new SelectOption(relName, relName));
                }
            }
            return options;
        }
    }


    public void doSelect() {
        for (String s: selected) {
            selectedNames.add(s);
            unselectedNames.remove(s);
        }
    }

    public void doUnSelect() {
        for (String s: unselected) {
            unSelectedNames.add(s);
            selectedNames.remove(s);
        }
    }

    public Component.Apex.OutputPanel getClassroomRelatedLists() {
        Component.Apex.OutputPanel dynOutPanel= new Component.Apex.OutputPanel();
        
        for(String id: selectedNames) {
           Component.Apex.RelatedList dynRelList = new Component.Apex.RelatedList();
           dynRelList.list = id;
           dynOutPanel.childComponents.add(dynRelList);
        }
        
        return dynOutPanel;
    }
}