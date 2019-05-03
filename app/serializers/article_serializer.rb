class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :post_status
end
