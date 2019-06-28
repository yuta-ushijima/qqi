# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  user_id    :bigint
#  article_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user, :article
end
