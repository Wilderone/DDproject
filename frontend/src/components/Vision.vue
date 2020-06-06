<template>
  <div>
    <div class="row size">
      <div v-for="(param) in paramsAll" :key="param.id" :class="[col, param.id]">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text">{{param.title}}</span>
          </div>
          <input
            :id="param.id"
            type="text"
            class="form-control"
            :value="setFields[param.id]"
            @change="writeData(param.id, $event.target.value)"
          />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
const EventBus = require("../EventBus").default.v;
export default {
  props: ["fields"],
  methods: {
    writeData: function(id, value) {
      this.fields[id] = value;
      this.$emit("common-fields", ["visLang", id, value]);
    }
  },
  created: function() {
    this.setFields = JSON.parse(localStorage.CommonData).visLang;
    console.log("VISLANG", this.setFields);
  },
  data() {
    EventBus.$on("new-hero-data", newField => {
      this.setFields = newField.visLang;
    });
    return {
      setFields: "",
      paramsAll: [
        { id: "vision", title: "Зрение", value: "" },
        { id: "language_hero", title: "Язык", value: "" }
      ],
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>