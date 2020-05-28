<template>
  <div class="head container">
    <div class="row person">
      <div class="col-12 col-sm-6 col-md-6 choosehero">
        <form id="personage" action="#">
          <div class="input-group mb-3 genderinp">
            <div class="input-group-prepend">
              <select id="heroes" class="custom-select">
                <option selected>Выбери персонажа</option>
              </select>
              <slot></slot>
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="row names">
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
        <input id="race" type="text" class="race form-control" placeholder="Раса" />
      </div>
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 racelevelcol">
        <input id="class" type="text" class="class form-control" placeholder="Класс" />
      </div>
      <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
        <input id="lvl" type="number" class="level form-control" placeholder="Уровень" />
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
</style>