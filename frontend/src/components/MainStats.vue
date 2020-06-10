<template>
  <div class="wrapper" v-show="isCurrentTab">
    <div class="row">
      <div class="col char-title sect-head">
        <span>Характеристики</span>
      </div>
    </div>
    <div class="row сhar-row d-flex flex-nowrap char-table-title">
      <div class="col">
        <span>Характеристика</span>
      </div>

      <div class="col">
        <span>Модификатор</span>
      </div>
    </div>
    <div v-for="(item, index) in this.mainParams" :key="index">
      <div
        :class="[item.mainTagName , index%2==0 ? 'char-rows-grey' : 'char-rows-white']"
        class="row char-rows"
      >
        <div :class="[mianStatTitlebs, item.textTagName, 'main-charsk-text']">
          <span>{{item.field_string}}</span>
        </div>
        <div :class="mainStatsInputbs" class="values">
          <button
            @click.prevent="changeValue(index, 'base', 'minus')"
            class="secondary-button mr-1 plusmainbase"
          >-</button>
          <input
            type="number"
            class="form-control mainCharacts"
            :id="item.idBase"
            disabled="true"
            :value="item.field_int"
          />
          <button
            @click.prevent="changeValue(index, 'base', 'plus')"
            class="secondary-button ml-1 minusmainbase"
          >+</button>
        </div>
        <div :class="[mainStatsInputbs, 'modif']">
          <button
            @click.prevent="changeValue(index, 'modif', 'minus')"
            class="secondary-button mr-1 plusmainmodif"
          >-</button>
          <input
            type="number"
            class="form-control mainCharacts"
            :id="item.idModif"
            disabled="true"
            :value="item.modify_param"
          />
          <button
            @click.prevent="changeValue(index, 'modif', 'plus')"
            class="secondary-button ml-1 minusmainmodif"
          >+</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
// let mainstatsForLoad = JSON.parse(localStorage.mainstats);
// console.log(mainstatsForLoad);

const EventBus = require("../EventBus").default.v;
export default {
  props: {
    mainStatClasses: Object,
    rows: Array
  },
  methods: {
    changeValue: function(index, base, oper) {
      let updated = this.mainParams[index];
      // Хак или Костыль? Хак на грани Костыля или Костыль на грани Хака?
      base === "base" && oper === "plus" ? updated.field_int++ : "";
      base === "base" && oper === "minus" ? updated.field_int-- : "";
      base === "modif" && oper === "plus" ? updated.modify_param++ : "";
      base === "modif" && oper === "minus" ? updated.modify_param-- : "";

      let statsForLS = JSON.stringify(this.mainParams);
      localStorage.setItem("mainstats", statsForLS);
    }
  },
  created: function() {
    if (localStorage.mainstats) {
      this.mainParams = JSON.parse(localStorage.mainstats);
    } else {
      this.mainParams = this.rows;
    }
  },

  data: function() {
    EventBus.$on("main-characts-loads", loadedData => {
      this.mainParams = loadedData;
      console.log("maindata", loadedData);
    });
    EventBus.$on("current-tag", tag => {
      if (tag == "primary-tab") {
        this.isCurrentTab = true;
      } else {
        this.isCurrentTab = false;
      }
    });
    return {
      isCurrentTab: false,
      mainParams: "",
      mainStatsInputbs: "col-5 col-sm-4 col-md-3 col-lg-3 col-xl-3",
      mianStatTitlebs: "col-2 col-sm-4 col-md-4 col-lg-4 col-xl-4"
    };
  }
};
</script>