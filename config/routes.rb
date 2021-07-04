Rails.application.routes.draw do
  root to: 'static_pages#home'
  resources :artists, only: [:index]
  resources :favorite_artists, only: [:create, :destroy]
end
