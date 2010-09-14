ConferenceOnRails::Application.routes.draw do
  devise_for :users

  # conferences
  scope :module => 'party' do
    resources :conferences do
      resources :sessions
    end
  end

  root :to => 'home#index'
end
