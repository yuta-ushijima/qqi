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


class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
end
