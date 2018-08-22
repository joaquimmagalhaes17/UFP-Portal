<template>
  <div 
    id="content-wrap" 
    class="content-wrapper" 
    style="min-height: 926px;">
    <div>
      <section class="content-header">
        <ol class="breadcrumb">
          <li>
            <router-link to="/"><i class="fa fa-dashboard"/> Home</router-link>
          </li>
          <li class="active">Provisional Final Grades</li>
        </ol>
      </section>
      <section class="content">
        <div class="row">
          <div class="col-md-9">
            <h2 v-html="$t('final.header') "/>
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
              pagination-path=""
              track-by="curricular_unit"
              detail-row-component="final-detail-row"
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
                appendParams: {
                    token: this.$ls.get('token')
                },
                api_url: '/api/grades/provisional/final?table_format=1',
            }
        },
        beforeDestroy: function () {
            window.removeEventListener('resize', this.handleScreenChange)
        },
        beforeMount() {
            window.addEventListener('resize', this.handleScreenChange)
            this.configTableRows()

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
                                title: () => this.$t('final.table.curricular_unit')
                            },
                            {
                                name: 'epoch',
                                title: () => this.$t('final.table.epoch')
                            },
                            {
                                name: 'final_grade',
                                title: () => this.$t('final.table.final_grade')
                            }
                        ]
                        break;

                    case "tablet":
                        this.fields = [
                            {
                                name: 'curricular_unit',
                                title: () => this.$t('final.table.curricular_unit')
                            },
                            {
                                name: 'epoch',
                                title: () => this.$t('final.table.epoch')
                            },
                            {
                                name: 'oral_ex',
                                title: () => this.$t('final.table.oral_ex')
                            },
                            {
                                name: 'write_ex',
                                title: () => this.$t('final.table.write_ex')
                            },
                            {
                                name: 'final_grade',
                                title: () => this.$t('final.table.final_grade')
                            }
                        ]
                        break;

                    case "laptop":
                        this.fields = [
                            {
                                name: 'curricular_unit',
                                title: () => this.$t('final.table.curricular_unit')
                            },
                            {
                                name: 'epoch',
                                title: () => this.$t('final.table.epoch')
                            },
                            {
                                name: 'oral_ex',
                                title: () => this.$t('final.table.oral_ex')
                            },
                            {
                                name: 'write_ex',
                                title: () => this.$t('final.table.write_ex')
                            },
                            {
                                name: 'final_grade',
                                title: () => this.$t('final.table.final_grade')
                            },
                            {
                                name: 'consultation_date',
                                title: () => this.$t('final.table.consultation_date')
                            },
                            {
                                name: 'oral_date',
                                title: () => this.$t('final.table.oral_date')
                            }
                        ]
                        break;

                    default:
                        this.fields = [
                            {
                                name: 'curricular_unit',
                                title: () => this.$t('final.table.curricular_unit')
                            },
                            {
                                name: 'epoch',
                                title: () => this.$t('final.table.epoch')
                            },
                            {
                                name: 'oral_ex',
                                title: () => this.$t('final.table.oral_ex')
                            },
                            {
                                name: 'write_ex',
                                title: () => this.$t('final.table.write_ex')
                            },
                            {
                                name: 'final_grade',
                                title: () => this.$t('final.table.final_grade')
                            },
                            {
                                name: 'consultation_date',
                                title: () => this.$t('final.table.consultation_date')
                            },
                            {
                                name: 'oral_date',
                                title: () => this.$t('final.table.oral_date')
                            },
                            {
                                name: 'year',
                                title: () => this.$t('final.table.year')
                            },
                            {
                                name: 'date_registration',
                                title: () => this.$t('final.table.date_registration')
                            },
                            {
                                name: 'released_by',
                                title: () => this.$t('final.table.released_by')
                            }
                        ]
                }
            }
        },
    }
</script>
<style>

</style>
