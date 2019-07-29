public without sharing class OrgLimitsController {
    public static List<OrgLimits.OrgLimitWrapper> orgLimitList {get; set;}

    public OrgLimitsController() {
        orgLimitList = OrgLimits.getLimitsList();
    }

}
