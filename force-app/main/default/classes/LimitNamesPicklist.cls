global class LimitNamesPicklist extends VisualEditor.DynamicPickList {
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Daily API Requests', 'DailyApiRequests');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows myValues = new VisualEditor.DynamicPickListRows();
        for(OrgLimits.OrgLimitWrapper ml : OrgLimits.getLimitsList()) {
            myValues.addRow(new VisualEditor.DataRow(ml.label, ml.name));
        }
        System.debug(myValues);
        return myValues;
    }
}
