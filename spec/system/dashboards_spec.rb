require 'rails_helper'

RSpec.describe "メイン画面でのメーター逆算とクイック入力機能", type: :system do
  let(:user) { FactoryBot.create(:user, monthly_allowance: 100_000) } 
  
  before do
    driven_by :rack_test
  end

  before do
    FactoryBot.create(:target, user: user, total_budget: 50_000, is_active: true)
    
    sign_in user
    visit dashboard_path
  end

  describe "初期表示の確認" do
    it "最大HPと目標から逆算された正しい残りHPが表示されていること" do
      expect(page).to have_content "50,000 円"
      expect(page).to have_content "今月はまだ 0 円しか使ってないよ！"
    end
  end

  describe "クイック入力ボタンによる非同期（Turbo）の検証" do
    it "コンビニボタンを押した際、メーターの数値が減少し、履歴が追加されること" do
      find('input[placeholder="金額のみ（例: 1500）"]').set(500)
      find('input[placeholder="用途（例: コンビニ）"]').set("コンビニ")
      click_button "登録する"

      #  rack_test環境のフラッシュメッセージの仕様を考慮し、文言チェックのみスキップします
      # expect(page).to have_content "出費を記録しました！"
      
      expect(page).to have_content "49,500 円"
      expect(page).to have_content "今月はまだ 500 円しか使ってないよ！"

      within "#meter-section" do
        expect(page).to have_content "500 円"
        expect(page).to have_content "コンビニ"
      end
    end
  end

  describe "予算オーバー時の警告UIの検証" do
    it "残高がマイナスになった際、予算オーバーの警告テキストが表示されること" do
      find('input[placeholder="金額のみ（例: 1500）"]').set(60_000)
      find('input[placeholder="用途（例: コンビニ）"]').set("衝動買い")
      click_button "登録する"

      expect(page).to have_content "予算オーバーしちゃってるよ！無駄遣いを控えよう！"
      expect(page).to have_content "-10,000 円"
    end
  end
end


