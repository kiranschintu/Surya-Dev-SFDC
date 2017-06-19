public with sharing class JSONDataTableCls {
    public tableData jsonData{get; set;}
    public string jsondata1{get;set;}
    
    public JSONDataTableCls(){
        List<Account> acc;
        jsonData = new tableData();
        System.debug('%%%'+ApexPages.currentPage().getParameters().get('ui'));
        acc = [select id,name from Account limit 10];
        for(Account ac:acc){
            rowData tableRow = new rowData();
            tableRow.addColumn('Id', ac.id);
            tableRow.addColumn('Name', ac.Name);
            
            jsonData.addRow(tableRow);
        }
        jsondata1= '{"attendees": [ {"Id": "testemail-1@test.com","Name": true},{"Id": "testemail-0@test.com","Name": true}]}';
    }
    
    public class tableData{
        public List<rowData> rows{get; set;}
        public String jsonString{set;}
        
        public tableData(){
            rows = new List<rowData>();
        }
        
        public String getJsonString(){
            return toJson();
        }
        
        public void addRow(rowData row){
            rows.add(row);
        }
        
        public String toJson(){
            String json = '';
            
            for(rowData row : rows){
                json += '[';
                for(columnData col : row.columns){
                    //json += col.name + ':';
                    json += '"' + col.value + '",';
                }
                json += '],';
            }
            
            json = '{"aaData": [' + json + ']}';
            return removeTrailingCommas(json);
        }
        
        public String removeTrailingCommas(String json){
            return json.replaceAll(',]', ']');
        }
    }
    
    public class rowData{
        public List<columnData> columns {get; set;}
        
        public rowData(){
            columns = new List<columnData>();
        }
        
        public void addColumn(String n, String v){
            columns.add(new columnData(n, v));
        }
    }
    
    public class columnData{
        public String name {get; set;}
        public String value {get; set;}
        
        public columnData(String n, String v){
            name = n;
            if(v != null)
                value = v;
            else
                value = '';
        }
    }
}