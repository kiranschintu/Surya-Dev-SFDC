public class webtocasecon {
    String orgId{get;set;}
public List<contact> con;
    public String getOrgId() {
        String orgId = UserInfo.getOrganizationId();
        return orgId;
    }

    
    
}