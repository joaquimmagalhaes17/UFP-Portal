require('./bootstrap')
import Vue from 'vue/dist/vue.esm'
window.Vue = Vue;

import VueMq from 'vue-mq'
import VueLocalStorage from 'vue-localstorage'

Vue.use(VueLocalStorage, {
    name: 'ls',
    bind: true //created computed members from your variable declarations
})

Vue.use(VueMq, {
    breakpoints: {
        mobile: 450,
        tablet: 900,
        laptop: 1250,
        desktop: Infinity,
    }
})

// import '../lib/stylesheets'
import '../lib/scripts'
import router from '../lib/routes'
import {EventBus} from '../lib/event-bus'

import IndexComponent from '../components/IndexComponent.vue';
import NavbarComponent from '../components/NavbarComponent.vue';
import SidebarComponent from '../components/SidebarComponent.vue';
import FooterComponent from '../components/FooterComponent.vue';
import ModalComponent from '../components/ModalComponent'

Vue.prototype.$bus = EventBus

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '#app',
        router,
        components: {
            NavbarComponent,
            SidebarComponent,
            FooterComponent,
            IndexComponent,
            ModalComponent
        },
    });
});