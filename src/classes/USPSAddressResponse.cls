public with sharing Class USPSAddressResponse{
        public boolean isNotValid;
        public String addressType;
        public AccountAddress USPSAddress;
        
    public Class AccountAddress{
        public String street;
        public String city;
        public String state;
        public String Zip5;
        public String Zip4;
    }
}