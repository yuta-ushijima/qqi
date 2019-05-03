<template>
    <div id="articles-container">
        <ul>
            <li v-for="article in articles" :key="article.id">
                <div class="article__title">{{article.title}}</div>
                <div class="article-body">{{article.body}}</div>
            </li>
        </ul>
    </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"

  @Component
  export default class ArticlesContainer extends Vue {
    articles: String[] = []

    async mounted(): Promise<void> {
      await this.fetchArticles();
    }

    async fetchArticles(): Promise<void> {
      await axios.get("/api/v1/articles").then((response) => {
        response.data.data.map((article: any) => {
          this.articles.push(article.attributes);
        })
      })
    }
  }
</script>

<style lang="sass" scoped>
  li {
    list-style: none;
  }
  div:nth-of-type(2) {
    margin: 20px 0;
    border-bottom: rgba(0,153,255,0.5) dotted 2px;
  }
  .article__title {
    font-size: 1.5em;
  }
</style>
