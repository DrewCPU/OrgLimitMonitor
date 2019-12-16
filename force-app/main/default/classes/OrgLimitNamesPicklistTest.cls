@isTest
global class OrgLimitNamesPicklistTest {
    @isTest
    public static void testPicklist() {
        OrgLimitNamesPicklist olnp = new OrgLimitNamesPicklist();

        System.assertNotEquals(null, olnp.getDefaultValue());
        System.assertNotEquals(null, olnp.getValues());
    }
}
