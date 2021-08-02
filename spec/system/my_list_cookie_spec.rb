require 'rails_helper'

RSpec.describe 'MyListCookie', type: :system do
  describe "アーティストの追加" do
    it "リンクを踏むとアーティストが追加される", js: true do
      visit root_path
      fill_in 'search', with: 'Bz'
      find_by_id("search_btn").click

      find('svg.plus-activated', match: :first).click
      expect(find("#flash")).to have_content 'アーティストが追加されました'
    end

    it "アーティストが5組いると追加されない", js: true do
      # ５組のアーティストの追加find('svg.svg-inline--fa', match: :first).click
      visit root_path
      fill_in 'search', with: 'Bz'
      find_by_id("search_btn").click
      5.times do
        find('svg.plus-activated', match: :first).click
        expect(page).to have_content 'アーティストが追加されました'
      end
      find('svg.plus-activated', match: :first).click
      expect(find("#flash")).to have_content "追加するためにはリストからアーティストを１組削除してください。"
    end
  end
end
