<template>
  <form>
    <v-text-field
      v-model="name"
      label="ユーザー名"
      data-vv-name="name"
      v-validate="'required|max:10'"
      :error-messages="errors.collect('name')"
      :counter="10"
      required

    ></v-text-field>
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

    <v-btn @click="signUp" color="#55c500" class="white--text font-weight-bold">登録</v-btn>
  </form>
</template>

<script lang="ts">
  import axios from "axios"
  import VeeValidate from "vee-validate"
  import { Vue, Component } from "vue-property-decorator"
  import Router from '../router/router'

  Vue.use(VeeValidate, { locale: "ja" });

  @Component
  export default class UserRegistrationContainer extends Vue {

    $_veeValidate: {
      validator: "new";
    };

    name: string = '';
    email: string = '';
    password: string = '';
    show: boolean = false;
    dictionary: {
      attributes: {
        email: "Email Addresses";
      };
      custom: {
        name: {
          required: () => "Name can not be empty";
          max: "The name field may not be greater than 10 characters";
        };
      };
    };

    mounted() {
      this.$validator.localize("ja", this.dictionary)
    }

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

</style>
