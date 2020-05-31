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
              <button class="btn-primary flush">Сбросить</button>
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="row names">
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
        <select id="race" type="text" class="race custom-select" placeholder="Раса">
          <option value="0">Раса</option>
          <option name="Human" value="1">Человек</option>
          <option name="Dwarf" value="2">Дварф</option>
          <option name="Elf" value="3">Эльф</option>
        </select>
      </div>
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 racelevelcol">
        <select id="class" type="text" class="class custom-select" placeholder="Класс">
          <option value="0">Класс</option>
          <option name="Warrior" value="1">Воин</option>
          <option name="Mage" value="2">Маг</option>
          <option name="Hunter" value="3">Следопыт</option>
          <option name="Priest" value="4">Жрец</option>
          <option name="Warlock" value="5">Колдун</option>
        </select>
      </div>
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
        <input id="lvl" type="number" class="level form-control" placeholder="Уровень" />
      </div>
    </div>
  </div>
</template>

<script>
const EventBus = require("../EventBus").default.v;
export default {
  methods: {
    sendData: function() {
      EventBus.$emit("send-data");
    }
  }
};
</script>

<style scoped>
.save-hero {
  margin: 5px;
  border-radius: 5px;
}
</style>