# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  password               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#  tokens                 :text(65535)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :string(255)
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

FactoryBot.define do
  factory :user do
    _name = Faker::Internet.username

    sequence(:name) {|n| "#{n}_#{_name}" }
    sequence(:email) {|n| Faker::Internet.email("#{n}_#{_name}") }
    password { Faker::Internet.password }
    uid { email }
    confirmed_at { DateTime.current }
    provider { "email" }

    trait :with_comments do
      # association :user_detail, factory: :user_detailと同義
      comments
    end
  end
end
