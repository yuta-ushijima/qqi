FactoryBot.define do
  factory :user do
    _name = Faker::Internet.username

    sequence(:name) {|n| "#{n}_#{_name}" }
    sequence(:email) {|n| Faker::Internet.email("#{n}_#{_name}") }
    password { Faker::Internet.password }
    uid { email }
    confirmed_at { DateTime.zone.now }
    provider { "email" }

    trait :with_comments do
      # association :user_detail, factory: :user_detailと同義
      comments
    end
  end
end
