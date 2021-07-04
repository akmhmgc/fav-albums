class ArtistsController < ApplicationController
  require 'rspotify'
  require 'active_support'
  require 'active_support/core_ext'
  RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:secret_id])

  def home; end

  def index
    # session[:my_artists_list].clear
    return if params[:search].blank?

    searchartists_array = RSpotify::Artist.search(params[:search]).map { |artist| spotify_to_hash(artist) }
    @searchartists = Kaminari.paginate_array(searchartists_array).page(params[:page]).per(10)
  end

  private

  def spotify_to_hash(spotify_instance)
    image_url = if spotify_instance.images.any?
                  spotify_instance.images[1]["url"]
                else
                  "no_image.png"
                end

    { "id": spotify_instance.id, "name": spotify_instance.name, "image_url": image_url }.with_indifferent_access
  end
end
