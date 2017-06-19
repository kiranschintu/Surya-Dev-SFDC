public with sharing class paginaton3_soql_offset_example {
   
   private integer counter=0;  //keeps track of the offset
   private integer list_size=20; //sets the page size or number of rows
   public integer total_size{get;set;} //used to show user the total size of the list
   public List<Integer> pagenumbers{get;set;}
   public Integer selectedPage{get;set;}
   public Integer pageNumber{get;set;}
   public Integer DisplayPageNumbers{get;set;}
   public Integer TotalPages{get;set;}
      
 
   public paginaton3_soql_offset_example() {
       pagenumbers=new List<Integer>();
       pageNumber=1;
       total_size = [select count() from Contact]; //set the total size in the constructor
       DisplayPageNumbers=5;
       for(Integer i=1;i<=math.round(total_size/list_size)+1;i++){
           pagenumbers.add(i);
        }
        
       //for Total Pages
       if (math.mod(total_size, list_size) > 0)
       TotalPages=total_size/list_size + 1;
       else
       TotalPages=(total_size/list_size);
   }
 
  public List<Contact> getContacts() {
      try {
         List<Contact> contacts= [select id, name from Contact order by name limit :list_size offset :counter];
         return contacts;
      } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
   }
  
   public PageReference taketoPage(){
              
      /* String s = System.CurrentPageReference().getParameters().get('num');
       
       pageNumber=Integer.valueof(s);
       
       if(Integer.valueof(s)==1)
       counter = 0;
       else
       counter = math.round((Integer.valueof(s)-1)*list_size);
       return null;*/
       Integer s=selectedpage;
       pageNumber=s;
       if(s==1)
       counter = 0;
       else
       counter = math.round((s-1)*list_size);
       return null;
       
   }
   
   public PageReference NextPage(){
       
       pageNumber+=1;
       counter = (pageNumber-1)*list_size;
       return null;
   }
   
}