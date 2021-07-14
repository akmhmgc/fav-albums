class MyArtist
  include ActiveModel::Model

  attr_accessor :id, :name, :image_url

  validates :id, presence: true
  validates :name, presence: true
  validates :image_url, presence: true

  # cookieへの保存
  def save_to(session)
    validate && validate_artist(session) && store_artist_in(session)
  end

  # cookieから削除するメソッド
  def destroy_from(session); end

  class << self
    # idを利用してcookieから検索する
    def find(id); end

    def count(session)
      session[:my_artists_list] ? session[:my_artists_list].count : 0
    end
  end

  private

  def store_artist_in(session)
    session[:my_artists_list] << {id:@id, name:@name, image_url: @image_url}
  end

  def validate_artist(session)
    session[:my_artists_list] = []  unless session[:my_artists_list]

    if session[:my_artists_list].count >= 5
      @error_msg = "追加するためにはリストからアーティストを削除してください。"
      false
    elsif session[:my_artists_list].map { |artist| artist["id"] }.include?(@id)
      @error_msg = "既にアーティストは追加されています。"
      false
    else
      true
    end
  end
end
