<template>
  <v-container class="item elevation-3 article__container">
   <v-list two-line>
     <template v-for="myArticle in myArticles">
       <v-list-tile :key="myArticle.title" avatar>

         <v-list-tile-avatar>
           <img :src="myArticle.avatar">
         </v-list-tile-avatar>

         <v-list-tile-content>
           <v-list-tile class="article__container--title">
             <router-link :to="{ name: 'edit_article', params: { articleId: myArticle.id } }" class="article__href--no-decoration">
               {{myArticle.attributes.title}}
             </router-link>
             <div class="article__container--post-status">{{myArticle.attributes.post_status}}</div>
             <div class="article__container--delete">
               <button class="" @click="deleteArticle">
                 削除
               </button>
             </div>
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
  };

  Vue.use(VueRouter);

  @Component
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
        }).catch((error) => {
          alert(error)
        })
      }
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
    &--post-status {
      margin-left: 0.5em;
    }
    &--delete {
      margin-left: 0.5em;
    }
  }
</style>
