<template>
  <div class="login-box">
    <div class="login-logo">
      <b>UFP</b>Portal
    </div>
    <!-- /.login-logo -->
    <form>
      <div class="login-box-body">
        <p class="login-box-msg">Login to start your session</p>
        <div class="form-group has-feedback">
          <input 
            v-model="number" 
            type="text" 
            class="form-control" 
            placeholder="Number">
          <span class="glyphicon glyphicon-envelope form-control-feedback"/>
        </div>
        <div class="form-group has-feedback">
          <input 
            v-model="password" 
            type="password" 
            class="form-control" 
            placeholder="Password">
          <span class="glyphicon glyphicon-lock form-control-feedback"/>
        </div>
        <div class="row">
          <!-- /.col -->
          <div class="col-xs-4">
            <button 
              type="submit" 
              class="btn btn-primary btn-block btn-flat" 
              @click="login">Login</button>
          </div>
          <div 
            v-if="invalidCredentials" 
            class="col-xs-4">
            <h5 style="color: red">Invalid Credentials</h5>
          </div>
          <!-- /.col -->
        </div>
      </div>
    </form>
    <!-- /.login-box-body -->
  </div>
</template>

<script>
  export default {
    name: "LoginComponent",
    data() {
      return {
        number: "",
        password: "",
        invalidCredentials: false
      }
    },
    beforeMount() {
      const el = document.body;
      el.classList.remove("skin-blue")
      el.classList.remove("sidebar-mini")
      el.classList.add("hold-transition")
      el.classList.add('login-page')
    },
    methods: {
      login() {
        axios.post('/api/login', {
          username: this.number,
          password: this.password
        }).then(response => {
          this.$ls.set('token', response.data.message)
          this.invalidCredentials = false
          window.location.href = "/"
        }).catch(error => {
          this.invalidCredentials = true
        })
      }
    }
  }
</script>

<style scoped>

</style>
