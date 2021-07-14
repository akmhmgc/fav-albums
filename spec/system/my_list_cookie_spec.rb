require 'rails_helper'

RSpec.describe 'MyListCookie', type: :system do
  let(:session) { ActionDispatch::Request.empty.session }
  describe "アーティストの追加" do
    it "リンクを踏むとアーティストが追加される", js: true do
      visit root_path
      fill_in 'search', with: 'Bz'
      find_by_id("search_btn").click
      find('svg.svg-inline--fa', match: :first).click
      expect(page).to have_content 'アーティストが追加されました'
    end

    fit "アーティストが5組いると追加されない" , js: true do
      # ５組のアーティストの追加
      visit root_path
      fill_in 'search', with: 'Bz'
      5.times do 
        find_by_id("search_btn").click
      end
      expect(page).to have_content 'アーティストが追加されました'
    end

    it "既にいるアーティストは追加されない" do
    end
  end
end
