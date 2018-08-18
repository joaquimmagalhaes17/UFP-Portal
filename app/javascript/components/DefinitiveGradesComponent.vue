<template>
  <div id="content-wrap" class="content-wrapper" style="min-height: 926px;">
  <div>
    <section class="content-header">
      <ol class="breadcrumb">
        <li><router-link to="/"><i class="fa fa-dashboard"></i> Home</router-link></li>
        <li class="active">Partial Grades</li>
      </ol>
    </section>
    <section class="content">
      <vuetable ref="vuetable"
                :api-url="api_url"
                :fields="fields"
                :css="css.table"
                pagination-path=""
                :per-page="perPage"
                :append-params="appendParams"
                @vuetable:pagination-data="onPaginationData"
      ></vuetable>
      <div class="row">
        <div class="col-md-12">
          <div class="vuetable-pagination">
            <vuetable-pagination-info
              ref="paginationInfo"
              info-class="pagination-info"/>
            <vuetable-pagination-bootstrap
              ref="pagination"
              class="pull-right"
              @vuetable-pagination:change-page="onChangePage"/>
          </div>
        </div>
      </div>
    </section>
  </div>
  </div>
</template>

<script>
  import Vuetable from 'vuetable-2/src/components/Vuetable'
  import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
  import VuetablePaginationBootstrap from './VuetablePaginationBootstrap'
  import Vue from 'vue/dist/vue.esm'
  import VueEvents from 'vue-events'

  Vue.use(VueEvents)
  export default {
    name: "DefinitiveGradesComponent",
    components: {
      Vuetable,
      VuetablePaginationBootstrap,
      VuetablePaginationInfo
    },
    data() {
      return {
        years: [],
        selectedYear: '',
        perPage: 10,
        fields: [],
        css: {
          table: {
            tableClass: 'table table-bordered table-striped table-hover',
            ascendingIcon: 'glyphicon glyphicon-chevron-up',
            descendingIcon: 'glyphicon glyphicon-chevron-down'
          },
        },
        appendParams: {
          year: this.selectedYear
        },
        api_url: '/api/grades/definitive/historic?table_format=1&token=' + this.$ls.get('token'),
      }
    },
    methods: {
      onPaginationData (paginationData) {
        this.$refs.pagination.setPaginationData(paginationData);
        this.$refs.paginationInfo.setPaginationData(paginationData);
      },
      onChangePage (page) {
        this.$refs.vuetable.changePage(page)
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
                title: 'Unidade'
              },
              {
                name: 'grade',
                title: 'Nota'
              },
              {
                name: 'registration_date',
                title: 'Registo'
              }
            ]
            break;

          default:
            this.fields = [
              {
                name: 'degree',
                title: 'Grau'
              },
              {
                name: 'curricular_unit',
                title: 'Unidade'
              },
              {
                name: 'course',
                title: 'Curso'
              },
              {
                name: 'grade',
                title: 'Nota'
              },
              {
                name: 'registration_date',
                title: 'Registo'
              }
            ]
            break;
        }
      }
    },
    beforeMount() {
      window.addEventListener('resize', this.handleScreenChange)
      this.configTableRows()
    },
    beforeDestroy: function () {
      window.removeEventListener('resize', this.handleScreenChange)
    }
  }
</script>
