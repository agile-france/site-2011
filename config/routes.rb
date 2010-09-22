ConferenceOnRails::Application.routes.draw do
  # 1- devise
  devise_for :users
  
  # 2- sessions (watch out, it redefines session_path, above in Devise::Controllers::UrlHelpers)
  # and other domain entities
  resources :sessions, :except => [:new, :create]
  resources :conferences  do
    resources :sessions, :only => [:new, :create]
  end

  root :to => 'home#index'
end
