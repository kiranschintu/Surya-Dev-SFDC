public class ResponseParser{
    
    public IRepPars doSome(){
        IRepPars irp = new IRepPars();
        irp.Id='12345';
        irp.Name='Surya';
        irp.RecordTypeId='abcd12345';
        
        return irp;
    }
    
    public class IRepPars{
        public string Id;
        public string Name;
        public string RecordTypeId;
    }
}