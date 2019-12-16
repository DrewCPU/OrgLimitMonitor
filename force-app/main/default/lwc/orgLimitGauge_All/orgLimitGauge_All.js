/* eslint-disable vars-on-top */
import { LightningElement, wire, track } from "lwc";
import getLimitsJSON from "@salesforce/apex/OrgLimits.getLimitsJSON";

export default class OrgLimitGauge_All extends LightningElement {
  @track limits = [];
  @wire(getLimitsJSON)
  wiredLimits({ error, data }) {
    if (data) {
      //   console.log(data);
      var parsed = JSON.parse(data);
      //   console.log(parsed);
      parsed.forEach(element => {
        // console.log(element);
        var i = 0;
        this.limits.push({ Id: i, Name: element.name });
        // console.log(limits);
      });
    }
  }
}
