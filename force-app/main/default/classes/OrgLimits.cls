global class OrgLimits {
    public static List<OrgLimitWrapper> orgLimitList {get; set;}

    public static void init() {
        System.debug('##### OrgLimitsController.init - User: ' + UserInfo.getUserId() + '(Profile: ' + UserInfo.getProfileId() + ')');
        orgLimitList = new List<OrgLimitWrapper>();
        for(System.OrgLimit ol : System.OrgLimits.getAll()) {
            if(ol.getLimit() > 0){
                System.debug(ol.getName() + ' - ' + ol.getValue() + '/' + ol.getLimit());
                orgLimitList.add(new OrgLimitWrapper(ol.getName(),ol.getValue(),ol.getLimit()));
            }
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getLimitsJSON() {
        init();
        return JSON.serialize(orgLimitList);
    }

    @AuraEnabled(cacheable=true)
    public static List<OrgLimits.OrgLimitWrapper> getLimitsList() {
        init();
        return orgLimitList;
    }

    @AuraEnabled(cacheable=true)
    public static String getLabel(String name) {
        String tmpLabel = '';
        switch on name {
            when 'HourlyTimeBasedWorkflow' {
                tmpLabel = System.Label.OrgLimits_HourlyTimeBasedWorkflow;
            }
            when 'DailyWorkflowEmails' {
                tmpLabel = System.Label.OrgLimits_DailyWorkflowEmails;
            }
            when 'DailyDurableStreamingApiEvents' {
                tmpLabel = System.Label.OrgLimits_DailyDurableStreamingApiEvents;
            }
            when 'MonthlyPlatformEvents' {
                tmpLabel = System.Label.OrgLimits_MonthlyPlatformEvents;
            }
            when 'DailyStandardVolumePlatformEvents' {
                tmpLabel = System.Label.OrgLimits_DailyStandardVolumePlatformEvents;
            }
            when 'DailyDurableGenericStreamingApiEvents' {
                tmpLabel = System.Label.OrgLimits_DailyDurableGenericStreamingApiEvents;
            }
            when 'DurableStreamingApiConcurrentClients' {
                tmpLabel = System.Label.OrgLimits_DurableStreamingApiConcurrentClients;
            }
            when 'HourlyODataCallout' {
                tmpLabel = System.Label.OrgLimits_HourlyODataCallout;
            }
            when 'HourlyLongTermIdMapping' {
                tmpLabel = System.Label.OrgLimits_HourlyLongTermIdMapping;
            }
            when 'HourlyShortTermIdMapping' {
                tmpLabel = System.Label.OrgLimits_HourlyShortTermIdMapping;
            }
            when 'SingleEmail' {
                tmpLabel = System.Label.OrgLimits_SingleEmail;
            }
            when 'MassEmail' {
                tmpLabel = System.Label.OrgLimits_MassEmail;
            }
            when 'PermissionSets' {
                tmpLabel = System.Label.OrgLimits_PermissionSets;
            }
            when 'HourlyDashboardRefreshes' {
                tmpLabel = System.Label.OrgLimits_HourlyDashboardRefreshes;
            }
            when 'HourlyDashboardResults' {
                tmpLabel = System.Label.OrgLimits_HourlyDashboardResults;
            }
            when 'HourlyDashboardStatuses' {
                tmpLabel = System.Label.OrgLimits_HourlyDashboardStatuses;
            }
            when 'HourlySyncReportRuns' {
                tmpLabel = System.Label.OrgLimits_HourlySyncReportRuns;
            }
            when 'HourlyAsyncReportRuns' {
                tmpLabel = System.Label.OrgLimits_HourlyAsyncReportRuns;
            }
            when 'ConcurrentSyncReportRuns' {
                tmpLabel = System.Label.OrgLimits_ConcurrentSyncReportRuns;
            }
            when 'ConcurrentAsyncGetReportInstances' {
                tmpLabel = System.Label.OrgLimits_ConcurrentAsyncGetReportInstances;
            }
            when 'DailyAnalyticsDataflowJobExecutions' {
                tmpLabel = System.Label.OrgLimits_DailyAnalyticsDataflowJobExecutions;
            }
            when 'Package2VersionCreates' {
                tmpLabel = System.Label.OrgLimits_Package2VersionCreates;
            }
            when 'DailyAsyncApexExecutions' {
                tmpLabel = System.Label.OrgLimits_DailyAsyncApexExecutions;
            }
            when 'DailyApiRequests' {
                tmpLabel = System.Label.OrgLimits_DailyApiRequests;
            }
            when 'DailyBulkApiRequests' {
                tmpLabel = System.Label.OrgLimits_DailyBulkApiRequests;
            }
            when 'DailyGenericStreamingApiEvents' {
                tmpLabel = System.Label.OrgLimits_DailyGenericStreamingApiEvents;
            }
            when 'StreamingApiConcurrentClients' {
                tmpLabel = System.Label.OrgLimits_StreamingApiConcurrentClients;
            }
            when 'DailyStreamingApiEvents' {
                tmpLabel = System.Label.OrgLimits_DailyStreamingApiEvents;
            }
            when 'DataStorageMB' {
                tmpLabel = System.Label.OrgLimits_DataStorageMB;
            }
            when 'FileStorageMB' {
                tmpLabel = System.Label.OrgLimits_FileStorageMB;
            }
            when else {
                tmpLabel = name;
            }
        }
        return tmpLabel;
    }

    public class OrgLimitWrapper {
        public String name {get; set;}
        public String label {get; set;}
        public Integer current {get; set;}
        public Integer max {get; set;}

        public OrgLimitWrapper(String n, Integer c, Integer m) {
            name = n;
            current = c;
            max = m;
            mapLabel();
        }

        public void mapLabel() {
            this.label = OrgLimits.getLabel(this.name);
        }
    }
}
