<template>
  <div id="mypage-container">
    <header_container></header_container>
    <ul>
      <h2>私が投稿した記事一覧</h2>
      <li v-for="" :key="">
        <div class="">{{}}</div>
        <div class="">{{}}</div>
      </li>
    </ul>
  </div>
</template>


<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'
  import Header_container from "packs/container/header_container.vue";

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

  Vue.use(VueRouter);

  @Component({
    components: { Header_container }
  })

  export default class MyPageContainer extends Vue {

  }
</script>

<style lang="scss"></style>
