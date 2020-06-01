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
            :value="param.value"
            @change="writeData(param.id, $event.target.value)"
          />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: ["fields"],
  methods: {
    writeData: function(id, value) {
      this.fields[id] = value;
    }
  },
  data() {
    return {
      paramsAll: [
        { id: "vision", title: "Зрение", value: this.fields.vision },
        { id: "language_hero", title: "Язык", value: this.fields.language_hero }
      ],
      col: "col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3"
    };
  }
};
</script>