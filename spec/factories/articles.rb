FactoryBot.define do
  factory :article do
    title { Faker::BossaNova.song }
    body {  Faker::Books::Dune.quote }
    post_status { Article.post_statuses[:draft] }
    user
  end
end
