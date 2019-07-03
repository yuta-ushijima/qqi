<template>
  <v-list two-line>
    <v-container class="item elevation-3 article__container">
      <v-layout></v-layout>
      <v-layout>
        <h1 class="article__container--title">{{articleTitle}}</h1>
      </v-layout>
      <v-layout>
        <div class="article__container--body" v-html="compiledMarkdown"></div>

      </v-layout>
    </v-container>
  </v-list>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'
  import marked from "marked"
  import hljs from "highlight.js"

  Vue.use(VueRouter);

  const config = {
    headers: {
      'Authorization': 'Bearer',
      'Access-Control-Allow-Origin': '*',
      'access-token': localStorage.getItem('access-token'),
      'client': localStorage.getItem('client'),
      'uid': localStorage.getItem('uid')
    }
  };

  @Component
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

    async created(): Promise<void> {
      const renderer = new marked.Renderer();
      renderer.code = function (code, language) {
        return (
          "<pre"+'><code class="hljs">'+hljs.highlightAuto(code).value + "</code></pre>"
        )

      }
      marked.setOptions({
        renderer: renderer,
        tables: true,
        sanitize: true,
        langPrefix: "",
        highlight: function (code, lang) {
          if (!lang || lang == "default") {
            return hljs.highlightAuto(code, [lang]).value;
          } else {
            try {
              return hljs.highlight(lang, code, true).value;
            } catch (e) {
              // Do nothing!
            }
          }
        }
      });
    }

    get compiledMarkdown() {
      return marked(this.articleBody)
    }
  }
</script>

<style lang="scss" scoped>
  .article__container {
    margin-top: 1.5em;
    &--title {
      font-size: 2.5em;
      line-height: 1.4;
    }
    &--body {
      margin: 2em 0;
      font-size: 16px;
    }
  }
</style>

<style lang="scss">
  .article__container {
    code:before {
      content: "";
    }
  }
</style>
