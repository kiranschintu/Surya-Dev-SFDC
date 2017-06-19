public with sharing class test1 {

    public List<Lead> objectsToInsert { get; set; } 
    public Integer numberOfRowToRemove { get; set; }
    public List<Integer> Counting{get;set;}
    public Integer Count=0;
    Public Integer i{get;set;}
       
    public test1()
    {
        //if(i==Null)
        i=0;
        Counting = new List<Integer>();
        Counting.add(Count);
        Lead l = new Lead();
        objectsToInsert = new List<Lead>();
        objectsToInsert.add(l);
                
    }
    
    // The method to add a new item to the list
    public PageReference addNewObject(){
    
        
        i ++;
        Count +=1;
        Counting.add(Count);
        Lead newObject = new Lead();
        objectsToInsert.add(newObject);

        return null;
    }

    // The method to remove an item from the list
    public PageReference removeNewObject(){

        
        objectsToInsert.remove(numberOfRowToRemove);  

        return null;
    }
}