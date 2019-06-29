<template>
  <div class="container">
    <header_container></header_container>
    <h2 class="heading">新規記事</h2>
    <form class="article__form" v-on:submit.prevent="PostArticles">
        <div>
          <label>タイトル</label>
          <input type="text" name="title" placeholder="タイトル" v-model="title">
        </div>
        <div>
          <label>本文</label>
          <textarea name="body"
                    placeholder="プログラミング知識をMarkdown記法で書いて共有しよう"
                    cols="30"
                    rows="10"
                    v-model="body"
          >
          </textarea>
        </div>
        <div class="article__form__selectBox">
          <select class="dropdown" name="post_status" v-model="post_status">
            <option selected value="draft">下書き保存</option>
            <option value="published">公開する</option>
          </select>
        </div>
        <button type="submit">投稿する</button>
    </form>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'
  import Header_container from "Header.vue";

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

  export default class PostArticlesContainer extends Vue {
    public title: string = '';
    public body: string = '';
    public post_status: string = 'published';

    async PostArticles(): Promise<void> {

      const params = {
        title: this.title,
        body: this.body,
        post_status: this.post_status,
      };

      await axios.post("/api/v1/articles", params, config).then((response) => {
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
