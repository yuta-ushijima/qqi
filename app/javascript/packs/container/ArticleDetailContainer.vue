<template>
  <div class="container">
    <header_container></header_container>
    <h2 class="heading">記事詳細</h2>
      <div class="article">
        <h1>{{articleTitle}}</h1>
        <div class="article-body">{{articleBody}}</div>
      </div>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'
  import Header_container from "./Header.vue";

  Vue.use(VueRouter);

  const config = {
    headers: {
      'Authorization': 'Bearer',
      'Access-Control-Allow-Origin': '*',
      'access-token': localStorage.getItem('access-token'),
      'client': localStorage.getItem('client'),
      'uid': localStorage.getItem('uid')
    }
  }

  @Component({
    components: { Header_container }
  })

  export default class ArticleDetailContainer extends Vue {
    articleTitle: string = '';
    articleBody: string = '';

    async mounted(): Promise<void> {
      await axios.get(`/api/v1/articles/${this.$route.params.articleId}`, config).then((response) => {
        this.articleTitle = response.data.data.attributes.title;
        this.articleBody = response.data.data.attributes.body;
      }).catch((error) => {
        alert(error)
      })
    }
  }
</script>

<style lang="scss">
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
  .article {
    width: 90%;
    margin: 100px auto;
    padding-top: 20px;
    padding-bottom: 20px;
    border: rgba(0,153,255,0.5) dotted 2px;
    background-color: rgba(51,255,184,0.25);
    display: block;
    border-radius: 0;
    .article-body {
      width: 90%;
      height: 100%;
      display: block;
      background-color: #FFF;
      margin: 10px auto;
      padding: 15px;
    }
  }
</style>
