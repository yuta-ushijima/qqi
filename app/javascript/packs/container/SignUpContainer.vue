<template>
  <div class="container">
    <header_container></header_container>
    <h2 class="heading">ユーザー登録</h2>
    <form class="login__form" v-on:submit.prevent="signUp">
      <div>
        <label>ユーザー名</label>
        <input type="text" name="name" placeholder="ユーザー名を入力" v-model="name">
      </div>
        <div>
        <label>メールアドレス</label>
        <input type="text" name="email" placeholder="メールアドレスを入力" v-model="email">
      </div>
      <div>
        <label>パスワード</label>
        <input type="password" name="password" placeholder="パスワードを入力" v-model="password">
      </div>
      <button type="submit">登録</button>
    </form>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import Router from '../router/router'
  import Header_container from "Header.vue";

  @Component({
    components: { Header_container }
  })

  export default class UserRegistrationContainer extends Vue {
    public name: string = '';
    public email: string = '';
    public password: string = '';

    async signUp(): Promise<void> {

      const params = {
        name: this.name,
        email: this.email,
        password: this.password
      }

      await axios.post("/api/v1/auth", params).then((response) => {
        Router.push('/complete_user_registration')
      }).catch((error) => {
        alert(error)
      })
    }
  }
</script>

<style lang="scss" scoped>
  label {
    margin-left: 0;
  }
  button {
    display: block;
    width: 150px;
    margin: 20px auto 0;
    padding: 15px;
    cursor: pointer;
  }
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
  .login__form input[type=text],
  .login__form input[type=password] {
    width: 50%;
    display: block;
    margin: 10px auto;
    padding: 15px;
    border-radius: 0;
  }
  .login__form {
    width: 50%;
    margin: 100px auto;
    padding-top: 20px;
    padding-bottom: 20px;
    /*padding: 200px auto;*/
    border: rgba(0,153,255,0.5) dotted 2px;
    background-color: rgba(51,255,184,0.25);
  }
</style>
