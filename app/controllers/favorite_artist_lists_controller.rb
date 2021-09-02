class FavoriteArtistListsController < ApplicationController
  def show
    @my_list = MyList.find_by(public_uid: params[:public_uid])
    artist_names = @my_list.artists.map(&:name)
    @description = "#{@my_list.nickname}さんを構成するアーティストは#{artist_names.join('・')}です。"

    # MylistsController#render_imageからredirectした時 = 初めてページが作成された時はtwitterへのシェア用の文章が作成される
    return unless flash[:notice]

    @description_twitter = "#{@my_list.nickname}さんを構成するアーティストは%0a#{artist_names.join('%0a')}です。%0a@Buffalo_G_7777 %20%23私を構成する5組のアーティスト%20 #{favorite_artist_list_url(@my_list.to_param)}"
  end
end
