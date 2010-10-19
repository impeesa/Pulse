Pulse::Application.routes.draw do

  resources :results
  root :to => "result#index"
  # This is a workaround.
  # Originally, /auth/google was to be the url for OmniAuth to use.
  # Howevever, a bug made it so that /auth/google would only work the 1st time.
  # After the 1st time, it defaulted to /auth/google_apps.
  # http://github.com/intridea/omniauth/issues#issue/61.
  match '/auth/google', :to => redirect('/auth/google_apps')
  match '/auth/:provider/callback', :to => 'sessions#create', :as => :successful_authentication

end
