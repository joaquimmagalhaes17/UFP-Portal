<template>
  <div id="content-wrap" class="content-wrapper" style="min-height: 926px;">
    <div>
      <section class="content-header">
        <ol class="breadcrumb">
          <li>
            <router-link to="/"><i class="fa fa-dashboard"></i> Home</router-link>
          </li>
          <li class="active">Partial Grades</li>
        </ol>
      </section>
      <section class="content">
        <div class="col-lg-4">
          <div class="form-group">
            <label for="course">Anos Letivos</label>
            <select id="course" class="form-control" v-model="selectedYear">
              <option v-for="year in years" :value="year.id">
                {{ year.name }}
              </option>
            </select>
          </div>
        </div>
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
    name: "PartialGradesComponent",
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
        fields: [
          {
            name: 'curricular_unit',
            title: 'Unidade Curricular'
          },
          {
            name: 'element',
            title: 'Elemento'
          },
          {
            name: 'grade',
            title: 'Nota'
          }
        ],
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
        api_url: '/api/grades/provisional/partial?table_format=1&token=' + this.$ls.get('token'),
      }
    },
    beforeMount() {
      axios.get('/api/grades/provisional/partial/years?token=' + this.$ls.get('token'))
        .then(response => {
          response.data.message.forEach(year => {
            this.years.push({
              id: year,
              name: year
            })
          });
          this.selectedYear = response.data.message[0];
        })
        .catch(e => {
          console.log(e)
        })

    },
    watch: {
      'selectedYear': function (val, oldVal) {
        this.appendParams.year = val;
        Vue.nextTick(() => this.$refs.vuetable.refresh())
      },
    },
    methods: {
      onPaginationData(paginationData) {
        this.$refs.pagination.setPaginationData(paginationData);
        this.$refs.paginationInfo.setPaginationData(paginationData);
      },
      onChangePage(page) {
        this.$refs.vuetable.changePage(page)
      },
    }
  }
</script>
