public with sharing class OrgLimitsController {
    public static List<myOrgLimit> orgLimitList {get; set;}
    public static String orgLimitJSON {get; set;}

    public OrgLimitsController() {
        init();
    }

    public static void init() {
        orgLimitList = new List<myOrgLimit>();
        for(System.OrgLimit ol : System.OrgLimits.getAll()) {
            if(ol.getLimit() > 0){
                System.debug(ol.getName() + ' - ' + ol.getValue() + '/' + ol.getLimit());
                orgLimitList.add(new myOrgLimit(ol.getName(),ol.getValue(),ol.getLimit()));
            }
        }
        orgLimitJSON = JSON.serialize(orgLimitList);
    }

    @AuraEnabled
    public static String getLimitsJSON() {
        init();
        return orgLimitJSON;
    }

    public class myOrgLimit {
        public String name {get; set;}
        public String label {get; set;}
        public Integer current {get; set;}
        public Integer max {get; set;}

        public myOrgLimit(String n, Integer c, Integer m) {
            name = n;
            current = c;
            max = m;
            mapLabel();
        }

        public void mapLabel() {
            String tmpLabel = '';
            switch on this.name {
               when 'HourlyTimeBasedWorkflow' {
                   tmpLabel = 'Hourly Time-Based Workflow';
               }
               when 'DailyWorkflowEmails' {
                   tmpLabel = 'Daily Workflow Emails';
               }
               when 'DailyDurableStreamingApiEvents' {
                   tmpLabel = 'Daily Durable Streaming API Events';
               }
               when 'MonthlyPlatformEvents' {
                   tmpLabel = 'Monthly Platform Events';
               }
               when 'DailyStandardVolumePlatformEvents' {
                   tmpLabel = 'Daily Standard Volume Platform Events';
               }
               when 'DailyDurableGenericStreamingApiEvents' {
                   tmpLabel = 'Daily Durable Generic Streaming API Events';
               }
               when 'DurableStreamingApiConcurrentClients' {
                   tmpLabel = 'Durable Streaming API Concurrent Clients';
               }
               when 'HourlyODataCallout' {
                   tmpLabel = 'Hourly OData Callout';
               }
               when 'HourlyLongTermIdMapping' {
                   tmpLabel = 'Hourly Long Term Id Mapping';
               }
               when 'HourlyShortTermIdMapping' {
                   tmpLabel = 'Hourly Short Term Id Mapping';
               }
               when 'SingleEmail' {
                   tmpLabel = 'Single Email';
               }
               when 'MassEmail' {
                   tmpLabel = 'Mass Email';
               }
               when 'PermissionSets' {
                   tmpLabel = 'Permission Sets';
               }
               when 'HourlyDashboardRefreshes' {
                   tmpLabel = 'Hourly Dashboard Refreshes';
               }
               when 'HourlyDashboardResults' {
                   tmpLabel = 'Hourly Dashboard Results';
               }
               when 'HourlyDashboardStatuses' {
                   tmpLabel = 'Hourly Dashboard Statuses';
               }
               when 'HourlySyncReportRuns' {
                   tmpLabel = 'Hourly Sync Report Runs';
               }
               when 'HourlyAsyncReportRuns' {
                   tmpLabel = 'Hourly Async Report Runs';
               }
               when 'ConcurrentSyncReportRuns' {
                   tmpLabel = 'Concurrent Sync Report Runs';
               }
               when 'ConcurrentAsyncGetReportInstances' {
                   tmpLabel = 'Concurrent Async Get Report Instances';
               }
               when 'DailyAnalyticsDataflowJobExecutions' {
                   tmpLabel = 'Daily Analytics Dataflow Job Executions';
               }
               when 'Package2VersionCreates' {
                   tmpLabel = 'Package2Version Creates';
               }
               when 'DailyAsyncApexExecutions' {
                   tmpLabel = 'Daily Async Apex Executions';
               }
               when 'DailyApiRequests' {
                   tmpLabel = 'Daily API Requests';
               }
               when 'DailyBulkApiRequests' {
                   tmpLabel = 'Daily Bulk API Requests';
               }
               when 'DailyGenericStreamingApiEvents' {
                   tmpLabel = 'Daily Generic Streaming API Events';
               }
               when 'StreamingApiConcurrentClients' {
                   tmpLabel = 'Streaming API Concurrent Clients';
               }
               when 'DailyStreamingApiEvents' {
                   tmpLabel = 'Daily Streaming API Events';
               }
               when 'DataStorageMB' {
                   tmpLabel = 'Data Storage (MB)';
               }
               when 'FileStorageMB' {
                   tmpLabel = 'File Storage (MB)';
               }
               when else {
                   tmpLabel = this.name;
               }
            }
            this.label = tmpLabel;
        }
    }
}
