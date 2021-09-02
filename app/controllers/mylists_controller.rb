class MylistsController < ApplicationController
  include MyArtistsConverter
  def create
    @artist = params.require(:artist_info).permit(:id, :name, :image_url).to_h.with_indifferent_access
    if add_artist_to_mylist(@artist)
      respond_to do |format|
        format.html { redirect_to artists_path, flash[:notice] = "アーティストが追加されました。" }
        format.js { flash.now[:notice] = "アーティストが追加されました。" }
      end
    else
      redirect_to artists_path, flash: { alert: @error_msg }
    end
  end

  def destroy
    @artist = params.require(:artist_info).permit(:id, :name, :image_url).to_h.with_indifferent_access
    if delete_artist_from_mylist(@artist)
      respond_to do |format|
        format.html { redirect_to artists_path, flash[:notice] = "アーティストが削除されました。" }
        format.js { flash.now[:notice] = "アーティストが削除されました。" }
      end
    else
      redirect_to artists_path, flash: { alert: "アーティストの削除に失敗しました。" }
    end
  end

  def render_image
    nickname = params[:name]
    image_urls = session[:my_artists_list].map { |artist| artist["image_url"] }
    artist_names = session[:my_artists_list].map { |artist| artist["name"] }

    if can_save_image_from_mylist?(nickname, image_urls)
      image = rendered_image(nickname, image_urls)
      @my_list = MyList.create!(nickname: nickname, image: image)
      uid = @my_list.to_param

      artist_names.each do |artist_name|
        @my_list.artists.create!(name: artist_name)
      end

      session[:my_artists_list].clear
      redirect_to favorite_artist_list_path(uid), flash: { notice: "画像が作成されました！" }
    else
      redirect_to artists_path, flash: { alert: @error }
    end
  end

  private

  def add_artist_to_mylist(artist_hash)
    session[:my_artists_list] ||= []

    if session[:my_artists_list].count >= 5
      @error_msg = "追加するためにはリストからアーティストを１組削除してください。"
      return false
    end

    if session[:my_artists_list].include?(artist_hash)
      @error_msg = "既にアーティストは追加されています。"
      return false
    end

    session[:my_artists_list] << artist_hash
  end

  def delete_artist_from_mylist(artist_hash)
    session[:my_artists_list].delete_if { |hash| hash["id"] == artist_hash["id"] }
  end
end
