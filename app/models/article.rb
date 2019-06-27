# frozen_string_literal: true

class Article < ApplicationRecord
  # association
  belongs_to :user

  enum post_status: { draft: "draft", published: "published" }
end
