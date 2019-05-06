@isTest
public class OrgLimitsControllerTest {
    @isTest
    public static void OrgLimitsControllerTest() {
        String limitJSON = OrgLimitsController.getLimitsJSON();
        System.assertNotEquals(NULL, limitJSON);
    }
}
