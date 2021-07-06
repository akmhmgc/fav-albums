require 'rspotify'
require 'active_support'
require 'active_support/core_ext'

module SpotifyModule
  extend ActiveSupport::Concern

  included do
    RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:secret_id])
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
