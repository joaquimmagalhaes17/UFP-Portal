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
        <vuetable ref="vuetable"
                  :api-url="api_url"
                  :fields="fields"
                  :css="css.table"
                  pagination-path=""
                  :per-page="perPage"
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

  Vue.use(VueEvents)
  export default {
    name: "UsersComponent",
    components: {
      Vuetable,
    },
    data() {
      return {
        perPage: 10,
        fields: [
          {
            name: 'name',
            title: 'Nome'
          },
          {
            name: 'number',
            title: 'Número de aluno'
          },
          {
            name: 'email',
            title: 'Email'
          }
        ],
        css: {
          table: {
            tableClass: 'table table-bordered table-striped table-hover',
            ascendingIcon: 'glyphicon glyphicon-chevron-up',
            descendingIcon: 'glyphicon glyphicon-chevron-down'
          },
        },
        api_url: '/api/web/admin/users?token=' + this.$ls.get('token'),
      }
    },
    methods: {
      onCellClicked (data, field, event) {
        this.$router.push({ name: 'User', params: {user_id: data.id }})
      },
    }
  }
</script>

<style scoped>

</style>
