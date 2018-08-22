<template>
  <header 
    v-if="['Login'].indexOf($route.name) !== 0" 
    class="main-header">
    <!-- Logo -->
    <a
      href=""
      class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>UFP</b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>UFP</b> Portal</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a
        href="/"
        class="sidebar-toggle"
        data-toggle="push-menu"
        role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a
              href="#"
              class="dropdown-toggle"
              data-toggle="dropdown">
              <span class="hidden-xs">Perfil</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <p>
                  Perfil
                  <small>{{ profile.name }}</small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-right">
                  <a
                    class="btn btn-default btn-flat"
                    @click="logout">
                    Logout
                  </a>
                  <form
                    id="logout-form"
                    action="/logout"
                    method="POST"
                    style="display: none;">
                    <input
                      :value="csrf"
                      type="hidden"
                      name="_token">
                  </form>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>
</template>

<script>
    export default {
        data(){
            return {
                profile: {
                    name: 'Secretário'
                },
                csrf: this.$csrfToken,
            }
        },
        methods: {
            logout() {
                this.$ls.remove('token')
                window.location.href = "/"
            }
        }
    }
</script>
