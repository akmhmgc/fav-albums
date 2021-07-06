class FavoriteArtistsController < ApplicationController
  include SpotifyModule
  def create
    # params[:artist_info] = {id: "5kVZa4lFUmAQlBogl1fkd6", name:"Aimyon", image_url: "https://i.scdn.co/image/ab676161"}
    @artist = params.require(:artist_info).permit(:id, :name, :image_url).to_h.with_indifferent_access
    if add_artist_to_mylist(@artist)
      respond_to do |format|
        format.html { redirect_to artists, flash[:notice] = "アーティストが追加されました。" }
        format.js { flash.now[:notice] = "アーティストが追加されました。" }
      end
    else
      redirect_to artists_path, flash: { alert: @error_msg }
    end
  end

  def destroy
    artist_instance = RSpotify::Artist.find(params[:id])
    @artist = spotify_to_hash(artist_instance)
    if delete_artist_from_mylist(@artist)
      respond_to do |format|
        format.html { redirect_to artists, flash[:notice] = "アーティストが削除されました。" }
        format.js { flash.now[:notice] = "アーティストが削除されました。" }
      end
    else
      redirect_to artists_path, flash: { alert: "アーティストの削除に失敗しました。" }
    end
  end

  private

  # フラッシュメッセージの場所は関数の内側に持ってきていいのか？
  def add_artist_to_mylist(artist_hash)
    session[:my_artists_list] = [] and return unless session[:my_artists_list]

    if session[:my_artists_list].count >= 5
      @error_msg = "追加するためにはリストからアーティストを１組削除してください。"
      false
    elsif session[:my_artists_list].include?(artist_hash)
      @error_msg = "既にアーティストは追加されています。"
      false
    else
      session[:my_artists_list] << artist_hash
    end
  end

  def delete_artist_from_mylist(artist_hash)
    session[:my_artists_list].delete_if { |hash| hash["id"] == artist_hash["id"] }
  end
end