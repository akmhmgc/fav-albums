Rails.application.routes.draw do
  root to: 'artists#index'
  resources :artists, only: [:index]

  # セッションに保存されたアーティストを管理する
  resource :mylist, only: [:create, :destroy] do
    post 'render_image', on: :collection
  end

  # 出力された画像を表示する
  resources :favorite_artist_lists, only: [:show], param: :public_uid
end
