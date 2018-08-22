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
                        <h2><b>UFP</b>Bot</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="exampleInputNome">{{ $t('register.name') }} </label>
                            <input v-model="form.name" type="text" class="form-control" id="exampleInputNome"
                                   placeholder="Nome">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail">{{ $t('register.email') }}</label>
                            <input v-model="form.email" type="email" class="form-control" id="exampleInputEmail"
                                   placeholder="Email">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputContact">{{ $t('register.contact') }}</label>
                            <input v-model="form.contact" type="text" class="form-control" id="exampleInputContact"
                                   placeholder="Número de telémovel">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="exampleInputNumber">{{ $t('register.number') }} </label>
                            <input v-model="form.number" type="text" class="form-control" id="exampleInputNumber"
                                   placeholder="Número de aluno">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword">{{ $t('register.password') }}</label>
                            <input v-model="form.password" type="password" class="form-control"
                                   id="exampleInputPassword"
                                   placeholder="Password">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <button v-if="!userRegistered" v-on:click="register" type="submit" class="btn btn-default">
                            {{ $t('register.register') }}
                        </button>
                        <button v-if="userRegistered" v-on:click="update" type="submit" class="btn btn-default">
                            {{ $t('register.update') }}
                        </button>
                        <button v-if="userRegistered" v-on:click="remove" type="submit" class="btn btn-default">
                            {{ $t('register.remove') }}
                        </button>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-3">
                        <div v-if="errors.status" class="alert alert-danger alert-dismissible">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            {{errors.message}}
                        </div>
                        <div v-if="success.status" class="alert alert-success alert-dismissible">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            {{success.message}}
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</template>

<script>
    export default {
        name: "RegisterComponent",
        data() {
            return {
                form: {
                    name: '',
                    number: '',
                    password: '',
                    email: '',
                    contact: ''
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
            }
        },
        methods: {
            register() {
                axios.post('/api/web/register', this.form)
                    .then(response => {
                        this.errors.status = false
                        this.success.status = true
                        this.success.message = 'User registered with success'
                    })
                    .catch(e => {
                        this.success.status = false
                        this.errors.status = true
                        this.errors.message = e.response.data.message
                    })
            },
            update() {
                axios.post('/api/update', this.form)
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
                axios.post('/api/web/register/cancel', this.$ls.get('token'))
                    .then(response => {
                        this.errors.status = false
                        this.success.status = true
                        console.log(response.data)
                    })
                    .catch(e => {
                        this.success.status = false
                        this.errors.status = true
                        this.errors.message = e.response.data.message
                    })
            }
        },
        beforeMount() {
            axios.get('/api/registered?token=' + this.$ls.get('token'))
                .then(response => {
                    this.form = response.data.message
                    this.userRegistered = true
                })
                .catch(e => {
                    // ignored
                })
        }
    }
</script>

<style scoped>

</style>
