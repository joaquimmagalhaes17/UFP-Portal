<template>
    <div id="content-wrap" class="content-wrapper" style="min-height: 926px;">
        <div>
            <section class="content-header">
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                    <li class="active">Dashboard</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <div class="col-md-9">
                        <h2>Assiduidade</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <vuetable ref="vuetable"
                                  :api-url="api_url"
                                  :fields="fields"
                                  :css="css.table"
                                  pagination-path=""
                        ></vuetable>
                    </div>
                </div>
            </section>
        </div>
    </div>
</template>

<script>
    import Vuetable from 'vuetable-2/src/components/Vuetable'

    export default {
        name: "AssiduityComponent",
        components: {
            Vuetable,
        },
        data() {
            return {
                fields: [
                    {
                        name: 'curricular_unit',
                        title: 'Unidade Curricular'
                    },
                    {
                        name: 'type',
                        title: 'Tipo'
                    },
                    {
                        name: 'assiduity',
                        title: 'Assiduidade'
                    },
                ],
                css: {
                    table: {
                        tableClass: 'table table-bordered table-striped table-hover',
                        ascendingIcon: 'glyphicon glyphicon-chevron-up',
                        descendingIcon: 'glyphicon glyphicon-chevron-down'
                    },
                },
                api_url: '/api/assiduity?table_format=1&token=' + this.$ls.get('token'),
            }
        },
    }
</script>

<style scoped>

</style>