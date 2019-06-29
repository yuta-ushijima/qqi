import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ArticlesContainer from '../container/ArticlesContainer.vue'
import LoginContainer from '../container/LoginContainer.vue'
import UserRegistrationContainer from '../container/user_registration_container.vue'
import CompleteUserRegistrationContainer from '../container/AfterUserRegistrationContainer.vue'
import PostArticleContainer from '../container/PostArticleContainer.vue'
import MyPageContainer from '../container/MyPageContainer.vue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: ArticlesContainer },
    { path: '/sign_in', component: LoginContainer },
    { path: '/sign_up', component: UserRegistrationContainer },
    { path: '/complete_user_registration', component: CompleteUserRegistrationContainer },
    { path: '/post_articles', component: PostArticleContainer },
    { path: '/my_page', component: MyPageContainer },
    // 存在しないpathが指定された時はrootへredirect
    { path: '*', redirect: '/' }
  ],
})
