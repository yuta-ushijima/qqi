import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ArticlesContainer from '../container/ArticlesContainer.vue'
import LoginContainer from '../container/login_container.vue'
import UserRegistrationContainer from '../container/user_registration_container.vue'
import CompleteUserRegistrationContainer from '../container/complete_user_registration_container.vue'
import PostArticlesContainer from '../container/post_articles_container.vue'
import MyPageContainer from '../container/mypage_container.vue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: ArticlesContainer },
    { path: '/sign_in', component: LoginContainer },
    { path: '/sign_up', component: UserRegistrationContainer },
    { path: '/complete_user_registration', component: CompleteUserRegistrationContainer },
    { path: '/post_articles', component: PostArticlesContainer },
    { path: '/my_page', component: MyPageContainer },
    // 存在しないpathが指定された時はrootへredirect
    { path: '*', redirect: '/' }
  ],
})
