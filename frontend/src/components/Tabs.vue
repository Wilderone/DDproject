<template>
  <nav class="container charnav">
    <div class="container charnav">
      <div
        v-for="tab in tabs"
        :key="tab.tag"
        class="select__selectors col-12 col-md-3 col-sm-3 col-lg-3 col-xl-3"
        :class="[tab.tag, {choosentab: selectedTab ===tab.tag}]"
        @click="changeSelected(tab.tag)"
      >{{tab.title}}</div>
    </div>
  </nav>
</template>
<script>
const EventBus = require("../EventBus").default.v;
export default {
  methods: {
    changeSelected: function(tag) {
      this.selectedTab = tag;

      EventBus.$emit("current-tag", this.selectedTab);
    }
  },
  data: function() {
    return {
      tabs: [
        { title: "Сводка", tag: "sumar-tab" },
        { title: "Хиты", tag: "hits-tab" },
        { title: "Атака, Защита, Движение", tag: "adm-tab" },
        { title: "Основные характеристики", tag: "primary-tab" },
        { title: "Вторичные характеристики", tag: "secondary-tab" },
        { title: "Записная книга", tag: "notes-tab" }
      ],
      selectedTab: localStorage.selectedTab
        ? localStorage.selectedTab
        : "sumar-tab"
    };
  }
};
</script>
<style scoped>
.charnav {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -ms-flex-direction: row;
  flex-direction: row;
}

.charnav__select:nth-child(2) {
  -ms-flex-pack: distribute;
  justify-content: space-around;
}

.charnav__select {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-wrap: wrap;
  flex-wrap: wrap;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -ms-flex-direction: row;
  flex-direction: row;
  -webkit-box-pack: justify;
  -ms-flex-pack: justify;
  justify-content: space-between;
  margin: 5px 5px 5px 5px;
  color: #3278d4;
}

.charnav {
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
}
.charnav__select {
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -ms-flex-direction: row;
  flex-direction: row;
}

.choosentab {
  border-top: 1px solid grey;
  border-left: 1px solid grey;
  border-right: 1px solid grey;
  border-radius: 5px;
  padding: 6px;
  background-color: rgba(218, 212, 212, 0.215);
}
@media screen and (max-width: 780px) {
  .select__selectors {
    min-width: 30%;
  }
}
.select__selectors {
  text-align: center;
  cursor: pointer;
  word-wrap: break-word;
  margin: 5px;
}

.select__selectors:after {
  content: "";
  display: block;
  width: 0%;
  height: 3px;
  background-color: #e40f0fc5;
  margin-top: 4px;
  -webkit-transition: 0.4s;
  transition: 0.4s;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}

.select__selectors:hover:after {
  width: 60%;
}
</style>