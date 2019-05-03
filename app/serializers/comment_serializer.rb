class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user, :article
end
