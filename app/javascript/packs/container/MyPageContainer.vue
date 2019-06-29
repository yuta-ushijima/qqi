<template>
  <div id="mypage-container">
    <header_container></header_container>
    <ul>
      <h2>私が投稿した記事一覧</h2>

      <li v-for="myArticle in myArticles" :key="myArticle.id">

        <div class="article__title">
          <router-link :to="{ name: 'edit_article', params: { articleId: myArticle.id } }">
            {{myArticle.attributes.title}}
          </router-link>
        </div>

        <div class="article-status">{{myArticle.attributes.post_status}}</div>

        <div class="delete__button">
          <button class="" @click="deleteArticle">
            削除
          </button>
        </div>
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
    articleId: number;

    async mounted(): Promise<void> {
      await this.fetchMyArticles();
    }

    async fetchMyArticles(): Promise<void> {
      await axios.get("/api/v1/my_articles", config).then((response) => {
        response.data.data.map((myArticle: any) => {
          this.myArticles.push(myArticle);
          this.articleId = myArticle.id
        })
      })
    }

    async deleteArticle(): Promise<void> {
      if(confirm('本当に削除しますか？')) {
        await axios.delete(`/api/v1/articles/${this.articleId}`, config).then((response) => {
          this.$router.push('/my_page');
          window.location.reload();
          console.log(response)
        }).catch((error) => {
          alert(error)
        })
      }
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
    margin-bottom: 5px;
  }
</style>
