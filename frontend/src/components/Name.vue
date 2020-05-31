<template>
  <div class="container name-cont">
    <div class="row name">
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 namecol input-group-prepend rowname">
        <input id="nameinp" class="form-control nameinp" type="text" placeholder="Имя" />
      </div>
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 gendercol rowname">
        <div class="input-group genderinp">
          <select id="genderinp" class="custom-select">
            <option selected>Пол</option>
            <option value="1">Мужской</option>
            <option value="2">Женский</option>
            <option value="3">Другое</option>
          </select>
        </div>
      </div>
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 expcol rowname">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text" id="basic-addon1">exp</span>
          </div>
          <input id="exp" type="text" class="form-control" placeholder="exp" />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
const EventBus = require("../EventBus").default.v;
export default {
  data: function() {
    return {};
  }
};
</script>