FactoryBot.define do
  factory :target do
    user { nil }
    name { "MyString" }
    total_budget { 1 }
    deadline { "2026-10-22" }
    is_active { false }
  end
end
