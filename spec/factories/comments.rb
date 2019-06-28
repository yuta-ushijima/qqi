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

FactoryBot.define do
  factory :comment do
    body { Faker::Books::Dune.saying }
    article
    user
  end
end
