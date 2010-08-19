ConferenceOnRails::Application.routes.draw do
  devise_for :users
  root :to => 'home#index'
  
  resource :session
end
