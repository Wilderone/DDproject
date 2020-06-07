<template>
  <div>
    <div class="row size">
      <div v-for="(param) in paramsAll" :key="param.id" :class="[col, param.id]">
        <div class="input-group mb-3">
          <div class="input-group-prepend"></div>
          <select
            :id="param.id"
            type="text"
            class="form-control"
            v-model="setFields[param.id]"
            @change="writeData(param.id, $event.target.value)"
          >
            <option disabled value="0">Выбери {{param.field_string}}</option>
            <option
              v-for="item in param.options"
              :key="item.id_field"
              :value="item.id_field"
            >{{item.name_field}}</option>
          </select>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
const EventBus = require("../EventBus").default.v;
export default {
  props: ["fields", "visLangId"],
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
        {
          id: "vision",
          field_string: "Зрение",
          value: "",
          options: this.visLangId.vision
        },
        {
          id: "language_hero",
          field_string: "Язык",
          value: "",
          options: this.visLangId.language
        }
      ],
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>