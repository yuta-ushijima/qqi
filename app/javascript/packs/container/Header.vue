<template>
  <header class="header__container">
    <nav class="header__container__nav">
      <router-link to="/">
        <h1 class="nav__brand">QiitaClone2019</h1>
      </router-link>

      <div class="nav__menu">
        <div v-if="isLoggedIn">
          <router-link to="/post_articles">
            <button class="post__button">投稿する</button>
          </router-link>

          <router-link to="/my_page">
            <button class="post__button">マイページ</button>
          </router-link>

          <button type="submit" class="auth__button" @click="signOut">ログアウト</button>
        </div>
        <div v-else>
          <router-link to="/sign_in">
            <button class="auth__button">ログイン</button>
          </router-link>
          <router-link to="/sign_up">
            <button class="post__button">ユーザー登録</button>
          </router-link>
        </div>
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

    isLoggedIn: boolean = !!localStorage.getItem("access-token");

    async signOut(): Promise<void> {
      await axios.delete('/api/v1/auth/sign_out', config).then(() => {
        alert('ログアウトしました');
        localStorage.clear();
        this.$router.push('/sign_in');
        window.location.reload();
      }).catch(() => {
        console.log(config);
        alert('ログアウトに失敗しました')
      })
    }
  }
</script>

<style lang="scss" scoped>
  .header__container {
    background-color: #55c500;
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
        color: #FFF;
        font-family: Segoe UI,Helvetica Neue,Hiragino Kaku Gothic ProN,"メイリオ",meiryo,sans-serif;;
        position: relative;
      }
      .nav__menu {
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .post__button {
        margin-right: 10px;
      }
      .auth__button {
        margin-right: 10px;
      }
    }
  }

</style>
