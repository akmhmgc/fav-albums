Rails.application.routes.draw do
  root to: 'artists#index'
  resources :myFavArtistLists, controller: :artists, only: [:index, :show]
  resources :favorite_artists, only: %i[create] do
    post 'destroy_from_mylist', to: "favorite_artists#destroy_from_mylist", on: :collection
    post 'render_image', to: "favorite_artists#render_image", on: :collection
  end
  resources :artists, only: [:index]

  # セッションに保存されたアーティストを管理する
  resource :mylist, only: [:create, :destroy] do
    post 'render', on: :collection
  end

  # 出力された画像を表示する
  resources :favorite_artist_lists, only: [:show], param: :public_uid
end
