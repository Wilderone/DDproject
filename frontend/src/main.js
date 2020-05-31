import Vue from "../node_modules/vue/dist/vue.js";
import Common from "./components/Common";
import Name from "./components/Name";
import Size from "./components/Size";
import Vision from "./components/Vision";
import SecondaryChars from "./components/SecondaryChars";
import Tabs from "./components/Tabs";
import Hits from "./components/Hits";
import MainStats from "./components/MainStats";
import SaveCommon from "./components/SaveCommon";
import lsWatcher from "vue-storage-watcher"



Vue.config.productionTip = false;
const EventBus = require('./EventBus').default.v
Vue.use(lsWatcher, { prefix: 'dd_!' })
EventBus.$on('send-data', () => {


})

new Vue({
  el: '#tab-content',
  components: { SecondaryChars, Hits, MainStats },
  data: {
    classbs: "col-12 col-sm-6 col-md-6 col-lg-3 col-xl-3",
    mainStatClasses: {
      mainStatsInputbs: "col-5 col-sm-4 col-md-3 col-lg-3 col-xl-3",
      mianStatTitlebs: "col-2 col-sm-4 col-md-4 col-lg-4 col-xl-4"
    },
    secStats: [
      {
        id: 16,
        tagName: "acrobatics",
        vizibleName: "Акробатика (Лов)",
        value: 0,
        trained: false

      },
      {
        id: 9,
        tagName: "athletics",
        vizibleName: "Атлетика (Сил)",
        value: 0,
        trained: false
      },
      {
        id: 20,
        tagName: "attention",
        vizibleName: "Внимательность (Мдр)",
        value: 0,
        trained: false
      },
      {
        id: 17,
        tagName: "theft",
        vizibleName: "Воровство (Лов)",
        value: 0,
        trained: false
      },
      {
        id: 10,
        tagName: "endurance",
        vizibleName: "Выносливость (Тел)",
        value: 0,
        trained: false
      },
      {
        id: 14,
        tagName: "intimidation",
        vizibleName: "Запугивание (Хар)",
        value: 0,
        trained: false
      },
      {
        id: 21,
        tagName: "streets",
        vizibleName: "Знание улиц (Хар)",
        value: 0,
        trained: false
      },
      {
        id: 23,
        tagName: "history",
        vizibleName: "История (Инт)",
        value: 0,
        trained: false
      },
      {
        id: 11,
        tagName: "magic",
        vizibleName: "Магия (Инт) ",
        value: 0,
        trained: false
      },
      {
        id: 18,
        tagName: "deception",
        vizibleName: "Обман (Хар)",
        value: 0,
        trained: false
      },
      {
        id: 15,
        tagName: "conversation",
        vizibleName: "Переговоры (Хар)",
        value: 0,
        trained: false
      },
      {
        id: 8,
        tagName: "dungeons",
        vizibleName: "Подземелья (Мдр)",
        value: 0,
        trained: false
      },
      {
        id: 7,
        tagName: "nature",
        vizibleName: "Природа (Мдр)",
        value: 0,
        trained: false
      },
      {
        id: 19,
        tagName: "insight",
        vizibleName: "Проницательность (Мдр)",
        value: 0,
        trained: false
      },
      {
        id: 22,
        tagName: "religion",
        vizibleName: "Религия (Инт)",
        value: 0,
        trained: false
      },
      {
        id: 12,
        tagName: "stealth",
        vizibleName: "Скрытность (Лов)",
        value: 0,
        trained: false
      },
      {
        id: 13,
        tagName: "healing-chars",
        vizibleName: "Целительство (Мдр)",
        value: 0,
        trained: false
      }
    ],

    mainStats: [
      {
        id: 3,
        mainTagName: "strength-row",
        textTagName: "strength-text",
        idBase: "strength-base",
        idModif: "strength-modif",
        title: "Сила",
        valueBase: 0,
        valueModif: 0
      },
      {
        id: 6,
        mainTagName: "stamina-row",
        textTagName: "stamina-text",
        idBase: "stamina-base",
        idModif: "stamina-modif",
        title: "Телосложение",
        valueBase: 0,
        valueModif: 0
      },
      {
        id: 4,
        mainTagName: "agility-row",
        textTagName: "agility-text",
        idBase: "agility-base",
        idModif: "agility-modif",
        title: "Ловкость",
        valueBase: 0,
        valueModif: 0
      },
      {
        id: 1,
        mainTagName: "intellect-row",
        textTagName: "intellect-text",
        idBase: "intellect-base",
        idModif: "intellect-modif",
        title: "Интеллект",
        valueBase: 0,
        valueModif: 0
      },
      {
        id: 2,
        mainTagName: "wisdome-row",
        textTagName: "wisdome-text",
        idBase: "wisdome-base",
        idModif: "wisdome-modif",
        title: "Мудрость",
        valueBase: 0,
        valueModif: 0
      },
      {
        id: 5,
        mainTagName: "charisma-row",
        textTagName: "charisma-text",
        idBase: "charisma-base",
        idModif: "charisma-modif",
        title: "Харизма",
        valueBase: 0,
        valueModif: 0
      }
    ],

  },

  methods: {
    readLsMainstats: function () {
      if (localStorage.mainstats == undefined || localStorage.mainstats.length == 0) {
        localStorage.mainstats = [];

      } else {
        let mainstatsForLoad = JSON.parse(localStorage.mainstats);
        this.mainStats.forEach(element => {
          mainstatsForLoad.forEach(lsvalue => {
            if (lsvalue.id == element.id) {
              element.valueBase = +lsvalue.valueBase;
              element.valueModif = +lsvalue.valueModif;
            }
          });
        })


      }
    },
    readLsSecondary: function () {

      if (localStorage.secondaryStats == undefined || localStorage.secondaryStats.length == 0) {

        localStorage.secondaryStats = [];
      } else {

        let secStatsForLoad = JSON.parse(localStorage.secondaryStats);
        this.secStats.forEach(element => {
          secStatsForLoad.forEach(currStat => {
            if (element.id == currStat.id) {
              element.value = +currStat.value
              element.trained = currStat.trained
            }
          })
        })
      }
    },
  },
  created: function () {
    this.readLsMainstats();
    this.readLsSecondary();
  },

});

new Vue({
  el: "#common-t",
  components: {
    Common, Size, Vision, Name, SaveCommon
  },
  methods: {
    readLsCommonData: function () {

      if (localStorage.CommonData == undefined || localStorage.CommonData.length == 0) {
        localStorage.setItem('CommonData', JSON.stringify(this.commonData))
      } else {
        this.commonData = JSON.parse(localStorage.CommonData)
      }
    }
  },
  created: function () {
    this.readLsCommonData()
  },

  data: {

    commonData: {
      owner: "superuser",

      common: {
        race: '',
        sex: '',

        class: '',
      },
      nameSexExp: {
        name: "",
        level: '',
        currentExp: '',
      },
      heigWeigSize: {
        height: '',
        weight: '',
        size: '',
      },
      visLang: {
        vision: '',
        language: ''
      }

    },
  }
})
new Vue({
  render: (h) => h(Tabs),

}).$mount('#tabs')

// new Vue({
//   render: (h) => h(Common),
//   data: {

//   }

// }).$mount("#common");
// new Vue({
//   render: (h) => h(Name),
// }).$mount("#name");
// new Vue({
//   render: (h) => h(Size),
// }).$mount("#size");

// new Vue({
//   render: (h) => h(Vision),
// }).$mount("#vision");

// new Vue({
//   render: (h) => h(SecondaryChars),
//   data: {

//   }

// }).$mount("#sec-chars");


