import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ArticlesContainer from '../container/articles_container.vue'
import LoginContainer from '../container/login_container.vue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    // { path: '/', component: ArticlesContainer },
    { path: '/', component: LoginContainer },
  ],
})
