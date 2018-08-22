<template>
  <div 
    id="content-wrap" 
    class="content-wrapper" 
    style="min-height: 926px;">
    <div>
      <section class="content-header">
        <ol class="breadcrumb">
          <li><router-link to="/"><i class="fa fa-dashboard"/> Home</router-link></li>
          <li class="active">Recent Grades</li>
        </ol>
      </section>
      <section class="content">
        <div class="row">
          <div class="col-md-9">
            <h2 v-html="$t('recent.header') "/>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <vuetable 
              ref="vuetable"
              :api-url="api_url"
              :fields="fields"
              :css="css.table"
              :append-params="appendParams"
              track-by="curricular_unit"
              pagination-path=""
              detail-row-component="recent-detail-row"
              @vuetable:cell-clicked="onCellClicked"
            />
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
  import Vuetable from 'vuetable-2/src/components/Vuetable'
  import Vue from 'vue/dist/vue.esm'
  import VueEvents from 'vue-events'
  import RecentGradeDetailRow from './RecentGradeDetailRow'

  Vue.use(VueEvents)
  Vue.component('recent-detail-row', RecentGradeDetailRow)
  export default {
    name: "RecentGradesComponent",
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
          appendParams: {
              token: this.$ls.get('token')
          },
        api_url: '/api/grades/definitive/recent?table_format=1',
      }
    },
    beforeDestroy: function () {
      window.removeEventListener('resize', this.handleScreenChange)
    },
    beforeMount() {
      window.addEventListener('resize', this.handleScreenChange);
      this.configTableRows();

      this.$bus.$on('change-language', (args) => {
          if (this.$refs.vuetable !== undefined && this.$refs.vuetable !== null)
              this.$refs.vuetable.normalizeFields()
      })
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
                title: () => this.$t('recent.table.curricular_unit')
              },
              {
                name: 'grade',
                title: () => this.$t('recent.table.grade')
              },
            ]
            break;

          case "tablet":
            this.fields = [
              {
                name: 'curricular_unit',
                title: () => this.$t('recent.table.curricular_unit')
              },
              {
                name: 'course',
                title: () => this.$t('recent.table.course')
              },
              {
                name: 'grade',
                title: () => this.$t('recent.table.grade')
              }
            ]
            break;

          default:
            this.fields = [
              {
                name: 'curricular_unit',
                title: () => this.$t('recent.table.curricular_unit')
              },
              {
                name: 'course',
                title: () => this.$t('recent.table.course')
              },
              {
                name: 'grade',
                title: () => this.$t('recent.table.grade')
              },
              {
                name: 'release_date',
                title: () => this.$t('recent.table.release_date')
              },
              {
                name: 'year',
                title: () => this.$t('recent.table.year')
              },
              {
                name: 'consultation_date',
                title: () => this.$t('recent.table.consultation_date')
              }
              ,
              {
                name: 'oral_date',
                title: () => this.$t('recent.table.oral_date')
              }
            ]
        }
      }
    },
  }
</script>
