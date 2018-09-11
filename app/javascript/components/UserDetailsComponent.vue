<template>
  <div
    id="content-wrap"
    class="content-wrapper"
    style="min-height: 926px;">
    <div>
      <section class="content-header">
        <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-dashboard"/> Home</a></li>
          <li class="active">Dashboard</li>
        </ol>
      </section>
      <section class="content">
        <div class="row">
          <div class="col-md-9">
            <h2><b>UFP</b>Bot</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="exampleInputNome">{{ $t('register.name') }} </label>
              <input
                id="exampleInputNome"
                v-model="form.name"
                type="text"
                class="form-control"
                placeholder="Nome">
            </div>
            <div class="form-group">
              <label for="exampleInputEmail">{{ $t('register.email') }}</label>
              <input
                id="exampleInputEmail"
                v-model="form.email"
                type="email"
                class="form-control"
                placeholder="Email">
            </div>
            <div class="form-group">
              <label for="exampleInputContact">{{ $t('register.contact') }}</label>
              <input
                id="exampleInputContact"
                v-model="form.contact"
                type="text"
                class="form-control"
                placeholder="Número de telémovel">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label for="exampleInputNumber">{{ $t('register.number') }} </label>
              <input
                id="exampleInputNumber"
                v-model="form.student_number"
                type="text"
                class="form-control"
                placeholder="Número de aluno">
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-md-4">
                  <label for="sms_enable">{{ $t('register.sms_notifications') }} </label>
                  <div
                    :style="checkbox"
                    class="checkbox">
                    <bootstrap-toggle
                      id="sms_enable"
                      v-model="form.sms_notification"
                      :options="{ on: $t('toggle.on'), off: $t('toggle.off') }"
                      :disabled="false"/>
                  </div>
                </div>
                <div class="col-md-4">
                  <label for="email_enable">{{ $t('register.email_notifications') }} </label>
                  <div
                    :style="checkbox"
                    class="checkbox">
                    <bootstrap-toggle
                      id="email_enable"
                      v-model="form.email_notification"
                      :options="{ on: $t('toggle.on'), off: $t('toggle.off') }"
                      :disabled="false"/>
                  </div>
                </div>
                <div class="col-md-4">
                  <label for="user_enable">{{ $t('register.enable') }} </label>
                  <div
                    :style="checkbox"
                    class="checkbox">
                    <bootstrap-toggle
                      id="user_enable"
                      v-model="form.enable"
                      :options="{ on: $t('toggle.on'), off: $t('toggle.off') }"
                      :disabled="false"/>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <button
              v-if="!userRegistered"
              type="submit"
              class="btn btn-default"
              @click="register">
              {{ $t('register.register') }}
            </button>
            <button
              v-if="userRegistered"
              type="submit"
              class="btn btn-default"
              @click="update">
              {{ $t('register.update') }}
            </button>
            <button
              v-if="userRegistered"
              type="submit"
              class="btn btn-default"
              @click="remove">
              {{ $t('register.remove') }}
            </button>
          </div>
        </div>
        <br>
        <div class="row">
          <div class="col-md-3">
            <div
              v-if="errors.status"
              class="alert alert-danger alert-dismissible">
              <a
                href="#"
                class="close"
                data-dismiss="alert"
                aria-label="close">&times;</a>
              {{ errors.message }}
            </div>
            <div
              v-if="success.status"
              class="alert alert-success alert-dismissible">
              <a
                href="#"
                class="close"
                data-dismiss="alert"
                aria-label="close">&times;</a>
              {{ success.message }}
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
    import BootstrapToggle from 'vue-bootstrap-toggle'
  export default {
    name: "UserDetailsComponent",
      components: { BootstrapToggle },
      data() {
          return {
              form: {
                  name: '',
                  student_number: '',
                  email: '',
                  contact: '',
                  enable: null,
                  email_notification: null,
                  sms_notification: null,
              },
              errors: {
                  status: false,
                  message: ''
              },
              success: {
                  status: false,
                  message: ''
              },
              userRegistered: false,
              checkbox: 'margin-top: inherit !important;'
          }
      },
      beforeMount() {
          axios.get('/api/admin/user/'+ this.$route.params.user_id +'?token=' + this.$ls.get('token'))
              .then(response => {
                  this.form = response.data.message
                  this.userRegistered = true
              })
              .catch(e => {
                  // ignored
              })
      },
      methods: {
          update() {
              axios.put('/api/admin/user/update', {
                  information: this.form,
                  token: this.$ls.get('token')
              })
              .then(response => {
                  this.errors.status = false
                  this.success.status = true
                  this.success.message = response.data.message
              })
              .catch(e => {
                  this.success.status = false
                  this.errors.status = true
                  this.errors.message = e.response.data.message
              })
          },
          remove() {
              axios.post('/api/admin/user/remove', {
                  token: this.$ls.get('token'),
                  student_number: this.form.student_number
              })
                  .then(response => {
                      this.errors.status = false
                      this.success.status = true
                      console.log(response.data)
                      this.$router.push('/admin/users')
                  })
                  .catch(e => {
                      this.success.status = false
                      this.errors.status = true
                      this.errors.message = e.response.data.message
                  })
          }
      }
  }
</script>

<style scoped>

</style>
