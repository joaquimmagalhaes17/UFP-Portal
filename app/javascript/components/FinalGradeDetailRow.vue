<template>
  <div>
    <div class="inline field">
      <label>Ano Lectivo: </label>
      <span>{{rowData.year}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Unidade Curricular: </label>
      <span>{{rowData.curricular_unit}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Época: </label>
      <span>{{rowData.epoch}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Exame Oral: </label>
      <span>{{rowData.oral_ex}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Exame Escrito: </label>
      <span>{{rowData.write_ex}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Classif. Final: </label>
      <span>{{rowData.final_grade}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Consulta: </label>
      <span>{{rowData.consultation_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Data Oral: </label>
      <span>{{rowData.oral_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Registo: </label>
      <span>{{rowData.date_registration}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Lançado por: </label>
      <span>{{rowData.released_by}}</span>
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
