<template>
  <header class="header__container">
    <nav class="header__container--nav">
      <router-link to="/">QiitaClone2019</router-link>
      <router-link to="/post_articles">投稿する</router-link>
      <button type="submit" @click="signOut">ログアウト</button>
    </nav>
  </header>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'

  /* devise-auth-tokenで設定したヘッダー情報 */
  const config = {
    headers: {
      'Authorization': 'Bearer',
      'Access-Control-Allow-Origin': '*',
      'access-token': localStorage.getItem('access-token'),
      'client': localStorage.getItem('client'),
      'uid': localStorage.getItem('uid')
    }
  };

  Vue.use(VueRouter);

  @Component
  export default class HeaderContainer extends Vue {

    async signOut(): Promise<void> {
      await axios.delete('/api/v1/auth/sign_out', config).then(() => {
        alert('ログアウトしました')
        localStorage.clear();
        this.$router.push('/sign_in')
      }).catch(() => {
        console.log(config);
        alert('ログアウトに失敗しました')
      })
    }
  }
</script>

<style lang="scss">

</style>
