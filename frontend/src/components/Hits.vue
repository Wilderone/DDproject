<template>
  <div class="wrapper" v-show="isCurrentTab">
    <div class="container hits">
      <div class="row hitsrow sect-head">
        <span>Хиты</span>
      </div>

      <div class="hitsvalues">
        <div
          class="row heal-row"
          :class="[item.classBs, item.classDescrMain]"
          v-for="item in hitFields"
          :key="item.classDescrMain"
        >
          <div>
            <span class="title-span">{{item.title}}</span>
          </div>
          <div class="buttons">
            <div>
              <button id="plusButton" class="btn-secondary">+</button>
              <button id="minusButton" class="btn-secondary">-</button>
            </div>
          </div>
          <div class="hits-box">
            <div class="hits-main">
              <div :class="[item.classDescrAll]">
                <input class="form-control" :id="item.classDescrAll" type="number" />
              </div>
            </div>
            <div class="hits-modif">
              <div :class="[item.classDescrModif]">
                <input class="form-control" :id="item.classDescrModif" type="number" />
              </div>
            </div>
          </div>
          <div class="summary-field">
            <input :id="item.summary" class="form-control" disabled />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
const EventBus = require("../EventBus").default.v;

export default {
  props: {
    classbs: String
  },
  data: function() {
    EventBus.$on("current-tag", tag => {
      if (tag == "hits-tab") {
        this.isCurrentTab = true;
      } else {
        this.isCurrentTab = false;
      }
    });
    return {
      isCurrentTab: false,

      hitFields: [
        {
          classBs: this.classbs,
          classDescrMain: "hp",
          classDescrAll: "hp-all",
          classDescrModif: "hp-modif",
          title: "HP",
          summary: "sum-hp"
        },
        {
          classBs: this.classbs,
          classDescrMain: "injure",
          classDescrAll: "injure-all",
          classDescrModif: "injure-modif",
          title: "Ранение",
          summary: "sum-injure"
        },
        {
          classBs: this.classbs,
          classDescrMain: "healing",
          classDescrAll: "healing-all",
          classDescrModif: "healing-modif",
          title: "Исц:",
          summary: "sum-healing"
        },
        {
          classBs: this.classbs,
          classDescrMain: "healing-per-day",
          classDescrAll: "healing-per-day-all",
          classDescrModif: "healing-per-day-modif",
          title: "Исц/день:",
          summary: "sum-hpd"
        }
      ]
    };
  }
};
</script>
<style scoped>
.heal-row {
  display: flex;
  flex-direction: column;
}
.hits-box {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
}
input {
  max-width: 70px;
  margin: 5px;
}
.title-span {
  word-break: break-all;
}
.hits-main {
  display: flex;
  justify-content: center;
  align-items: center;
}
.hitsvalues {
  display: flex;
  flex-wrap: wrap;
}

button {
  margin: 0 3px 0 3px;
  width: 50px;

  align-items: center;
  text-align: center;
}
</style>