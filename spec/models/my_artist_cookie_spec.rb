require 'rails_helper'

RSpec.describe MyArtistCookie, type: :model do
  it "有効なモデルの作成" do
    artist_cookie = FactoryBot.build(:my_artist_cookie)
    expect(artist_cookie).to be_valid
  end

  it "有効なモデルの作成" do
    artist_cookie = FactoryBot.build(:my_artist_cookie)
    expect(artist_cookie).to be_valid
  end
end
