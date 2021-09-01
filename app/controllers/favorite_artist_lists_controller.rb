class FavoriteArtistListsController < ApplicationController
  def show
    @my_list = MyList.find_by(public_uid: params[:public_uid])
    artists_list = @my_list.artists.map(&:name)
    @description = "#{@my_list.nickname}さんを構成するアーティストは#{artists_list.join('・')}です。"
    return unless flash[:notice]

    @description_twitter = "#{@my_list.nickname}さんを構成するアーティストは%0a#{artists_list.join('%0a')}です。%0a@Buffalo_G_7777 %20%23私を構成する5組のアーティスト%20 #{favorite_artist_list_url(@my_list.to_param)}"
  end
end
