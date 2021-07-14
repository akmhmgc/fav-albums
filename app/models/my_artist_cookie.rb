class MyArtistCookie
  include ActiveModel::Model
  # session[:my_artists_list] = [{"id"=>"7i9bNUSGORP5MIgrii3cJc", "name"=>"B'z", "image_url"=>"https://i.scdn.co/image/ab676161000051746e6b410275dcbaf1d872ff35"}, {"id"=>"0Y5tJX1MQlPlqiwlOH1tJY", "name"=>"Travis Scott", "image_url"=>"https://i.scdn.co/image/ab67616100005174e707b87e3f65997f6c09bfff"}, {"id"=>"6tBzJqpqRAPyJFR4Rq0yBP", "name"=>"Walter Beasley", "image_url"=>"https://i.scdn.co/image/ab67616100005174f6c3a8f436340121e4c42888"}, {"id"=>"4exLIFE8sISLr28sqG1qNX", "name"=>"Travis Barker", "image_url"=>"https://i.scdn.co/image/ab67616100005174217f81a86110ebc7c0e43fb3"}, {"id"=>"3fyHEOOcbca0AhyPGLErpG", "name"=>"BZ", "image_url"=>"https://i.scdn.co/image/ab676161000051745539757923a03ff37b8d1fea"}]

  attr_accessor :id, :name, :image_url

  validates :id, presence: true
  validates :name, presence: true
  validates :image_url, presence: true

  # cookieへの保存
  def save
    validate && validate_artist && store_artist_in_cookie
  end

  # クッキーから削除するメソッド
  def destroy; end

  class << self
    # idを利用してcookieから検索する
    def find(id); end
  end

  private

  def store_artist_in_cookie
    session[:my_artists_list] << artist_hash
  end

  def validate_artist
    session[:my_artists_list] = [] and return unless session[:my_artists_list]

    if session[:my_artists_list].count >= 5
      @error_msg = "追加するためにはリストからアーティストを削除してください。"
      false
    elsif session[:my_artists_list].map{|artist| artist["id"]}.include(@id)
      @error_msg = "既にアーティストは追加されています。"
      false
    else
      true
    end
  end
end
