<template>
  <v-toolbar dark color="#55c500">
    <router-link to="/" class="nav__href--no-decoration">
      <v-toolbar-title class="white--text font-weight-bold">QiitaClone2019</v-toolbar-title>
    </router-link>

    <v-spacer></v-spacer>

    <div v-if="isLoggedIn">
      <router-link to="/post_articles" class="nav__href--no-decoration">
        <v-btn flat class="font-weight-bold  nav__btn--white-border">投稿する</v-btn>
      </router-link>

      <router-link to="/my_page" class="nav__href--no-decoration">
        <v-btn flat class="post__button">マイページ</v-btn>
      </router-link>

      <v-btn flat class="white--text font-weight-bold" @click="signOut">ログアウト</v-btn>
    </div>
    <div v-else>
      <router-link to="/sign_up" class="nav__href--no-decoration">
        <v-btn flat class="nav__btn--white-border">ユーザー登録</v-btn>
      </router-link>
      <router-link to="/sign_in" class="nav__href--no-decoration">
        <v-btn flat class="auth__button">ログイン</v-btn>
      </router-link>
    </div>
  </v-toolbar>
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
  .nav__href {
    &--no-decoration {
    text-decoration: none;
    }
  }

  .nav__btn {
    &--white-border {
      border: 2px solid #fff;
      border-radius: 5px;
    }
  }
</style>
