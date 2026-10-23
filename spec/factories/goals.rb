FactoryBot.define do
  factory :goal do
    user { nil }
    name { "MyString" }
    total_budget { 1 }
    deadline { "2026-10-23" }
    is_active { false }
  end
end
