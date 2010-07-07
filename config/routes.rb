ConferenceOnRails::Application.routes.draw do |map|
  get "home/index"

  devise_for :users
  root :to => 'home#index'
end
