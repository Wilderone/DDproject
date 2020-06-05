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
import axios from 'axios';



Vue.config.productionTip = false;
const EventBus = require('./EventBus').default.v
Vue.use(lsWatcher, { prefix: 'dd_!' })


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
        id_field: 0,
        tagName: "acrobatics",
        vizibleName: "Акробатика (Лов)",
        value: 2,
        training: false

      },
      {
        id_field: 0,
        tagName: "athletics",
        vizibleName: "Атлетика (Сил)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "attention",
        vizibleName: "Внимательность (Мдр)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "thef",
        vizibleName: "Воровство (Лов)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "endurance",
        vizibleName: "Выносливость (Тел)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "intimidation",
        vizibleName: "Запугивание (Хар)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "streets",
        vizibleName: "Знание улиц (Хар)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "history",
        vizibleName: "История (Инт)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "magic",
        vizibleName: "Магия (Инт) ",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "deception",
        vizibleName: "Обман (Хар)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "conversation",
        vizibleName: "Переговоры (Хар)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "dungeons",
        vizibleName: "Подземелья (Мдр)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "nature",
        vizibleName: "Природа (Мдр)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "insight",
        vizibleName: "Проницательность (Мдр)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "religion",
        vizibleName: "Религия (Инт)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "stealth",
        vizibleName: "Скрытность (Лов)",
        value: 0,
        training: false
      },
      {
        id_field: 0,
        tagName: "healingchars",
        vizibleName: "Целительство (Мдр)",
        value: 5,
        training: false
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
    changeSecChar: function (event) {
      console.log(event)
    },
    readLsMainstats: function () {
      if (!localStorage.mainstats) {
        localStorage.mainstats = JSON.stringify(this.mainStats);

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

      if (!localStorage.secondaryStats) {
        localStorage.secondaryStats = JSON.stringify(this.secStats);
      } else {

        let secStatsForLoad = JSON.parse(localStorage.secondaryStats);
        this.secStats.forEach(element => {
          secStatsForLoad.forEach(currStat => {
            if (element.id_field == currStat.id_field) {
              element.value = +currStat.value
              element.training = currStat.training
            }
          })
        })
      }
    },
  },
  beforeCreate: function () {

    axios.get('http://80.65.23.35:5000/stats')
      // Получение ID первичных и вторичных характеристик
      .then(response => {

        let respSecondary = response.data.secondary_stats
        console.log(respSecondary)
        this.secStats.forEach(function (elem, elemIndex) {
          Object.keys(respSecondary).forEach(function (respElem, respElemIndex) {
            if (elem.tagName == respSecondary[respElem]) {

              elem.id_field = Object.keys(respSecondary)[respElemIndex]
            }
          })

        })
        // TODO доработать когда будут mainstats-base / modif в базе
        let respMainStats = response.data.main_stats
        this.mainStats.forEach(function (elem, elemIndex) {
          Object.keys(respMainStats).forEach(function (respElem, respElemIndex) {
            if (elem.idBase == respMainStats[respElem]) {

              elem.id = Object.keys(respMainStats)[respElemIndex]
            }
          })

        })


      }).finally(() => {
        this.readLsSecondary();
        this.readLsMainstats();
      })


  },
<<<<<<< HEAD


=======


>>>>>>> master
});

new Vue({
  el: "#common-t",
  components: {
    Common, Size, Vision, Name, SaveCommon
  },
  methods: {
    readLsCommonData: function () {

      if (!localStorage.CommonData) {
        localStorage.setItem('CommonData', JSON.stringify(this.commonData))
      } else {
        this.commonData = JSON.parse(localStorage.CommonData)
      }
    },

  },
  created: function () {
    // Получение списка рас и классов, а так же получение
    // пока единственного GUID
    //TODO когда прикрутишь авторизацию убери отсюда guid
    axios.get('http://80.65.23.35:5000/race_class').then(response => {
<<<<<<< Updated upstream

      let common = this.listOfClassRace
      sessionStorage.uid = response.data.player;
      console.log('resp', response.data)
      response.data.races_classes.classes.forEach(value => {
=======

      let common = this.listOfClassRace
<<<<<<< HEAD

      response.data.classes.forEach(value => {
>>>>>>> Stashed changes
=======
      sessionStorage.uid = response.data.player;
      console.log('resp', response.data)
      response.data.races_classes.classes.forEach(value => {
>>>>>>> master
        //console.log(value)
        common.classes.push(JSON.parse(value))

        // console.log(response.data.classes[value])
      })
<<<<<<< HEAD
<<<<<<< Updated upstream
      response.data.races_classes.races.forEach(value => {
=======
      response.data.races.forEach(value => {
>>>>>>> Stashed changes
=======
      response.data.races_classes.races.forEach(value => {
>>>>>>> master
        //console.log(value)
        common.races.push(JSON.parse(value))
        //common.classes.push(response.data.classes)

      })
    })

      .catch(error => {
        console.log(error)
      }).finally(() => {
        this.readLsCommonData()
        this.get_available()
      })


  },

  data: {
    get_available: function () {
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
>>>>>>> master
      let uid = JSON.stringify({ "uid": sessionStorage['uid'] })
      console.log(typeof (uid))
      axios({
        method: 'get',
        url: "http://80.65.23.35:5000/heroes",
        headers: {
          "uid": uid
        }
      }).then(response => {
<<<<<<< HEAD
=======
      axios.get("http://80.65.23.35:5000/heroes").then(response => {
>>>>>>> Stashed changes
=======
>>>>>>> master
        this.availableHeroes = []
        response.data.forEach(elem => {
          this.availableHeroes.push(elem)


        })
      })
    },
    availableHeroes: [],

    listOfClassRace: {
      races: [],
      classes: []
    },

    commonData: {
      owner: "superuser",

      common: {
        id_race: 0,
        sex: '',
        id_class: 0,
      },
      nameSexExp: {
        name_hero: "",
        level_hero: '',
        currentexp: '',
      },
      heigWeigSize: {
        height: '',
        weight: '',
        size: '',
      },
      visLang: {
        vision: '',
        language_hero: ''
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


// function getCookie(name) {
//   let matches = document.cookie.match(new RegExp(
//     "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
//   ));
//   return matches ? decodeURIComponent(matches[1]) : undefined;
// }