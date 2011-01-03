require 'spec_helper'

describe Admin::AdminController do
  context 'when not logged' do
    before do
      get :show
    end
    it 'redirects to sign in path' do
      response.should redirect_to(new_user_session_path)
    end
  end
  
  context "when signed in as a user" do
    before do
      user = Fabricate(:user)
      sign_in(user)
    end
    it 'redirects to conferences_path' do
      get :show
      response.should redirect_to(root_path)
    end
  end
end
