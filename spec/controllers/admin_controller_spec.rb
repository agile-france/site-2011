require 'spec_helper'

describe AdminController do
  context 'when not logged' do
    it 'redirects to home with a flash' do
      get :show
      response.should redirect_to(root_path)
    end
  end
end
