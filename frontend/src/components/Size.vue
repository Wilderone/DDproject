<template>
  <div>
    <div class="row size">
      <div v-for="(param) in paramsAll" :key="param.id" :class="[col, param.id]">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text">{{param.field_string}}</span>
          </div>
          <input
            :id="param.id"
            type="number"
            :value="setFields[param.id]"
            class="form-control"
            @change="writeData(param.id, $event.target.value)"
          />
        </div>
      </div>
      <div :class="col">
        <select
          id="size"
          v-model="setFields['size']"
          @change="writeData('size', $event.target.value)"
          class="form-control"
        >
          <option
            v-for="size in sizeId"
            :key="size.id_field"
            :value="size.id_field"
          >{{size.name_field}}</option>
        </select>
      </div>
    </div>
  </div>
</template>
<script>
const EventBus = require("../EventBus").default.v;
export default {
  props: ["fields", "sizeId"],
  methods: {
    writeData: function(id, value) {
      console.log(id, value);
      this.setFields[id] = value;
      this.$emit("common-fields", ["heigWeigSize", id, value]);
      console.log("dsads", this.fields);
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
        { id: "height", field_string: "Рост", value: "" },
        { id: "weight", field_string: "Вес", value: "" }
      ],
      value: " ",
      selectValue: "",
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>