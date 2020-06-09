<template>
  <div class="head container">
    <div class="row person d-flex justify-content-center">
      <div class="col-12 col-sm-6 col-md-6 choosehero">
        <form id="personage" action="#">
          <div class="input-group mb-3 save-load">
            <div class="input-group-prepend">
              <select
                id="heroes"
                class="custom-select"
                @change="requestDataHero($event.target.value)"
              >
                <option>Создать нового персонажа</option>
                <option
                  v-for="(hero, index) in this.charsForLoad"
                  :key="index"
                  :value="hero.id_hero"
                >{{hero.name_hero}} {{hero.class_hero}} {{hero.hero_level}}лвл</option>
              </select>
            </div>
            <div>
              <button @click.prevent="sendData()" class="btn-primary save-hero">Сохранить</button>
              <button @click="clearData()" class="btn-primary flush">Сбросить</button>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="errors" v-if="errors.length>0">
      <div>{{errors}}</div>
    </div>

    <div class="row names">
      <selecter
        :class="this.col"
        :ident-of-tab="'common'"
        :set-fields="this.setFields"
        :params-all="this.paramsAll.races"
        @write-data="writeData"
      ></selecter>
      <selecter
        :class="this.col"
        :ident-of-tab="'common'"
        :set-fields="this.setFields"
        :params-all="this.paramsAll.classes"
        @write-data="writeData"
      ></selecter>
      <selecter
        :class="this.col"
        :ident-of-tab="'common'"
        :set-fields="this.setFields"
        :params-all="this.paramsAll.sex"
        @write-data="writeData"
      ></selecter>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Selecter from "./Selecter";

// end of imports
const EventBus = require("../EventBus").default.v;

export default {
  components: {
    Selecter
  },
  props: ["fields", "listOfClassRace"],
  computed: {
    charsForLoad: function() {
      let heroLoad = [];
      heroLoad = [...this.availableHeroes];
      return heroLoad;
    }
  },

  methods: {
    requestDataHero: function(id) {
      //запрашивает данные выбранного героя
      EventBus.$emit("select-hero", id);
      let uid = sessionStorage["uid"];
      axios({
        method: "post",
        url: "http://80.65.23.35:5000/selhero",
        data: {
          id,
          uid
        }
      })
        //loads-hero обрабатывается в SaveCommon
        //результат возвращается сюда при событии new-hero-data, см. ниже
        .then(response => {
          console.log("responseeee", response.data);
          EventBus.$emit("loads-hero", response.data.cd);
          EventBus.$emit("loads-hero-stats", response.data.params.params);
        })

        .catch(error => {
          console.log(error);
        });
    },

    sendData: function() {
      //TODO Доделать сообщение при некорректном заполнении
      Object.keys(this.setFields).forEach((elem, index, array) => {
        if (this.setFields[elem] == 0) {
          let field_string = array[index];

          this.errors = "Заполни все поля правильно";
          return;
        }
      });
      //let saveNewValues = JSON.parse(localStorage.CommonData);
      //localStorage.setItem("CommonData", JSON.stringify(saveNewValues));
      this.get_available();

      EventBus.$emit("send-data");
    },
    writeData: function(data) {
      console.log("emitted", data);
      this.setFields[data[1]] = data[2];
      console.log(this.setFields);

      this.$emit("common-fields", data);
    },
    clearData: function() {
      localStorage.removeItem("CommonData");
      localStorage.removeItem("mainstats");
      localStorage.removeItem("secondaryStats");

      window.location.reload();
    },
    get_available: function() {
      //Список доступных персонажей
      let uid = JSON.stringify({ uid: sessionStorage["uid"] });

      axios({
        method: "get",
        url: "http://80.65.23.35:5000/heroes",
        headers: {
          uid: uid
        }
      }).then(response => {
        this.availableHeroes = [];
        response.data.forEach(elem => {
          this.availableHeroes.push(elem);
        });
      });
    }
  },
  created: function() {
    this.get_available();
    this.setFields = JSON.parse(localStorage.CommonData).common;
    console.log("23213", this.setFields);
  },

  data: function() {
    EventBus.$on("new-hero-data", newField => {
      this.setFields = newField.common;
    });
    // EventBus.$on("write-data", data => {
    //   this.writeData(data[0], data[1]);
    // });

    return {
      availableHeroes: [],
      setFields: "",
      loadedHero: 0,
      paramsAll: {
        races: {
          id: "id_race",
          field_string: "Раса",
          defaultTitle: "Выбери расу",
          currOption: +this.fields.id_race == 0 ? 0 : this.fields.id_race,
          options: this.listOfClassRace.races
        },
        classes: {
          id: "id_class",
          field_string: "Класс",
          defaultTitle: "Выбери класс",
          currOption:
            +this.fields.id_class == 0 && !this.fields.id_class.length > 0
              ? 0
              : this.fields.id_class,
          options: this.listOfClassRace.classes
        },
        sex: {
          id: "sex",
          field_string: "Пол",
          currOption:
            +this.fields.sex == 0 && !this.fields.sex.length > 0
              ? 0
              : this.fields.sex,

          options: [
            { id_param: 1, name_param: "Мужской" },
            { id_param: 2, name_param: "Женский" },
            { id_param: 3, name_param: "Другое" }
          ]
        }
      },
      errors: [],
      currRace: "",
      cirrCLass: "",
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>

<style scoped>
.save-hero {
  margin: 5px;
  border-radius: 5px;
}
.not-selected {
  border-color: rgba(255, 0, 0, 0.5);
}
.errors {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}
.errors > div {
  margin-left: 5px;
}
</style>