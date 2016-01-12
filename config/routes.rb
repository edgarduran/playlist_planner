Rails.application.routes.draw do

  get '/', to: 'landing#index'
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :landing, only: [:index, :show]

end
