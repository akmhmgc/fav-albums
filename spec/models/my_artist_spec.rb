require 'rails_helper'

RSpec.describe MyArtist, type: :model do
  it "有効なモデルの作成" do
    artist_cookie = FactoryBot.build(:my_artist)
    expect(artist_cookie).to be_valid
  end

  it "idがない場合、無効である" do
    artist_cookie = FactoryBot.build(:my_artist, id: "")
    artist_cookie.valid?
    expect(artist_cookie.errors.of_kind?(:id, :blank)).to be_truthy
  end

  it "nameがない場合、無効である" do
    artist_cookie = FactoryBot.build(:my_artist, name: "")
    artist_cookie.valid?
    expect(artist_cookie.errors.of_kind?(:name, :blank)).to be_truthy
  end

  it "image_urlがない場合、無効である" do
    artist_cookie = FactoryBot.build(:my_artist, image_url: "")
    artist_cookie.valid?
    expect(artist_cookie.errors.of_kind?(:image_url, :blank)).to be_truthy
  end

  describe "メソッドのテスト" do
    let(:session) { ActionDispatch::Request.empty.session }
    describe "save" do
      it "有効なモデルを保存する" do
        artist_cookie = FactoryBot.build(:my_artist)
        expect{ artist_cookie.save_to(session) }.to change{ MyArtist.count(session)}.by(1)
      end
    end
  end
end
