<template>
  <div class="head container">
    <div class="row person d-flex justify-content-center">
      <div class="col-12 col-sm-6 col-md-6 choosehero">
        <form id="personage" action="#">
          <div class="input-group mb-3 save-load">
            <div class="input-group-prepend">
              <select id="heroes" class="custom-select">
                <option selected>Выбери персонажа</option>
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

    <div class="row names">
      <div :class="col" v-for="param in paramsAll" :key="param.id">
        <select
          @change="writeData(param.id, $event.target.value)"
          :value="param.currOption"
          :id="param.id"
          type="text"
          class="custom-select"
          :placeholder="param.title"
        >
          <option v-for="item in param.options" :key="item.title" :value="item.value">{{item.title}}</option>
        </select>
      </div>
    </div>
  </div>
</template>

<script>
const EventBus = require("../EventBus").default.v;
export default {
  props: ["fields"],
  methods: {
    sendData: function() {
      EventBus.$emit("send-data");
    },
    writeData: function(id, value) {
      this.fields[id] = value;
    },
    clearData: function() {
      localStorage.removeItem("CommonData");
      localStorage.removeItem("mainstats");
      localStorage.removeItem("secondaryStats");
      window.refre;
      // localStorage.removeItem('selectedTab')
    }
  },

  data: function() {
    return {
      paramsAll: [
        {
          id: "race",
          title: "Раса",
          currOption:
            +this.fields.race == 0 && !this.fields.race.length > 0
              ? 0
              : this.fields.race,
          options: [
            { value: 0, title: "Выберу расу" },
            { value: 1, title: "Человек" },
            { value: 2, title: "Эльф" },
            { value: 3, title: "Дварф" }
          ]
        },
        {
          id: "class",
          title: "Класс",
          currOption:
            +this.fields.class == 0 && !this.fields.class.length > 0
              ? 0
              : this.fields.class,
          options: [
            { value: 0, title: "Выбери Класс" },
            { value: 1, title: "Воин" },
            { value: 2, title: "Маг" },
            { value: 3, title: "Следопыт" },
            { value: 4, title: "Жрец" },
            { value: 5, title: "Колдун" }
          ]
        },
        {
          id: "sex",
          title: "Пол",
          currOption:
            +this.fields.sex == 0 && !this.fields.sex.length > 0
              ? 0
              : this.fields.sex,

          options: [
            { value: 0, title: "Выбери пол" },
            { value: 1, title: "Мужской" },
            { value: 2, title: "Женский" },
            { value: 3, title: "Другое" }
          ]
        }
      ],
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
</style>