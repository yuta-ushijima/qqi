<template>
  <div class="container">
    <h2 class="heading">新規記事</h2>
    <form class="login__form" v-on:submit.prevent="PostArticles">
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
        <div>
          <select name="post_status" v-model="post_status">
            <option value="draft">下書き保存</option>
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

  @Component
  export default class PostArticlesContainer extends Vue {
    public title: string = '';
    public body: string = '';
    public post_status: string = '';

    async PostArticles(): Promise<void> {

      const params = {

        title: this.title,
        body: this.body,
        post_status: this.post_status,
      }

      await axios.post("/api/v1/articles", params, config).then((response) => {
        this.$router.push('/articles')
      }).catch((error) => {
        alert(error)
      })
    }
  }
</script>

<style lang="scss">

</style>
