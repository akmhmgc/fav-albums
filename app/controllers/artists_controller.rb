class ArtistsController < ApplicationController
  include SpotifyModule
  def home; end

  def index
    # session[:my_artists_list].clear
    return if params[:search].blank?

    searchartists_array = RSpotify::Artist.search(params[:search]).map { |artist| spotify_to_hash(artist) }
    @searchartists = Kaminari.paginate_array(searchartists_array).page(params[:page]).per(10)
  end

  def show
    @my_list = MyList.find_by(public_uid: params[:id])
    artists_list = @my_list.artists.map(&:name)
    @description = "#{@my_list.nickname}さんを構成するアーティストは#{artists_list.join('・')}です。"
    return unless flash[:notice]

    @description_twitter = <<~MSG
      #{@my_list.nickname}さんを構成するアーティストは%0a#{artists_list.join('%0a')}です。%0a
      @Buffalo_G_7777 %20%23私を構成する5組のアーティスト%20 #{myFavArtistList_url(@my_list.to_param)}
    MSG
  end
end
