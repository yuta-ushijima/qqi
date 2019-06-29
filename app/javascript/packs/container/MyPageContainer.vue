<template>
  <div id="mypage-container">
    <header_container></header_container>
    <ul>
      <h2>私が投稿した記事一覧</h2>
      <li v-for="myArticle in myArticles" :key="myArticle.id">
        <div class="article__title">title: {{myArticle.title}}</div>
        <div class="article-body">body: {{myArticle.body}}</div>
        <div class="article-status">status: {{myArticle.post_status}}</div>
      </li>
    </ul>
  </div>
</template>


<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'
  import Header_container from "./Header.vue";

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
    myArticles: String[] = []

    async mounted(): Promise<void> {
      await this.fetchMyArticles();
    }

    async fetchMyArticles(): Promise<void> {
      await axios.get("/api/v1/my_articles", config).then((response) => {
        response.data.data.map((myArticle: any) => {
          this.myArticles.push(myArticle.attributes);
        })
      })
    }
  }
</script>

<style lang="scss">
  li {
    list-style: none;
  }
  div:nth-of-type(3) {
    margin: 20px 0;
    border-bottom: rgba(0,153,255,0.5) dotted 2px;
  }
  .article__title {
    font-size: 1.5em;
  }
</style>
