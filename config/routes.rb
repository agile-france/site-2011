ConferenceOnRails::Application.routes.draw do
  devise_for :users

  namespace 'conference' do
    resources :sessions
  end
  
  root :to => 'home#index'
end
