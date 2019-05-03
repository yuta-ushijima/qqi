class User < ApplicationRecord
  # validations
  validates :name, presence: true
  validates :name, uniqueness: true

  # association
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
end
