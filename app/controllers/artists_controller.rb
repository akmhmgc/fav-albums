class ArtistsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:secret_id])

  def home; end

  def index
    return if params[:search].blank?

    searchartists_array = RSpotify::Artist.search(params[:search])
    @searchartists = Kaminari.paginate_array(searchartists_array).page(params[:page]).per(10)
  end
end
