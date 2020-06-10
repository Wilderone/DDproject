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

      // console.log("currcommondata", currentCommonData);
      localStorage.CommonData = JSON.stringify(currentCommonData);
      EventBus.$emit("new-hero-data", currentCommonData);
    }),
      EventBus.$on("loads-hero-stats", data => {
        // Парс и сохранение в ls основных характеристик (сила, ловкость и тд)
        console.log("парс основных");
        let currentMainParams = JSON.parse(localStorage.mainstats);
        let currentSecParams = JSON.parse(localStorage.secondaryStats);
        currentMainParams.forEach(mainParElem => {
          data.forEach(elemstr => {
            let elem = JSON.parse(JSON.stringify(elemstr));
            try {
              if (mainParElem.id_param == JSON.parse(elem).id_param) {
                mainParElem.field_int = JSON.parse(elem).field_int;
                mainParElem.modify_param = JSON.parse(elem).modify_param;
              }
            } catch (e) {
              console.log("E", e);
              console.log("ERRROR", elem);
              alert("Ошибка получения основных характеристик");
            }
          });
        });
        // парс вторичных характеристик (Акробатика и тд)
        console.log("парс вторичных");
        currentSecParams.forEach(secParElem => {
          data.forEach(elemstr => {
            let elem = JSON.parse(JSON.stringify(elemstr));
            try {
              if (+secParElem.id_param == +JSON.parse(elem).id_param) {
                secParElem.field_int = JSON.parse(elem).field_int;
                secParElem.training = JSON.parse(elem).training;
              }
            } catch (e) {
              console.log("E", e);
              console.log("ERRROR", elem);
              alert("Ошибка получения основных характеристик");
            }
          });
        });
        console.log("newsecparam", currentSecParams);
        localStorage.mainstats = JSON.stringify(currentMainParams);
        EventBus.$emit("main-characts-loads", currentMainParams);
        localStorage.secondaryStats = JSON.stringify(currentSecParams);
        EventBus.$emit("sec-characts-loads", currentSecParams);
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
          let status = response.data.hero_id.status ? true : false;
          EventBus.$emit("sending-success", status);
        })
        .catch(function(er) {
          console.log(er);
        });
    });

    return {};
  }
};
</script>
