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
    // запись в LS загруженного персонажа и эмит события NewHeroData
    EventBus.$on("loads-hero", data => {
      let currentCommonData = JSON.parse(localStorage.CommonData);
      Object.keys(currentCommonData).forEach(currentData => {
        Object.keys(currentCommonData[currentData]).forEach(insideData => {
          Object.keys(data).forEach(serverData => {
            if (insideData == serverData) {
              currentCommonData[currentData][insideData] = data[serverData];
            }
          });
        });
      });
      console.log("currcommondata", currentCommonData);
      localStorage.CommonData = JSON.stringify(currentCommonData);
      EventBus.$emit("new-hero-data", currentCommonData);
    }),
      EventBus.$on("send-data", () => {
        // let commonDataForLS = JSON.stringify(this.commonData);
        // localStorage.setItem("CommonData", commonDataForLS);

        let dfs = this.dataForSend();
        axios({
          method: "post",
          url: "http://80.65.23.35:5000/",
          data: {
            dfs
          }
        })
          .then(function(response) {
            // тут было записывание uid в ss
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
