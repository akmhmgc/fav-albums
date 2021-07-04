module ArtistsHelper
  def included_in_mylists?(artist)
    return false unless session[:my_artists_list]

    artist_ids_in_mylist = session[:my_artists_list].map { |artist_info| artist_info["id"] }
    artist_ids_in_mylist.include?(artist["id"])
  end
end
