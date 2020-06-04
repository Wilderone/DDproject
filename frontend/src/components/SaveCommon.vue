<template>
  <div></div>
</template>
<script>
import axios from "axios";
const EventBus = require("../EventBus").default.v;

export default {
  props: ["commonData"],
  methods: {
    dataForSend: function() {
      let common = JSON.parse(localStorage.CommonData);
      let basicsLs = JSON.parse(localStorage.mainstats);
      let secondaryChars = JSON.parse(localStorage.secondaryStats);

      return { common, basicsLs, secondaryChars };
    }
  },

  data: function() {
    EventBus.$on("send-data", () => {
      let commonDataForLS = JSON.stringify(this.commonData);
      localStorage.setItem("CommonData", commonDataForLS);
      let dfs = this.dataForSend();
      axios({
        method: "post",
        url: "http://80.65.23.35:5000/",
        data: {
          dfs
        }
      })
        .then(function(response) {
          sessionStorage.uid = JSON.stringify(response.data);
          console.log(response.data);
        })
        .catch(function(er) {
          console.log(er);
        });
    });

    return {};
  }
};
</script>
