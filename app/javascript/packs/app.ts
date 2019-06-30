import Vue from 'vue'
import Router from './router/router'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    router: Router,
  })
});
