FactoryBot.define do
  factory :comment do
    body { Faker::Books::Dune.saying }
    article
    user
  end
end
