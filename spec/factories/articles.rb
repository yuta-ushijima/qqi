# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  title       :string(255)
#  body        :text(65535)
#  post_status :string(255)      default("draft"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#

FactoryBot.define do
  factory :article do
    title { Faker::BossaNova.song }
    body {  Faker::Books::Dune.quote }
    post_status { Article.post_statuses[:draft] }
    user
  end
end
