FactoryBot.define do
  factory :payment do
    user { nil }
    amount { 1 }
    memo { "MyString" }
    date { "2026-10-22" }
  end
end
