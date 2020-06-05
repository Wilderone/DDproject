<template>
  <div>
    <div class="row size">
      <div v-for="param in paramsAll" :key="param.id" :class="[col, param.id]">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text">{{param.title}}</span>
          </div>
          <input
            :id="param.id"
            type="text"
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
      this.$emit("common-fields", ["common", id, value]);
    }
  },
  computed: {
    updateField: function() {
      let updatedField = JSON.parse(localStorage.CommonData).nameSexExp;
      return "updatedField";
    }
  },
  data: function() {
    EventBus.$on("new-hero-data", newField => {
      this.setFields = newField.nameSexExp;
    });
    return {
      setFields: this.updateField,
      paramsAll: [
        { id: "name_hero", title: "Имя", value: this.setFields.name_hero },
        {
          id: "level_hero",
          title: "Уровень",
          value: this.setFields.level_hero
        },
        { id: "currentexp", title: "Опыт", value: this.setFields.currentexp }
      ],
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>