require('./bootstrap')
import Vue from 'vue/dist/vue.esm'
window.Vue = Vue;

import VueI18n from 'vue-i18n'
Vue.use(VueI18n);

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

import '../lib/scripts'
import router from '../lib/routes'
import {EventBus} from '../lib/event-bus'
import messages from '../lib/translations';

import IndexComponent from '../components/IndexComponent.vue';
import NavbarComponent from '../components/NavbarComponent.vue';
import SidebarComponent from '../components/SidebarComponent.vue';
import FooterComponent from '../components/FooterComponent.vue';
import ModalComponent from '../components/ModalComponent'

Vue.prototype.$bus = EventBus;

const locale = localStorage.getItem('locale');
const i18n = new VueI18n({
    locale: locale === null ? 'pt' : locale,
    messages
});

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '#app',
        router,
        i18n,
        components: {
            NavbarComponent,
            SidebarComponent,
            FooterComponent,
            IndexComponent,
            ModalComponent
        },
    });
});