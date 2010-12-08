Pulse::Application.routes.draw do

  resources :groups
  resources :users

  # This is a workaround.
  # Originally, /auth/google was to be the url for OmniAuth to use.
  # Howevever, a bug made it so that /auth/google would only work the 1st time.
  # After the 1st time, it defaulted to /auth/google_apps.
  # http://github.com/intridea/omniauth/issues#issue/61.
  get '/auth/google', :to => redirect('/auth/google_apps')
  match '/auth/:provider/callback', :to => 'sessions#create', :as => :successful_authentication
  get 'login', :to => redirect('/auth/google')
  get 'logout' => 'sessions#destroy'

  get '/results/table' => 'results#table'
  resources :results
  root :to => "results#index"

  match '/charts(/:action)' => 'charts'
  #match '/javascripts/:action' => 'javascripts#:action'

end
