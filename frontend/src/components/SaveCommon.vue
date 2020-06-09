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
      currentCommonData["curr_hero_id"] = data.commonData.id_hero;
      Object.keys(currentCommonData).forEach(currentData => {
        Object.keys(currentCommonData[currentData]).forEach(insideData => {
          Object.keys(data.commonData).forEach(serverData => {
            if (insideData == serverData) {
              currentCommonData[currentData][insideData] =
                data.commonData[serverData];
            }
          });
        });
      });

      console.log("currcommondata", currentCommonData);
      localStorage.CommonData = JSON.stringify(currentCommonData);
      EventBus.$emit("new-hero-data", currentCommonData);
    }),
      EventBus.$on("loads-hero-stats", data => {
        let currentMainParams = JSON.parse(localStorage.mainstats);
        console.log("BEFORE", currentMainParams);
        let currentSecParams = JSON.parse(localStorage.secondaryStats);
        currentMainParams.forEach(mainParData => {
          console.log("mpd", mainParData);
          Object.keys(data).forEach(currentData => {
            if (currentData.id_param == mainParData.id_param) {
              mainParData.field_int = currentData.field_int;
              mainParData.training = currentData.training;
              if (currentData.modify_param && mainParData.modify_param) {
                mainParData.modify_param = currentData.modify_param;
              }
            }
            // TODO продолжить тут. При создании перса приходит ид существующего
          });
        });
        console.log("AFTER", currentMainParams);
      });
    EventBus.$on("send-data", () => {
      //Отправка данных о персонаже на сервер

      let dfs = this.dataForSend();
      console.log(dfs);
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
