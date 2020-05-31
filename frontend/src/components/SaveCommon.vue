<template>
  <div></div>
</template>
<script>
const EventBus = require("../EventBus").default.v;

export default {
  props: ["commonData"],
  data: function() {
    EventBus.$on("send-data", () => {
      let commonDataForLS = JSON.stringify(this.commonData);
      localStorage.setItem("CommonData", commonDataForLS);
    });
    return {};
  }
};
</script>
