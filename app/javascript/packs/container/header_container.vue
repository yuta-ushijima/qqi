<template>
  <header class="header__container">
    <nav class="header__container__nav">
      <router-link to="/" class="nav__brand">QiitaClone2019</router-link>
      <div class="nav__menu">
        <router-link to="/post_articles">投稿する</router-link>
        <router-link to="/sign_in" v-if="config === null">ログイン</router-link>
        <button type="submit" @click="signOut">ログアウト</button>
      </div>
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

<style lang="scss" scoped>
  .header__container {
    background-color: cornflowerblue;
    width: 100%;
    a {
      text-decoration:none;
    }
    .header__container__nav {
      display: flex;
      align-items: center;
      justify-content: space-between;
      height: 80px;
      margin-left: auto;
      margin-right: auto;
      .nav__brand {
        font-size: 2em;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        position: relative;
      }
      .nav__menu {
        display: flex;
        align-items: center;
        justify-content: center;
      }
    }
  }

</style>
