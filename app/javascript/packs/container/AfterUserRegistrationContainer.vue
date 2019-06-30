<template>
  <v-list two-line>
    <v-container class="item elevation-3 activation">
      <h1 class="activation__title">ユーザー登録受付完了</h1>
      <div class="activation__body">
        登録を受け付けました。<br />
        登録時のメールアドレスに認証用のURLを送付しましたので、 ご確認ください。<br />
        アクティベーション完了後、ログイン画面よりログインをお願いします。<br />
        (※このページは10秒後にログインページへリダイレクトします。)<br />
      </div>
    </v-container>
  </v-list>
</template>

<script lang="ts">
  import { Vue, Component } from "vue-property-decorator"
  import Router from '../router/router'

  @Component

  export default class CompleteUserRegistrationContainer extends Vue {
    async created() {
      await setTimeout( () => Router.push('/sign_in'), 10000);
    }
  }
</script>

<style lang="scss" scoped>
  .activation {
    margin-left: auto;
    margin-right: auto;
    height: 100%;
    align-items: center;
    &__title {
    }
    &__body {
    }
  }
</style>
