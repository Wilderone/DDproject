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
<<<<<<< HEAD
<<<<<<< HEAD
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
<<<<<<< HEAD
<<<<<<< Updated upstream
          // тут было записывание uid в ss
=======
          sessionStorage.uid = JSON.stringify(response.data);
>>>>>>> Stashed changes
=======
          // тут было записывание uid в ss
>>>>>>> master
          console.log(response.data);
        })
        .catch(function(er) {
          console.log(er);
=======
    EventBus.$on(
      "loads-hero",
      data => {
        let currentCommonData = JSON.parse(localStorage.CommonData);
        Object.keys(currentCommonData).forEach(currentData => {
          if (typeof currentData == "object") {
            Object.keys(currentData).forEach(insideData => {
              Object.keys(data).forEach(serverData => {
                if (insideData == serverData) {
                  console.log("AHAHAHHA");
                  currentData[insideData] = data[serverData];
                }
              });
            });
          }
          console.log("currcommondata", currentCommonData);
>>>>>>> master
=======
    // запись в LS загруженного персонажа и эмит события NewHeroData
    EventBus.$on("loads-hero", data => {
      let currentCommonData = JSON.parse(localStorage.CommonData);
      currentCommonData["curr_hero_id"] = data.id_hero;
      Object.keys(currentCommonData).forEach(currentData => {
        Object.keys(currentCommonData[currentData]).forEach(insideData => {
          Object.keys(data).forEach(serverData => {
            if (insideData == serverData) {
              currentCommonData[currentData][insideData] = data[serverData];
            }
          });
>>>>>>> master
        });
      });

      console.log("currcommondata", currentCommonData);
      localStorage.CommonData = JSON.stringify(currentCommonData);
      EventBus.$emit("new-hero-data", currentCommonData);
    }),
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
