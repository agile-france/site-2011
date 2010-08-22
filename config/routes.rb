ConferenceOnRails::Application.routes.draw do
  devise_for :users
  resources :sessions
  root :to => 'home#index'
end
