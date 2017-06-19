public with sharing class DynamicLeadTableCls {
    public Map<String,List<leadWrapper>> mapData{get;set;}
    public List<leadWrapper> leadWrappers{get;set;}
    public Set<String> headers{get;set;}
    
    public DynamicLeadTableCls(){
        mapData = new Map<String,List<leadWrapper>>();
        headers = new Set<String>();
        leadWrappers = new List<leadWrapper>();
        
        for(Lead l:[select id,name,Rating from Lead where Rating!=null order by Rating]){
            if(mapData.containsKey(l.rating)){
                List<leadWrapper> lws = new List<leadWrapper>();
                lws = mapData.get(l.rating);
                
                leadWrapper lw = new leadWrapper();
                lw.header=l.Rating;
                lw.lead=l;
                
                lws.add(lw);
                mapData.put(l.Rating,lws);
            }else{
                leadWrapper lw = new leadWrapper();
                lw.header=l.Rating;
                lw.lead=l;
                List<leadWrapper> lws = new List<leadWrapper>();
                lws.add(lw);
                mapData.put(l.Rating,lws);
            }
            headers.add(l.Rating);
            
            leadWrapper lw = new leadWrapper();
            lw.header=l.Rating;
            lw.lead=l;
            leadWrappers.add(lw);
        }
    }
    
    public class leadWrapper{
        public string header{get;set;}
        public Lead lead{get;set;}
        public boolean isSelected{get;set;}
    }
}