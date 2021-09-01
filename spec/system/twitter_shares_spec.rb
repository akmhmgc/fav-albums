require 'rails_helper'

RSpec.describe "TwitterShares", type: :system do
  it "選択されたアーティスト名が正しく表示される", js: true do
    find('svg.plus-activated', match: :first).click
    expect(find("#flash")).to have_content 'アーティストが追加されました'
  end
end
