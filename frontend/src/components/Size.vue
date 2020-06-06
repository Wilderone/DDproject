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
            :value="setFields[param.id]"
            class="form-control"
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
      this.$emit("common-fields", ["heigWeigSize", id, value]);
    }
  },
  created: function() {
    this.setFields = JSON.parse(localStorage.CommonData).heigWeigSize;
    console.log("SIZE", this.setFields);
  },

  data: function() {
    EventBus.$on("new-hero-data", newField => {
      this.setFields = newField.heigWeigSize;
    });
    return {
      setFields: "",
      paramsAll: [
        { id: "height", title: "Рост", value: "" },
        { id: "weight", title: "Вес", value: "" },
        { id: "size", title: "Размер", value: "" }
      ],
      value: " ",
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>