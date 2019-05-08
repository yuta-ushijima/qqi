<template>
  <div class="container">
    <h2 class="heading">ユーザー登録受付完了</h2>
    <div>
      <p>
          登録を受け付けました。<br />
          登録時のメールアドレスに認証用のURLを送付しましたので、 ご確認ください。<br />
          アクティベーション完了後、ログイン画面よりログインをお願いします。<br />
          (※このページは10秒後にログインページへリダイレクトします。)<br />
      </p>
    </div>
  </div>
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
  .heading {
    position: relative;
    display: inline-block;
    margin: 30px 0 15px;
    padding-bottom: 15px;
    letter-spacing: 2px;
    font-size: 3rem;
    align-items: center;
  }
  .container {
    text-align: center;
  }
  .heading::before,
  .heading::after {
      content: '';
      position: absolute;
      right: 0;
      bottom: 0;
      left: 0;
      border-bottom: 1px solid #999;
  }
  .heading::before {
      bottom: 5px;
  }
</style>
