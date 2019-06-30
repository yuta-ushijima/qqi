<template>
  <v-container class="item elevation-3 article__container">
    <v-list two-line>
      <template v-for="article in articles">
        <v-list-tile :key="article.title" avatar>

          <v-list-tile-avatar>
            <img :src="article.avatar">
          </v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile class="article__container--title">
              <router-link :to="{ name: 'article_detail', params: { articleId: article.id } }" class="article__href--no-decoration">
                {{article.attributes.title}}
              </router-link>
            </v-list-tile>

          </v-list-tile-content>
        </v-list-tile>
      </template>
    </v-list>
  </v-container>
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
  }

  Vue.use(VueRouter);

  @Component
  export default class ArticlesContainer extends Vue {
    articles: String[] = []

    async mounted(): Promise<void> {
      await this.fetchArticles();
    }

    async fetchArticles(): Promise<void> {
      await axios.get("/api/v1/articles").then((response) => {
        response.data.data.map((article: any) => {
          this.articles.push(article);
        })
      })
    }

    async signOut(): Promise<void> {
      await axios.delete('/api/v1/auth/sign_out', config).then(() => {
        alert('ログアウトしました')
        localStorage.clear();
        this.$router.push('/sign_in')
      }).catch(() => {
        console.log(config);
        alert('ログアウトに失敗しました')
      })
    }
  }
</script>

<style lang="scss" scoped>
  .article__href {
    &--no-decoration {
      text-decoration: none;
      }
  }

  .article__container {
    margin-top: 1.5em;
    &--title {
        font-size: 2.5em;
        line-height: 1.4;
    }
  }
</style>
