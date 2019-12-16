@isTest
public class OrgLimitsTest {
    @isTest
    public static void testJSON() {
        String limitJSON = OrgLimits.getLimitsJSON();
        System.assertNotEquals(NULL, limitJSON);
    }
    
    @isTest
    public static void testList() {
        List<OrgLimits.OrgLimitWrapper> limitList = OrgLimits.getLimitsList();
        System.assertNotEquals(NULL, limitList);
    }
    
    @isTest
    public static void testLabelDefault() {
        String label = OrgLimits.getLabel('TestLimitNameThatDoesNotExist');
        System.assertEquals('TestLimitNameThatDoesNotExist', label);
    }
}
