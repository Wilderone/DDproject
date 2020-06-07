<template>
  <div>
    <div class="row size">
      <div v-for="param in paramsAll" :key="param.id" :class="[col, param.id]">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text">{{param.field_string}}</span>
          </div>
          <input
            :id="param.id"
            :type="param.id == 'name_hero' ? 'text' : 'number'"
            class="form-control"
            @change="writeData(param.id, $event.target.value)"
            :value="setFields[param.id]"
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
      this.setFields[id] = value;
      this.$emit("common-fields", ["nameSexExp", id, value]);
    }
  },
  created: function() {
    this.setFields = JSON.parse(localStorage.CommonData).nameSexExp;
    console.log("23213", this.setFields);
  },
  data: function() {
    EventBus.$on("new-hero-data", newField => {
      this.setFields = newField.nameSexExp;
    });
    return {
      setFields: "",
      paramsAll: [
        { id: "name_hero", field_string: "Имя", value: "" },
        {
          id: "level_hero",
          field_string: "Уровень",
          value: ""
        },
        { id: "currentexp", field_string: "Опыт", value: "" }
      ],
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>