ConferenceOnRails::Application.routes.draw do
  devise_for :users

  namespace 'conference' do
    resources :sessions
  end

  # conferences
  scope :module => 'conference' do
    get 'conferences/:name/:edition' => 'conferences#show'
  end

  root :to => 'home#index'
end
