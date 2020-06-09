<template>
  <div>
    <div class="row size">
      <!-- <select
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
      </select>-->
      <selecter
        :ident-of-tab="'visLang'"
        :class="this.col"
        :set-fields="this.setFields"
        :params-all="this.paramsAll.language"
        @write-data="writeData"
      ></selecter>
      <selecter
        :ident-of-tab="'visLang'"
        :class="this.col"
        :set-fields="this.setFields"
        :params-all="this.paramsAll.vision"
        @write-data="writeData"
      ></selecter>
    </div>
  </div>
</template>
<script>
import Selecter from "./Selecter";
const EventBus = require("../EventBus").default.v;

export default {
  props: ["fields", "visLangId"],
  components: { Selecter },
  methods: {
    writeData: function(data) {
      console.log("emitted", data);
      this.setFields[data[1]] = data[2];
      console.log(this.setFields);

      this.$emit("common-fields", data);
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
    // EventBus.$on("write-data", data => {
    //   this.writeData(data[0], data[1]);
    // });
    return {
      setFields: "",
      paramsAll: {
        vision: {
          id: "vision",
          field_string: "Зрение",
          value: "",
          options: this.visLangId.vision
        },
        language: {
          id: "language_hero",
          field_string: "Язык",
          value: "",
          options: this.visLangId.language
        }
      },
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>