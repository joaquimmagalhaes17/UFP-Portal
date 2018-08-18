<template>
  <div>
    <div class="inline field">
      <label>Descricao: </label>
      <span>{{rowData.curricular_unit}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Curso (PC): </label>
      <span>{{rowData.course}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Resultado: </label>
      <span>{{rowData.grade}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Lançamento: </label>
      <span>{{rowData.release_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Ano Lectivo: </label>
      <span>{{rowData.year}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Consulta: </label>
      <span>{{rowData.consultation_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>Oral: </label>
      <span>{{rowData.oral}}</span>
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
