<template>
  <div id="content-wrap" class="content-wrapper" style="min-height: 926px;">
  <div>
    <section class="content-header">
      <ol class="breadcrumb">
        <li>
          <router-link to="/"><i class="fa fa-dashboard"></i> Home</router-link>
        </li>
        <li class="active">Provisional Final Grades</li>
      </ol>
    </section>
    <section class="content">
      <vuetable ref="vuetable"
                :api-url="api_url"
                :fields="fields"
                :css="css.table"
                pagination-path=""
                track-by="curricular_unit"
                detail-row-component="final-detail-row"
                @vuetable:cell-clicked="onCellClicked"
      ></vuetable>
    </section>
  </div>
  </div>
</template>

<script>
  import Vuetable from 'vuetable-2/src/components/Vuetable'
  import Vue from 'vue/dist/vue.esm'
  import VueEvents from 'vue-events'
  import FinalGradeDetailRow from './FinalGradeDetailRow'

  Vue.use(VueEvents)
  Vue.component('final-detail-row', FinalGradeDetailRow)
  export default {
    name: "FinalGradesComponent",
    components: {
      Vuetable,
    },
    data() {
      return {
        fields: [],
        css: {
          table: {
            tableClass: 'table table-bordered table-striped table-hover',
            ascendingIcon: 'glyphicon glyphicon-chevron-up',
            descendingIcon: 'glyphicon glyphicon-chevron-down'
          },
        },
        api_url: '/api/grades/provisional/final?table_format=1&token=' + this.$ls.get('token'),
      }
    },
    methods: {
      onCellClicked(data, field, event) {
        this.$refs.vuetable.toggleDetailRow(data.curricular_unit)
      },
      handleScreenChange() {
        this.configTableRows()
        this.normalizeFields()
      },
      normalizeFields: function normalizeFields() {
        this.$refs.vuetable.tableFields = [];
        let self = this.$refs.vuetable;
        let obj = void 0;
        this.fields.forEach(function (field, i) {
          if (typeof field === 'string') {
            obj = {
              name: field,
              title: self.setTitle(field),
              titleClass: '',
              dataClass: '',
              callback: null,
              visible: true
            };
          } else {
            obj = {
              name: field.name,
              width: field.width,
              title: field.title === undefined ? self.setTitle(field.name) : field.title,
              sortField: field.sortField,
              titleClass: field.titleClass === undefined ? '' : field.titleClass,
              dataClass: field.dataClass === undefined ? '' : field.dataClass,
              callback: field.callback === undefined ? '' : field.callback,
              visible: field.visible === undefined ? true : field.visible
            };
          }
          self.tableFields.push(obj);
        });
      },
      configTableRows() {
        switch (this.$mq) {
          case "mobile":
            this.fields = [
              {
                name: 'curricular_unit',
                title: 'Unidade Curricular'
              },
              {
                name: 'epoch',
                title: 'Época'
              },
              {
                name: 'final_grade',
                title: 'Classificação Final'
              }
            ]
            break;

          case "tablet":
            this.fields = [
              {
                name: 'curricular_unit',
                title: 'Unidade Curricular'
              },
              {
                name: 'epoch',
                title: 'Época'
              },
              {
                name: 'oral_ex',
                title: 'Exame Oral'
              },
              {
                name: 'write_ex',
                title: 'Exame escrito'
              },
              {
                name: 'final_grade',
                title: 'Classificação Final'
              }
            ]
            break;

          case "laptop":
            this.fields = [
              {
                name: 'curricular_unit',
                title: 'Unidade Curricular'
              },
              {
                name: 'epoch',
                title: 'Época'
              },
              {
                name: 'oral_ex',
                title: 'Exame Oral'
              },
              {
                name: 'write_ex',
                title: 'Exame escrito'
              },
              {
                name: 'final_grade',
                title: 'Classificação Final'
              },
              {
                name: 'consultation_date',
                title: 'Consulta'
              },
              {
                name: 'oral_date',
                title: 'Data Oral'
              }
            ]
            break;

          default:
            this.fields = [
              {
                name: 'curricular_unit',
                title: 'Unidade Curricular'
              },
              {
                name: 'epoch',
                title: 'Época'
              },
              {
                name: 'oral_ex',
                title: 'Exame Oral'
              },
              {
                name: 'write_ex',
                title: 'Exame escrito'
              },
              {
                name: 'final_grade',
                title: 'Classificação Final'
              },
              {
                name: 'consultation_date',
                title: 'Consulta'
              },
              {
                name: 'oral_date',
                title: 'Data Oral'
              },
              {
                name: 'year',
                title: 'Ano letivo'
              },
              {
                name: 'date_registration',
                title: 'Data lançamento'
              },
              {
                name: 'released_by',
                title: 'Lançada por'
              }
            ]
        }
      }
    },
    beforeDestroy: function () {
      window.removeEventListener('resize', this.handleScreenChange)
    },
    beforeMount() {
      window.addEventListener('resize', this.handleScreenChange)
      this.configTableRows()
    }
  }
</script>
<style>

</style>
