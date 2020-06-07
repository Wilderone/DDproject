<template>
  <div v-show="isCurrentTab">
    <div class="row">
      <div class="col-6 col-sm-6 col-md-7 col-lg-7 col-xl-7 sec-chars-title">
        <span>Вторичная характеристика</span>
      </div>
      <div class="col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 values sec-chars-title">
        <span>Модиф</span>
      </div>
      <div class="col-3 col-sm-3 col-md-2 col-lg-2 col-xl-2 sec-chars-title">
        <span>Тренировка</span>
      </div>
    </div>
    <div
      v-for="(item, index) in secChars"
      v-bind:key="item.tagName"
      :class="[item.tagName, index%2==0 ? 'char-rows-grey' : 'char-rows-white']"
      class="row"
    >
      <div class="col-2 col-sm-6 col-md-7 col-lg-7 col-xl-7">
        <span>{{item.field_string}}</span>
      </div>
      <div class="col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 values">
        <button
          @click.prevent="changeValue(item, 'minus')"
          id="minusbtn"
          :class="item.tagName"
          class="secondary-button acrobatics mr-1"
        >-</button>
        <input
          type="number"
          class="form-control"
          :id="item.tagName"
          disabled="true"
          :name="item.tagName"
          :value="item.field_int"
          @change="$emit('changeChar', $event.target)"
        />
        <button
          @click.prevent="changeValue(item, 'plus')"
          id="plusbtn"
          :class="item.tagName"
          class="secondary-button ml-1"
        >+</button>
      </div>
      <div class="col-2 col-sm-3 col-md-2 col-lg-2 col-xl-2">
        <input
          class="form-check-input position-static trainycheckbox"
          type="checkbox"
          :id="item.tagName+'train'"
          :value="watchValue"
          aria-label="..."
          @click="changeValue(item, 'train')"
          :checked="item.training === true ? 'checked':''"
        />
      </div>
    </div>
  </div>
</template>
<script>
//import func from "../../vue-temp/vue-editor-bridge";
const EventBus = require("../EventBus").default.v;
const Tab = require("./Tabs").default.data.selectedTab;
export default {
  methods: {
    changeValue: function(item, oper) {
      if (oper == "train") {
        item.training = !item.training;
        item.training ? (item.field_int += 5) : (item.field_int -= 5);
      } else {
        oper === "plus" ? item.field_int++ : item.field_int--;
      }
      let secStatsForLs = JSON.stringify(this.secChars);
      localStorage.setItem("secondaryStats", secStatsForLs);
      // localStorage.setItem(item.tagName, item.value);
    }
  },
  props: {
    secChars: Array
  },
  computed: {
    watchValue: function() {
      return this.secChars.field_int;
    }
  },

  data: function() {
    EventBus.$on("current-tag", tag => {
      if (tag == "secondary-tab") {
        this.isCurrentTab = true;
      } else {
        this.isCurrentTab = false;
      }
    });

    return {
      isCurrentTab: false,
      checked: false
    };
  }
};
</script>