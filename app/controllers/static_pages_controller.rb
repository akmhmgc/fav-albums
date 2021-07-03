class StaticPagesController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:secret_id])

  def home; end

  def artists
    @searchartists = RSpotify::Artist.search(params[:search]) if params[:search].present?
  end
end
