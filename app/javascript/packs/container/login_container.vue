<template>
  <div class="container">
    <h2 class="heading">ログイン</h2>
    <form class="login__form">
      <div>
        <label>メールアドレス</label>
        <input type="text" name="email" placeholder="メールアドレスを入力" v-model="email">
      </div>
      <div>
        <label>パスワード</label>
        <input type="password" name="password" placeholder="パスワードを入力" v-model="password">
      </div>
      <button @click="signIn()">ログイン</button>
    </form>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component, Prop, Emit } from "vue-property-decorator"

  /* devise-auth-tokenで設定したヘッダー情報 */
  const config = {
    headers: {
      'Authorization': 'Bearer',
      'Access-Control-Allow-Origin': '*',
      'access-token': localStorage.getItem('access-token'),
      'client': localStorage.getItem('client'),
      'uid': localStorage.getItem('uid')
    }
  }

  @Component
  export default class LoginContainer extends Vue {
    // email: string = '';
    // password: string = '';
    public email: string = '';
    public password: string = '';

    // @Emit()
    // public input(value: string) {}


    async signIn(): Promise<void> {
      const params = {
        email: this.email,
        password: this.password
      }
      console.log(params);
      await axios.post("/api/v1/auth/sign_in", params).then((response) => {
        alert(`ログインしました ${response}`)
        console.log(response)
        this.$router.push({path: '/articles'})
      }).catch(error => {
        alert('メールアドレスまたはパスワードが正しくありません')
      })
    }
  }
</script>

<style lang="sass" scoped>
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
