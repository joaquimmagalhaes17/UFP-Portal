<template>
  <div id="content-wrap" class="content-wrapper" style="min-height: 926px;">
    <div>
      <section class="content-header">
        <ol class="breadcrumb">
          <li>
            <router-link to="/"><i class="fa fa-dashboard"></i> Home</router-link>
          </li>
          <li class="active">Grades</li>
        </ol>
      </section>
      <section class="content">
        <div class="row">
          <div class="col-md-12">
            <h3>Detalhes do utilizador</h3>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <h4>Notas parciais</h4>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <label for="course">Anos Letivos</label>
              <select id="course" class="form-control" v-model="selectedYear">
                <option v-for="year in years" :value="year.id">
                  {{ year.name }}
                </option>
              </select>
            </div>
          </div>
          <div class="col-md-12">
            <vuetable ref="provisionalPartial"
                      :api-url="api_url.provisionalPartial"
                      :fields="fields.provisionalPartial"
                      :css="css.table"
                      pagination-path=""
                      :per-page="perPage"
                      :append-params="appendParams"
                      @vuetable:pagination-data="onPaginationDataProvisionalPartial"
            ></vuetable>
          </div>
          <div class="col-md-12">
            <div class="vuetable-pagination">
              <vuetable-pagination-info
                ref="provisionalPartialPaginationInfo"
                info-class="pagination-info"/>
              <vuetable-pagination-bootstrap
                ref="provisionalPartialPagination"
                class="pull-right"
                @vuetable-pagination:change-page="onChangePageProvisionalPartial"/>
            </div>
          </div>
        </div>
        <hr>
        <div class="row">
          <div class="col-md-12">
            <h4>Notas finais provisórias</h4>
          </div>
          <div class="col-md-12">
            <vuetable ref="provisionalFinals"
                      :api-url="api_url.provisionalFinal"
                      :fields="fields.provisionalFinal"
                      :css="css.table"
                      pagination-path=""
                      :per-page="perPage"
                      :append-params="appendParams"
                      detail-row-component="final-detail-row"
                      @vuetable:cell-clicked="onCellClicked"
            ></vuetable>
          </div>
        </div>
        <hr>
        <div class="row">
          <div class="col-md-12">
            <h4>Notas definitivas recentes</h4>
          </div>
          <div class="col-md-12">
            <vuetable ref="definitiveRecent"
                      :api-url="api_url.definitiveRecent"
                      :fields="fields.definitiveRecent"
                      :css="css.table"
                      pagination-path=""
                      :per-page="perPage"
                      :append-params="appendParams"
            ></vuetable>
          </div>
        </div>
        <hr>
        <div class="row">
          <div class="col-md-12">
            <h4>Notas definitivas histórico</h4>
          </div>
          <div class="col-md-12">
            <vuetable ref="definitiveHistoric"
                      :api-url="api_url.definitiveHistoric"
                      :fields="fields.definitiveHistoric"
                      :css="css.table"
                      pagination-path=""
                      :per-page="perPage"
                      :append-params="appendParams"
                      @vuetable:pagination-data="onPaginationDataHistoric"
            ></vuetable>
          </div>
          <div class="col-md-12">
            <div class="vuetable-pagination">
              <vuetable-pagination-info
                ref="paginationInfoHistoric"
                info-class="pagination-info"/>
              <vuetable-pagination-bootstrap
                ref="paginationHistoric"
                class="pull-right"
                @vuetable-pagination:change-page="onChangePageHistoric"/>
            </div>
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
  import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
  import VuetablePaginationBootstrap from './VuetablePaginationBootstrap'
  import FinalGradeDetailRow from './FinalGradeDetailRow'
  Vue.use(VueEvents)
  Vue.component('final-detail-row', FinalGradeDetailRow)
  export default {
    name: "UserDetailsComponent",
    components: {
      Vuetable,
      VuetablePaginationInfo,
      VuetablePaginationBootstrap
    },
    data() {
      return {
        years: [],
        selectedYear: '',
        perPage: 10,
        fields: {
          provisionalPartial: [
            {
              name: 'unidade_curricular',
              title: 'Unidade Curricular'
            },
            {
              name: 'elemento',
              title: 'Elemento'
            },
            {
              name: 'nota',
              title: 'Nota'
            }
          ],
          tmp: [],
          provisionalFinal: [
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
          ],
          definitiveRecent: [
            {
              name: 'description',
              title: 'Descricao'
            },
            {
              name: 'grade',
              title: 'Resultado'
            },
          ],
          definitiveHistoric: [
            {
              name: 'unit',
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
          ],
        },
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
        api_url:{
          provisionalPartial: '/api/web/admin/user/grades/provisional/partials?token=' + this.$ls.get('token') + '&user_id=' + this.$route.params.user_id,
          provisionalFinal: '/api/web/admin/user/grades/provisional/finals?token=' + this.$ls.get('token') + '&user_id=' + this.$route.params.user_id,
          definitiveRecent: '/api/web/admin/user/grades/definitive/recent?token=' + this.$ls.get('token') + '&user_id=' + this.$route.params.user_id,
          definitiveHistoric: '/api/web/admin/user/grades/definitive/historic?token=' + this.$ls.get('token') + '&user_id=' + this.$route.params.user_id,
        },
      }
    },
    methods: {
      onPaginationDataProvisionalPartial(paginationData) {
        this.$refs.provisionalPartialPagination.setPaginationData(paginationData);
        this.$refs.provisionalPartialPaginationInfo.setPaginationData(paginationData);
      },
      onChangePageProvisionalPartial(page) {
        this.$refs.provisionalPartial.changePage(page)
      },
      onPaginationDataHistoric(paginationData) {
        this.$refs.paginationHistoric.setPaginationData(paginationData);
        this.$refs.paginationInfoHistoric.setPaginationData(paginationData);
      },
      onChangePageHistoric(page) {
        this.$refs.definitiveHistoric.changePage(page)
      },
      onCellClicked(data, field, event) {
        this.$refs.provisionalFinals.toggleDetailRow(data.id)
      }
    },
    beforeMount() {
      axios.get('/api/web/admin/user/grades/provisional/partials/years?token=' + this.$ls.get('token') + '&user_id=7')
        .then(response => {
          response.data.forEach(year => {
            this.years.push({
              id: year,
              name: year
            })
          });
          this.selectedYear = response.data[0];
        })
        .catch(e => {
          console.log(e)
        })
    },
    watch: {
      'selectedYear': function (val, oldVal) {
        this.appendParams.year = val;
        Vue.nextTick(() => this.$refs.provisionalPartial.refresh())
      },
    }
  }
</script>

<style scoped>

</style>
