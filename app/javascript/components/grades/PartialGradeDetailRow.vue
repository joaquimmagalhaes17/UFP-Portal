<template>
  <div>
    <div class="inline field">
      <label>Modelo: </label>
      <span>{{rowData.model}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Unidade Curricular: </label>
      <span>{{rowData.curricular_unit}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Época: </label>
      <span>{{rowData.element}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Classif. Final: </label>
      <span>{{rowData.grade}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Lançado por: </label>
      <span>{{rowData.released_by}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Registo: </label>
      <span>{{rowData.date_registration}}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    rowData: {
      type: Object,
      required: true
    },
    rowIndex: {
      type: Number
    }
  },
}
</script>
