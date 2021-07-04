class FavoriteArtistsController < ApplicationController
  require 'active_support'
  require 'active_support/core_ext'
  def create
    # params[:artist_info] = {id: "5kVZa4lFUmAQlBogl1fkd6", name:"Aimyon", image_url: "https://i.scdn.co/image/ab676161"}
    @artist = params.require(:artist_info).permit(:id, :name, :image_url).to_h.with_indifferent_access
    if can_added_to_mylist?(@artist)
      add_artist_to_mylist(@artist)
      respond_to do |format|
        format.html { redirect_to artists }
        format.js
      end
    else
      redirect_to artists_path
    end
  end

  def destroy
    @artist = Like.find(params[:id])
    current_user.unlike(@product)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js { flash.now[:notice] = "商品がお気に入りから削除されました" }
    end
  end

  private

  def can_added_to_mylist?(artist_hash)
    session[:my_artists_list] = [] and return unless session[:my_artists_list]

    if session[:my_artists_list].count >= 5
      flash.now[:alart] = "追加するためには現在のリストからアーティストを１組削除してください。"
      false
    elsif session[:my_artists_list].include?(artist_hash)
      flash.now[:alart] = "既にアーティストは追加されています。"
      false
    else
      true
    end
  end

  def add_artist_to_mylist(artist_hash)
    session[:my_artists_list] << artist_hash
    flash.now[:notice] = "アーティストが追加されました。"
  end
end
