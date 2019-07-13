<template>
  <v-container class="article__form">
    <form>
      <v-text-field
          outline
          single-line
          v-model="title"
          name="title"
          label="タイトル"
          class="article__form__title"
      ></v-text-field>
      <v-textarea
        outline
        no-resize
        height="100%"
        v-model="body"
        name="body"
        label="プログラミング知識をMarkdown記法で書いて共有しよう"
        class="article__form__body"
      ></v-textarea>
      <input type="file" @change="onFileChange" name="image">
      <div class="text-xs-right">
        <v-btn @click="PostArticles" color="#55c500" class="white--text font-weight-bold">QiitaClone2019に投稿</v-btn>
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
  export default class PostArticlesContainer extends Vue {
    public title: string = '';
    public body: string = '';
    public image: object = {};
    public post_status: string = 'published';

    async onFileChange(e) {
      let files = e.target.files || e.dataTransfer.files;
      await console.log(files[0]);
      this.image = files[0]
    }

    async PostArticles(): Promise<void> {
      const params = {
        title: this.title,
        body: this.body,
        image: this.image,
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

<style lang="scss"scoped>
  .article__form {
    height: calc(100% - 64px - 10px);
    display: flex;
    flex-flow: column;
    &__title {
      flex: none;
    }
  }
</style>

<style lang="scss">
  .article__form__body > .v-input__control {
    height: 500px;
  }
  .v-text-field .v-text-field__details {
    display: none;
  }
</style>
