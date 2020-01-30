/* eslint-disable vars-on-top */
import { LightningElement, track, wire, api } from "lwc";
import { loadScript } from "lightning/platformResourceLoader";
import chartjs from "@salesforce/resourceUrl/chartjs";
import { refreshApex } from '@salesforce/apex';
import getLimitsJSON from "@salesforce/apex/OrgLimits.getLimitsJSON";

function getColor(ratio) {
  var red = "d4504c";
  var green = "4bca81";
  var yellow = "ffb75d";
  var hex = function(x) {
    x = x.toString(16);
    return x.length === 1 ? "0" + x : x;
  };

  var color1;
  var color2;
  if (ratio <= 0.5) {
    color1 = yellow;
    color2 = green;
    ratio = ratio * 2;
  } else {
    color1 = red;
    color2 = yellow;
    ratio = (ratio - 0.5) * 2;
  }
  //ratio = ratio * 2;

  //   console.log("color1: " + color1);
  //   console.log("color2: " + color2);
  //   console.log("ratio: " + ratio);

  var r = Math.ceil(
    parseInt(color1.substring(0, 2), 16) * ratio +
      parseInt(color2.substring(0, 2), 16) * (1 - ratio)
  );
  var g = Math.ceil(
    parseInt(color1.substring(2, 4), 16) * ratio +
      parseInt(color2.substring(2, 4), 16) * (1 - ratio)
  );
  var b = Math.ceil(
    parseInt(color1.substring(4, 6), 16) * ratio +
      parseInt(color2.substring(4, 6), 16) * (1 - ratio)
  );

  var middle = hex(r) + hex(g) + hex(b);
  //   console.log(middle);
  return "#" + middle;
}

export default class OrgLimitGauge extends LightningElement {
  @api limitName;
  @track error;
  chart;
  @track current = 40;
  @track maxValue = 100;
  remainder = this.maxValue - this.current;
  @track chartTitle = "Limit Gauge";
  chartjsInitialized = false;
  wiredLimitData;

  @wire(getLimitsJSON)
  wiredLimits(value) {
    // Hold on to the provisioned value so we can refresh it later.
    this.wiredLimitData = value; // track the provisioned value
    const { data, error } = value;
    if (data) {
      // console.log(data);
      var parsed = JSON.parse(data);
      // console.log(parsed);
      parsed.forEach(element => {
        if (element.name === this.limitName) {
          console.log(element);
          this.chartTitle = element.label;
          this.current = element.current;
          this.maxValue = element.max;
          this.remainder = this.maxValue - this.current;
          loadScript(this, chartjs)
            .then(() => {
              const ctx = this.template
                .querySelector("canvas.donut")
                .getContext("2d");
              this.chart = new window.Chart(ctx, this.config);
              this.chart.data = {
                datasets: [
                  {
                    data: [this.current, this.remainder],
                    backgroundColor: [
                      getColor(this.current / this.maxValue),
                      "#ecebea"
                    ]
                  }
                ],
                labels: [this.chartTitle, "remaining"]
              };
              this.chart.options.title.text =
                this.current + " / " + this.maxValue;
              this.chart.update();
            })
            .catch(charterror => {
              this.error = charterror;
            });
        }
      });
    } else if (error) {
      console.log(error);
    }
  }

  config = {
    type: "doughnut",
    data: {
      datasets: [
        {
          data: [this.current, this.remainder],
          backgroundColor: [getColor(this.current / this.maxValue), "#ecebea"]
        }
      ],
      labels: ["Red"]
    },
    options: {
      legend: {
        display: false
      },
      title: {
        text: this.current + " / " + this.maxValue,
        position: "bottom",
        display: true,
        fontFamily: "Salesforce Sans",
        fontSize: 36
      },
      responseive: true,
      circumference: Math.PI,
      rotation: -Math.PI,
      animation: {
        animateScale: true,
        animateRotate: true
      }
    }
  };

  renderedCallback() {
    if (this.chartjsInitialized) {
      return;
    }
    this.chartjsInitialized = true;

    // loadScript(this, chartjs)
    //     .then(() => {
    //         const ctx = this.template
    //             .querySelector('canvas.donut')
    //             .getContext('2d');
    //         this.chart = new window.Chart(ctx, this.config);
    //     })
    //     .catch(error => {
    //         this.error = error;
    //     });
  }

  handleRefresh() {
    return refreshApex(this.wiredLimitData);
  }
}
