import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'

Vue.use(Router)

import IndexComponent from '../components/IndexComponent.vue';
import PartialGradesComponent from '../components/PartialGradesComponent';
import FinalGradesComponent from '../components/FinalGradesComponent';
import RecentGradesComponent from '../components/RecentGradesComponent';
import DefinitiveGradesComponent from '../components/DefinitiveGradesComponent';
import LoginComponent from '../components/LoginComponent';
import RegisterComponent from '../components/RegisterComponent'
import UsersComponent from '../components/UsersComponent';
import UserDetailsComponent from '../components/UserDetailsComponent';

let router = new Router({
  routes: [
    {
      path: '/',
      component: LoginComponent,
      name: 'Login',
      meta: {
        guest: true
      }
    },
    {
      path: '/home',
      component: IndexComponent,
      name: 'Home',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/provisional/partials',
      component: PartialGradesComponent,
      name: 'Partials',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/provisional/finals',
      component: FinalGradesComponent,
      name: 'Finals',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/definitive/recent',
      component: RecentGradesComponent,
      name: 'Recent',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/definitive/historic',
      component: DefinitiveGradesComponent,
      name: 'Definitive',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/register',
      component: RegisterComponent,
      name: 'Register',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/users',
      component: UsersComponent,
      name: 'Users',
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/user/:user_id',
      component: UserDetailsComponent,
      name: 'User',
      meta: {
        requiresAuth: true
      }
    }
  ],
  linkActiveClass: 'active'
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (localStorage.getItem('token') == null) {
      next({
        path: '/',
        params: {nextUrl: to.fullPath}
      })
    } else {
      next()
    }
  } else if (to.matched.some(record => record.meta.guest)) {
    if (localStorage.getItem('token') == null) {
      next()
    }
    else {
      next({name: 'Home'})
    }
  } else {
    next()
  }
})

export default router;
