Rails.application.routes.draw do
  root to: 'static_pages#home'
  resources :myFavArtistLists, controller: :artists, only: [:index, :show]
  resources :favorite_artists, only: %i[create] do
    post 'destroy_from_mylist', to: "favorite_artists#destroy_from_mylist", on: :collection
    post 'render_image', to: "favorite_artists#render_image", on: :collection
  end
end
