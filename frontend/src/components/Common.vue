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
                  v-for="(hero, index) in this.availableHeroes"
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
      <div v-for="(error, index) in errors" :key="index">{{error}}</div>
    </div>
    <div class="row names">
      <div :class="col" v-for="param in paramsAll" :key="param.id">
        <select
          @change="[writeData(param.id, $event.target.value), $event.target.value == 0 ?
           $event.target.classList.add('not-selected') : 
           $event.target.classList.remove('not-selected')]"
          :value="fields[param.id]"
          :id="param.id"
          type="text"
          :class="['custom-select']"
          :placeholder="fields[param.id]"
        >
          <option
            v-for="item in param.options"
            :key="item.name_field"
            :value="item.id_field"
          >{{item.name_field}}</option>
        </select>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
const EventBus = require("../EventBus").default.v;
export default {
  props: ["fields", "listOfClassRace", "availableHeroes", "get_available"],
  computed: {
    charsForLoad: function() {
      let heroLoad = [];
      //console.log(this.availableHeroes);
      this.availableHeroes.forEach(elem => {
        heroLoad.unshift(elem);
      });
      return heroLoad;
    }
  },

  methods: {
    requestDataHero: function(id) {
      let uid = JSON.parse(sessionStorage["uid"]).current_user;
      axios({
        method: "post",
        url: "http://80.65.23.35:5000/selhero",
        data: {
          id,
          uid
        }
      })
        .then(response => {
          console.log(response.data);
        })
        .catch(error => {
          console.log(error);
        });
    },
    consolelog: function(data) {
      console.log(data);
    },
    sendData: function() {
      //TODO Доделать сообщение при некорректном заполнении
      Object.keys(this.fields).forEach((index, elem, array) => {
        if (this.fields[index] == 0) {
          this.errors.push({ field: index });
          return;
        } else {
          this.errors = [];
        }
      });
      this.get_available();

      EventBus.$emit("send-data");
    },
    writeData: function(id, value) {
      this.fields[id] = value;
    },
    clearData: function() {
      localStorage.removeItem("CommonData");
      localStorage.removeItem("mainstats");
      localStorage.removeItem("secondaryStats");
      window.location.reload();
    }
  },

  data: function() {
    return {
      loadedHero: 0,
      paramsAll: [
        {
          id: "id_race",
          title: "Раса",
          defaultTitle: "Выбери расу",
          currOption: +this.fields.id_race == 0 ? 0 : this.fields.id_race,
          options: this.listOfClassRace.races
        },
        {
          id: "id_class",
          title: "Класс",
          defaultTitle: "Выбери класс",
          currOption:
            +this.fields.id_class == 0 && !this.fields.id_class.length > 0
              ? 0
              : this.fields.id_class,
          options: this.listOfClassRace.classes
        },
        {
          id: "sex",
          title: "Пол",
          currOption:
            +this.fields.sex == 0 && !this.fields.sex.length > 0
              ? 0
              : this.fields.sex,

          options: [
            { id_field: 0, name_field: "Выбери пол" },
            { id_field: 1, name_field: "Мужской" },
            { id_field: 2, name_field: "Женский" },
            { id_field: 3, name_field: "Другое" }
          ]
        }
      ],
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