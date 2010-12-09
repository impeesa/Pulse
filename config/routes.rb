Pulse::Application.routes.draw do

  # This is a workaround.
  # Originally, /auth/google was to be the url for OmniAuth to use.
  # Howevever, a bug made it so that /auth/google would only work the 1st time.
  # After the 1st time, it defaulted to /auth/google_apps.
  # http://github.com/intridea/omniauth/issues#issue/61.
  # Update: this issue has since been fixed. New version should allow us to delete this workaround.
  get '/auth/google', :to => redirect('/auth/google_apps')
  match '/auth/:provider/callback', :to => 'sessions#create', :as => :successful_authentication
  get 'login', :to => redirect('/auth/google')
  get 'logout' => 'sessions#destroy'

  get '/results/table' => 'results#table'
  resources :results

  resources :groups

  resources :users

  resources :charts
  match '/chart_javascripts/:action' => 'chart_javascripts', :as => 'chart_javascripts'

  root :to => "results#index"

end
