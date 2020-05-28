import Vue from "vue";
import Common from "./components/Common";
import Name from "./components/Name";
import Size from "./components/Size";
import Vision from "./components/Vision";

Vue.config.productionTip = false;

new Vue({
  render: (h) => h(Common),
}).$mount("#common");
new Vue({
  render: (h) => h(Name),
}).$mount("#name");
new Vue({
  render: (h) => h(Size),
}).$mount("#size");

new Vue({
  render: (h) => h(Vision),
}).$mount("#vision");
