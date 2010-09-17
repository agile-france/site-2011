ConferenceOnRails::Application.routes.draw do
  devise_for :users

  # conferences
  resources :conferences do
    resources :sessions
  end

  root :to => 'home#index'
end
