<template>
  <v-container>
    <form class="login__form" v-on:submit.prevent="signIn">
      <v-text-field
          v-model="email"
          label="メールアドレス"
          data-vv-name="email"
          v-validate="'required|email'"
          :error-messages="errors.collect('email')"
          required
          autocomplete="off"
      ></v-text-field>
      <v-text-field
          v-model="password"
          label="パスワード"
          data-vv-name="password"
          v-validate="'required|min:8|max:50'"
          :error-messages="errors.collect('password')"
          :append-icon="show ? 'visibility' : 'visibility_off'"
          :type="show ? 'text' : 'password'"
          counter
          hint="At least 8 characters"
          @click:append="show = !show"
          required
          autocomplete="off"
      ></v-text-field>

      <v-btn @click="signIn" color="#55c500" class="white--text font-weight-bold">ログイン</v-btn>
    </form>
  </v-container>
</template>

<script lang="ts">
  import axios from "axios"
  import VeeValidate from "vee-validate";
  import { Vue, Component } from "vue-property-decorator"
  import Router from '../router/router'

  Vue.use(VeeValidate, { locale: "ja" });

  @Component
  export default class LoginContainer extends Vue {

    $_veeValidate: {
      validator: "new";
    };

    email: string = '';
    password: string = '';
    show: boolean = false;
    dictionary: {
      attributes: {
        email: "Email Addresses";
      };
    };

    mounted() {
      this.$validator.localize("ja", this.dictionary);
    }

    async signIn(): Promise<void> {
      const params = {
        email: this.email,
        password: this.password
      };

      await axios.post("/api/v1/auth/sign_in", params).then((response) => {
        // TODO: MyPage実装後にpush先を変更
        localStorage.setItem('access-token', response.headers["access-token"]);
        localStorage.setItem('uid', response.headers["uid"]);
        localStorage.setItem('client', response.headers["client"]);
        Router.push('/articles');
        window.location.reload();
      }).catch((e) => {
        alert(e.response.data.errors)
      })
    }
  }
</script>

<style lang="scss" scoped>

</style>
