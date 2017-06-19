global class CustomIterable2Upload implements Iterator<String>{
   
   public Blob csvFile{get;set;}
   Integer i {get; set;}
   String[] filelines = new String[]{};
   public String nameFile{get;set;}
   
   public CustomIterable2Upload()
   {
       if(csvFile!=null){
        // Convert the Blob content to String
        nameFile=csvFile.toString();
   
        //Read the CSV Rows using split method
        filelines = nameFile.split('\n');
        }
       i = 0;
   }

   global boolean hasNext()
   {
       if(i >= filelines.size())
       {
           return false;
       } else {
           return true;
       }
   }

   global String next()
   {
       if(i > filelines.size())
       {
           return null;
       }
       i++;
       return filelines[i-1];
   }
    global PageReference ReadFile(){
        CustomIteratorbatchClass2Upload ob = new CustomIteratorbatchClass2Upload();
        Database.executeBatch(ob);
        return null;
   }
   
}