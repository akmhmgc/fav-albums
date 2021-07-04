class FavoriteArtistsController < ApplicationController
  def create
    add_artist_to_mylist(params[:artist_hash])

    respond_to do |format|
      format.html { redirect_to artists }
      format.js
    end
  end

  def destroy
    @product = Like.find(params[:id]).product
    current_user.unlike(@product)
    respond_to do |format|
      format.html { redirect_to artists }
      format.js { flash.now[:notice] = "商品がお気に入りから削除されました" }
    end
  end

  private

  # artist_hash = {id: 2, artist_name: "Bz", img_url: "http://ww~"}
  def add_artist_to_mylist(artist_hash)
    session[:my_artists_list] = [] unless session[:artists]
    if session[:my_artists_list].count >= 5
      flash.now[:alart] = "追加するためには現在のリストからアーティストを１組削除してください。"
    else
      session[:my_artists_list] << artist_hash
      flash.now[:notice] = "アーティストが追加されました！"
    end
  end
end
