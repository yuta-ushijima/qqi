<template>
  <v-container>
    <form>
      <v-text-field
          outline
          single-line
          v-model="articleTitle"
          name="title"
          label="タイトル"
          class="article__form__title"
      ></v-text-field>
      <v-textarea
          outline
          no-resize
          height="100%"
          v-model="articleBody"
          name="body"
          label="プログラミング知識をMarkdown記法で書いて共有しよう"
          class="article__form__body"
      ></v-textarea>
      <div class="text-xs-right">
        <v-btn @click="UpdateArticle" color="#55c500" class="white--text font-weight-bold">更新</v-btn>
      </div>
    </form>
  </v-container>
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
  export default class EditArticlesContainer extends Vue {
    articleTitle: string = '';
    articleBody: string = '';
    articlePostStatus: string = '';
    items: string[] = ['Foo', 'Bar', 'Fizz', 'Buzz'];


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

<style lang="scss" scoped>
  .article__form {
    height: calc(100% - 64px - 10px);
    display: flex;
    flex-flow: column;
    &__title {
      flex: none;
    }
  }
</style>
