require 'rails_helper'

RSpec.describe MyArtistCookie, type: :model do
  it "有効なモデルの作成" do
    artist_cookie = FactoryBot.build(:my_artist_cookie)
    expect(artist_cookie).to be_valid
  end

  it "idがない場合、無効である" do
    artist_cookie = FactoryBot.build(:my_artist_cookie, id:"")
    artist_cookie.valid?
    expect(artist_cookie.errors.of_kind?(:id, :blank)).to be_truthy
  end

  it "nameがない場合、無効である" do
    artist_cookie = FactoryBot.build(:my_artist_cookie, name:"")
    artist_cookie.valid?
    expect(artist_cookie.errors.of_kind?(:name, :blank)).to be_truthy
  end

  it "image_urlがない場合、無効である" do
    artist_cookie = FactoryBot.build(:my_artist_cookie, image_url:"")
    artist_cookie.valid?
    expect(artist_cookie.errors.of_kind?(:image_url, :blank)).to be_truthy
  end
end
