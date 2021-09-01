class ArtistsController < ApplicationController
  include SpotifyModule

  def index
    return if params[:search].blank?

    @searchartists = Kaminari.paginate_array(search_artsits(params[:search])).page(params[:page]).per(10)
  end
end
