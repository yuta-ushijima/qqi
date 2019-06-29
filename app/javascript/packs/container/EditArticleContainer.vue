<template>
  <div class="container">
    <header_container></header_container>
    <h2 class="heading">記事編集</h2>
    <form class="article__form" v-on:submit.prevent="UpdateArticle">
      <div>
        <label>タイトル</label>
        <input type="text" name="title" placeholder="タイトル" v-model="articleTitle">
      </div>
      <div>
        <label>本文</label>
        <textarea name="body"
                  placeholder="プログラミング知識をMarkdown記法で書いて共有しよう"
                  cols="30"
                  rows="10"
                  v-model="articleBody"
        >
          </textarea>
      </div>
      <div class="article__form__selectBox">
        <select class="dropdown" name="post_status" v-model="articlePostStatus">
          <option selected value="draft">下書き保存に戻す</option>
          <option value="published">公開する</option>
        </select>
      </div>
      <button type="submit">更新する</button>
    </form>
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

  export default class EditArticlesContainer extends Vue {
    articleTitle: string = '';
    articleBody: string = '';
    articlePostStatus: string = '';

    async mounted(): Promise<void> {
      await axios.get(`/api/v1/articles/${this.$route.params.articleId}`, config).then((response) => {
        this.articleTitle = response.data.data.attributes.title;
        this.articleBody = response.data.data.attributes.body;
        this.articlePostStatus = response.data.data.attributes.post_status;
      }).catch((error) => {
        alert(error)
      })
    }

    async UpdateArticle(): Promise<void> {

      const params = {
        title: this.articleTitle,
        body: this.articleBody,
        post_status: this.articlePostStatus,
      };

      await axios.put(`/api/v1/articles/${this.$route.params.articleId}`, params, config).then((response) => {
        this.$router.push('/articles')
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
  .article__form {
    width: 90%;
    margin: 100px auto;
    padding-top: 20px;
    padding-bottom: 20px;
    border: rgba(0,153,255,0.5) dotted 2px;
    background-color: rgba(51,255,184,0.25);
    display: block;
    border-radius: 0;
    input[type=text] {
      width: 90%;
      margin: 10px auto;
      padding: 15px;
    }
    textarea {
      width: 90%;
      height: 500px;
      display: block;
      margin: 10px auto;
      padding: 15px;
    }
    .article__form__selectBox {
      padding: 20px;
      select {
        padding: 15px;
      }
    }

  }
</style>
