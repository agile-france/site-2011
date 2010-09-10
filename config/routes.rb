ConferenceOnRails::Application.routes.draw do
  devise_for :users

  namespace 'party' do
    resources :sessions
  end

  # conferences
  scope :module => 'party' do
    get 'conferences/:name/:edition' => 'conferences#show'
  end

  root :to => 'home#index'
end
