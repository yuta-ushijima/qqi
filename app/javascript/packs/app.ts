import Vue from 'vue'
import Router from './router/router'
import Vuetify from "vuetify"
import Header from "./container/Header.vue"
import "highlight.js/styles/monokai.css"

Vue.use(Vuetify);

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    router: Router,
    components: {
      navbar: Header
    }
  })
});
