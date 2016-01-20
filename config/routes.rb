Rails.application.routes.draw do

  get 'playlists/index'

  get '/', to: 'landing#index'
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :landing, only: [:index, :show]
  resources :playlists, only: [:index, :show, :new, :create, :edit, :update]
  resources :songs, only: [:index, :new, :create, :destroy, :add]
  get 'songs/add', to: 'songs#add', as: "song_add"
  resources :mailers, only: [:create]
  resources :requests, only: [:show, :index, :create, :update]


end
