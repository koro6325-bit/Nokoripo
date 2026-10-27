FactoryBot.define do
  factory :target do
    association :user # 自動的に上記のuserと紐付ける設定
    name { "12月の旅行" }
    total_budget { 50_000 } # 死守する金額
    deadline { Date.current + 1.month }
    is_active { true }
  end
end
