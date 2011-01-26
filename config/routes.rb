ConferenceOnRails::Application.routes.draw do
  # 1- devise
  devise_for :users, :controllers => {
    :sessions => 'auth/sessions',
    :registrations => 'auth/registrations',
    :omniauth_callbacks => 'auth/callbacks'
  }
  
  # 2- conferences and sessions 
  # :as option for sessions is used to unclash name with devise url helper (session_path(resource_or_scope namely))
  resources :sessions, :except => [:new, :create], :as => :awesome_sessions
  resources :conferences  do
    resources :sessions, :only => [:new, :create]
  end
  resources :place
  resources :sponsors
  resources :soon
  resources :history

  # admin interface
  namespace :admin do
    get '/' => 'admin#show'
    resources :users, :only => [:index, :edit, :update]
  end

  # bug there as of 3.0.0, infered controller is 'accounts'
  resource :account, :only => [:edit, :update, :destroy], :controller => 'account'

  root :to => 'home#index'
end
