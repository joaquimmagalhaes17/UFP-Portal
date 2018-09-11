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
          <li class="active">Partial Grades</li>
        </ol>
      </section>
      <section class="content">
        <vuetable 
          ref="vuetable"
          :api-url="api_url"
          :fields="fields"
          :css="css.table"
          :per-page="perPage"
          :append-params="appendParams"
          pagination-path=""
          @vuetable:cell-clicked="onCellClicked"
        />
      </section>
    </div>
  </div>
</template>

<script>
  import Vuetable from 'vuetable-2/src/components/Vuetable'

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
            name: 'student_number',
            title: 'Número de aluno'
          },
          {
            name: 'email',
            title: 'Email'
          },
          {
              name: 'contact',
              title: 'Contacto'
          }
        ],
        css: {
          table: {
            tableClass: 'table table-bordered table-striped table-hover',
            ascendingIcon: 'glyphicon glyphicon-chevron-up',
            descendingIcon: 'glyphicon glyphicon-chevron-down'
          },
        },
        api_url: '/api/admin/users',
        appendParams: {
            token: this.$ls.get('token')
        }
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
