<template>
  <div>
    <!-- v-for="(index, param) in Object.keys(paramsAll)" :key="index" -->

    <select
      :value="setFields[paramsAll.id]"
      @change="[writeData(paramsAll.id, $event.target.value), $event.target.value == 0 ?
           $event.target.classList.add('not-selected') : 
           $event.target.classList.remove('not-selected')]"
      :id="0"
      type="text"
      :class="['custom-select']"
    >
      <!-- v-model="setFields[param.id]" -->
      <option
        disabled
        value="0"
      >Выбери {{paramsAll.field_string == 'Раса' ? 'Расу' : paramsAll.field_string}}</option>
      <option
        v-for="(param, index) in Object.values(paramsAll.options)"
        :key="index"
        :value="Object.values(param)[0]"
        :v-model="param.currOption"
      >{{Object.values(param)[1]}}</option>
    </select>
  </div>
</template>
<script>
const EventBus = require("../EventBus").default.v;
export default {
  props: {
    paramsAll: Object,
    setFields: Object,
    identOfTab: String
  },
  methods: {
    writeData: function(param, event) {
      console.log(this.setFields);
      this.setFields[param] = event;
      this.$emit("write-data", [this.identOfTab, param, event]);
    }
  },
  //   writeData: function(id, value) {
  //   this.setFields[id] = value;
  //   this.$emit("common-fields", ["common", id, value]);
  // },
  data: function() {
    return {
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>

<style scoped>
.not-selected {
  border-color: rgba(255, 0, 0, 0.5);
}
</style>