module ArtistsHelper
  def artist_image_url(artist)
    if artist.images.any?
      artist.images[1]["url"]
    else
      "no_image.png"
    end
  end

  #   アーティストがリストに追加されているかどうか
#   def included_in_lists?(artist)

#   end
end
