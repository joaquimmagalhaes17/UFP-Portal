<template>
  <div>
    <div class="inline field">
      <label>{{ $t('final.table.year') }}:</label>
      <span>{{rowData.year}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.curricular_unit') }}:</label>
      <span>{{rowData.curricular_unit}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.epoch') }}:</label>
      <span>{{rowData.epoch}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.oral_ex') }}:</label>
      <span>{{rowData.oral_ex}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.write_ex') }}:</label>
      <span>{{rowData.write_ex}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.final_grade') }}:</label>
      <span>{{rowData.final_grade}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.consultation_date') }}:</label>
      <span>{{rowData.consultation_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.oral_date') }}:</label>
      <span>{{rowData.oral_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.date_registration') }}:</label>
      <span>{{rowData.date_registration}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('final.table.released_by') }}:</label>
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
