ConferenceOnRails::Application.routes do
  devise_for :users
  root :to => 'home#index'
end
