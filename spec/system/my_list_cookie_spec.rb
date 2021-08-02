require 'rails_helper'

RSpec.describe 'MyListCookie', type: :system do
  describe "アーティストを検索" do
    before 'search_for_bz' do
      visit root_path
      fill_in 'search', with: 'Bz'
      find_by_id("search_btn").click
    end

    it "プラスボタンを押すとアーティストが追加される", js: true do
      find('svg.plus-activated', match: :first).click
      expect(find("#flash")).to have_content 'アーティストが追加されました'
    end

    context "アーティストが5組追加されている場合" do
      before "アーティストを5組追加" do
        5.times do
          find('svg.plus-activated', match: :first).click
          expect(page).to have_content 'アーティストが追加されました'
        end
      end
      it "さらに追加することが出来ない", js: true do
        find('svg.plus-activated', match: :first).click
        expect(find("#flash")).to have_content "追加するためにはリストからアーティストを１組削除してください。"
      end

      it "マイナスボタンを押すとリストからアーティストが消える", js: true do
        find('#unlike_heart', match: :first).click
        expect(find("#flash")).to have_content 'アーティストが削除されました'
      end
    end
  end
end
