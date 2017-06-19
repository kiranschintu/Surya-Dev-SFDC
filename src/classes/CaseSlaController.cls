global class CaseSlaController
{
    //constructors for component and visualforce page extension
    public CaseSlaController() {}
    public CaseSlaController(ApexPages.StandardController controller) {}

    //gets category data and returns in JSON format for visualforce pages. Beware that since we end up double JSON encoding the return 
    //(once from the JSON.serialize, and another time because that's how data is returned when moved over apex remoting) you have to fix
    //the data on the client side. We have to double encode it because the built in JSON encoder breaks down when trying to serialize
    //the Schema.DescribeDataCategoryGroupStructureResult object, but the explicit call works.
    @remoteAction 
    global static string getCategoriesJson(string sObjectType)
    {
        return JSON.serialize(CaseSlaController.getCategories(sObjectType));
    }

    public static  list<Schema.DescribeDataCategoryGroupStructureResult> getCategories(string sObjectType)
    {

        //the describing of categories requires pairs of sObject type, and category name. This holds a list of those pairs.
        list<Schema.DataCategoryGroupSObjectTypePair> pairs = new list<Schema.DataCategoryGroupSObjectTypePair>();

        //list of objects to describe, for this app we only take 1 sObject type at a time, as passed into this function.
        list<string> objects = new list<string>();
        objects.add(sObjectType);

        //describe the categories for this object type (knowledgeArticleVersion)
        List<Schema.DescribeDataCategoryGroupResult> describeCategoryResult =  Schema.describeDataCategoryGroups(objects);

        //add the found categories to the list.
        for(Schema.DescribeDataCategoryGroupResult s : describeCategoryResult)
        {
            Schema.DataCategoryGroupSObjectTypePair thisPair = new Schema.DataCategoryGroupSObjectTypePair();
            thisPair.sObject = sObjectType;
            thisPair.dataCategoryGroupName = s.getName();
            pairs.add(thisPair);            
        }

        //describe the categories recursivly
        list<Schema.DescribeDataCategoryGroupStructureResult> results = Schema.describeDataCategoryGroupStructures(pairs,false);

        return results;
    }    
    private static DataCategory[] getAllCategories(DataCategory [] categories)
    {
        if(categories.isEmpty())
        {
            return new DataCategory[]{};
        } 
        else
        {
            DataCategory [] categoriesClone = categories.clone();
            DataCategory category = categoriesClone[0];
            DataCategory[] allCategories = new DataCategory[]{category};
            categoriesClone.remove(0);
            categoriesClone.addAll(category.getChildCategories());
            allCategories.addAll(getAllCategories(categoriesClone));
            return allCategories;
        }
    }
}