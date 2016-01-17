Rails.application.routes.draw do

  get 'playlists/index'

  get '/', to: 'landing#index'
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :landing, only: [:index, :show]
  resources :playlists, only: [:index, :show, :new, :create, :edit, :update]
  resources :songs, only: [:index, :new, :create]

end
