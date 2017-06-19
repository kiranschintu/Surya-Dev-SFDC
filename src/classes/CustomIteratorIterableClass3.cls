global class CustomIteratorIterableClass3 implements Iterator<String>,Iterable<String> {
        
        String[] results = new String[]{};
        Integer index;
        //String[] filelines = new String[]{}; 
        public String nameFile;
          
        global CustomIteratorIterableClass3(string nameFile) {
            index = 0;
            
            
            
            results = nameFile.split('\n');
            //results=filelines;            
        } 
 
        global boolean hasNext(){ 
           return results != null && !results.isEmpty() && index < results.size();
          /* if(index >= results.size()){
               return false;
           }else{
               return true;
           } */
        }    
 
        global String next(){ 
            return results[index++];
             /*if(index > results.size()){
               return null;
             }
             index++;
             return results[index-1]; */           
        }
        global Iterator<String> Iterator(){
            return new CustomIteratorIterableClass3(nameFile);
       }         
}