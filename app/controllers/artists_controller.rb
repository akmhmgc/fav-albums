class ArtistsController < ApplicationController
  include SpotifyModule

  def index
    # session[:my_artists_list].clear
    return if params[:search].blank?

    searchartists_array = RSpotify::Artist.search(params[:search]).map { |artist| spotify_to_hash(artist) }.compact
    @searchartists = Kaminari.paginate_array(searchartists_array).page(params[:page]).per(10)
  end
end
