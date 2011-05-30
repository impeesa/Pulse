Pulse::Application.routes.draw do
  match "admins/index" => "admins#index", :as => "admins"
  match "admins/save_settings" => "admins#save_settings", :as => "save_settings"
  match "admins/save_permissions" => "admins#save_permissions", :as => "save_permissions"

  match "/nps" => "nps#summary", :as => "nps_summary"
  match "/nps/detail" => "nps#detail", :as => "nps_detail"

  # This is a workaround.
  # Originally, /auth/google was to be the url for OmniAuth to use.
  # Howevever, a bug made it so that /auth/google would only work the 1st time.
  # After the 1st time, it defaulted to /auth/google_apps.
  # http://github.com/intridea/omniauth/issues#issue/61.
  # Update: this issue has since been fixed. New version should allow us to delete this workaround.
  get '/auth/google', :to => redirect('/auth/google_apps')
  match '/auth/:provider/callback', :to => 'sessions#create', :as => :successful_authentication
  get 'google_login', :to => redirect('/auth/google')
  get 'logout' => 'sessions#destroy'
  match 'user/set_password/:id' => 'users#set_password', :as => 'set_password'
  match 'user/login' => 'sessions#new', :as => 'log_in'

  resources :charts

  match '/chart_javascripts/:action' => 'chart_javascripts', :as => 'chart_javascripts'
  match '/chart/default_size' => 'charts#default_size', :as => 'default_size'
  match '/results/chart_javascripts/:action' => 'chart_javascripts'

  get '/results/rev_by_div' => 'results#rev_by_div', :as => 'rev_by_div_result'
  get '/results/rev_by_prod' => 'results#rev_by_prod', :as => 'rev_by_prod_result'
  get '/results/rev_by_prod/:product' => 'results#single_product', :as => 'single_product_result'
  get '/results/balance_sheet' => 'results#balance_sheet', :as => 'balance_sheet_result'
  get '/results' => 'results#rev_by_div'

  resources :results

  resources :account_details do
    collection do
      get 'decreased'
      get 'increased'
      get 'new_accounts'
      get 'summaries'
    end
  end

  resources :groups

  resources :users

  root :to => "results#rev_by_div"
end
