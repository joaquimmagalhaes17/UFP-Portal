<template>
  <aside v-if="['Login'].indexOf($route.name) !== 0" class="main-sidebar">
    <section class="sidebar">
      <ul
        class="sidebar-menu"
        data-widget="tree">
        <li class="header">MENU</li>
        <li
          :class="{ active: isActive('index') }"
          @click="setActive('index')">
          <router-link to="/">
            <i class="fa fa-home"/> <span>Página Inicial</span>
          </router-link>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-address-book-o"/>
            <span>Notas</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"/>
            </span>
          </a>
          <ul class="treeview-menu">
            <li class="treeview">
              <a href="#">
                <i class="fa fa-address-book-o"/>
                <span>Provisórias</span>
                <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"/>
            </span>
              </a>
              <ul class="treeview-menu">
                <li>
                  <router-link to="/provisional/partials"><i class="fa fa-circle-o"/>Parciais</router-link>
                </li>
                <li>
                  <router-link to="/provisional/finals"><i class="fa fa-circle-o"/>Finais</router-link>
                </li>
              </ul>
            </li>
            <li class="treeview">
              <a href="#">
                <i class="fa fa-address-book-o"/>
                <span>Definitivas</span>
                <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"/>
            </span>
              </a>
              <ul class="treeview-menu">
                <li>
                  <router-link to="/definitive/recent"><i class="fa fa-circle-o"/>Recentes</router-link>
                </li>
                <li>
                  <router-link to="/definitive/historic"><i class="fa fa-circle-o"/>Histórico</router-link>
                </li>
              </ul>
            </li>
          </ul>
        </li>
        <li>
          <router-link to="/assiduity">
            <i class="fa fa-home"/> <span>Assiduidade</span>
          </router-link>
        </li>
        <li v-if="admin" class="treeview">
          <a href="#">
            <i class="fa fa-address-book-o"/>
            <span><b>UFP</b>Bot</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"/>
            </span>
          </a>
          <ul class="treeview-menu">
            <li>
              <router-link to="/admin/users"><i class="fa fa-circle-o"/>Users</router-link>
            </li>
            <li>
              <router-link to="/definitive/historic"><i class="fa fa-circle-o"/>Histórico</router-link>
            </li>
          </ul>
        </li>
        <li v-if="!admin"
            :class="{ active: isActive('index') }"
            @click="setActive('index')">
          <router-link to="/register">
            <i class="fa fa-home"/> <span><b>UFP</b>Bot</span>
          </router-link>
        </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
</template>

<script>
  export default {
    data() {
      return {
        applicants: [],
        errors: [],
        activeItem: 'index',
        admin: false
      }
    },
    created() {
    },
    methods: {
      isActive: function (menuItem) {
        return this.activeItem === menuItem
      },

      setActive: function (menuItem) {
        this.activeItem = menuItem
      }
    },
    events: {
      'set-active'(menuItem) {
        this.activeItem = menuItem
      }
    }
  }
</script>
