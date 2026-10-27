FactoryBot.define do
  factory :user do
    nickname { "ズボラ太郎" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    monthly_allowance { 100_000 } # デフォルト最大HP
  end
end
