Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'artists', to: 'static_pages#artists'
end
