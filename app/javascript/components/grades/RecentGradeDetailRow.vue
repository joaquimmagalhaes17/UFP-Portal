<template>
  <div>
    <div class="inline field">
      <label>{{ $t('recent.table.curricular_unit')}}: </label>
      <span>{{rowData.curricular_unit}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('recent.table.course')}}: </label>
      <span>{{rowData.course}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('recent.table.grade')}}: </label>
      <span>{{rowData.grade}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('recent.table.release_date')}}: </label>
      <span>{{rowData.release_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('recent.table.year')}}: </label>
      <span>{{rowData.year}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('recent.table.consultation_date')}}: </label>
      <span>{{rowData.consultation_date}}</span>
    </div>
    <br>
    <div class="inline field">
      <label>{{ $t('recent.table.oral')}}: </label>
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
