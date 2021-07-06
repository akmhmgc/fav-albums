Rails.application.routes.draw do
  root to: 'static_pages#home'
  resources :artists, only: [:index]
  resources :favorite_artists, only: %i[create] do
    post 'destroy_from_mylist', to: "favorite_artists#destroy_from_mylist", on: :collection
  end
end
